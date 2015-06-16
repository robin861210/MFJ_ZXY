//
//  ComplaintViewController.m
//  ZXY
//
//  Created by soldier on 15/6/14.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ComplaintViewController.h"
#import "ZLPickerViewController.h"
#import "UIView+Extension.h"
#import "ZLPickerBrowserViewController.h"
#import "ZLPickerCommon.h"
#import "ZLAnimationBaseView.h"
#import "UIImageView+WebCache.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLCameraViewController.h"
#import "ZLAnimationBaseView.h"

@interface ComplaintViewController ()<ZLPickerViewControllerDelegate,ZLPickerBrowserViewControllerDataSource,ZLPickerBrowserViewControllerDelegate>

@property (nonatomic , strong) NSMutableArray *assets;

@property (nonatomic , strong) UIImageView *currentImageView;
@property (nonatomic , strong) ZLPickerBrowserViewController *pickerBrowser;
@property (nonatomic , strong) ZLCameraViewController *cameraVc;

@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    
    self.assets = [[NSMutableArray alloc] init];
    
    titleArray = @[@"工程地址",@"用户姓名",@"联系电话",@"投诉/建议内容"];
    
    [self setComplaintCustomView];
}

- (void)setComplaintCustomView
{
    //背景View
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, ScreenWidth, ScreenHeight - 74)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    
    //标题 //分割线
    for (int i = 0; i<[titleArray count]; i++) {
        //标题
        UILabel *titleLab = [[UILabel alloc] init];
        [titleLab setFrame:CGRectMake(5, i*30*ScreenHeight/568, 55*ScreenWidth/320, 30*ScreenHeight/568)];
//        [titleLab setBackgroundColor:[UIColor greenColor]];
        [titleLab setText:[titleArray objectAtIndex:i]];
        [titleLab setTextAlignment:NSTextAlignmentLeft];
        [titleLab setFont:[UIFont systemFontOfSize:13.0f]];
        [titleLab setNumberOfLines:0];
        [titleLab setLineBreakMode:NSLineBreakByCharWrapping];
        [bgView addSubview:titleLab];
        
        //分割线
        UIView *lineView = [[UIView alloc] init];
        [lineView setFrame:CGRectMake(0, (i+1)*30*ScreenHeight/568, ScreenWidth, 1.0f)];
        [lineView setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        [bgView addSubview:lineView];
        
        if (i == 3) {
            [titleLab setFrame:CGRectMake(5, i*30*ScreenHeight/568, 55*ScreenWidth/320, 60*ScreenHeight/568)];
            [lineView setFrame:CGRectMake(0, i*30*ScreenHeight/568+70, ScreenWidth, 1.0f)];
        }
    }

    //工程地址
    addressTextF = [self createUITextFieldObjectWithFrame:CGRectMake(80*ScreenWidth/320, 0, 240*ScreenWidth/320, 30*ScreenHeight/568)];
    [bgView addSubview:addressTextF];
    
    //用户姓名
    unameTextF = [self createUITextFieldObjectWithFrame:CGRectMake(80*ScreenWidth/320, 30*ScreenHeight/568, 240*ScreenWidth/320, 30*ScreenHeight/568)];
    [bgView addSubview:unameTextF];
    
    //联系电话
    telphoneTextF = [self createUITextFieldObjectWithFrame:CGRectMake(80*ScreenWidth/320, 60*ScreenHeight/568, 240*ScreenWidth/320, 30*ScreenHeight/568)];
    [bgView addSubview:telphoneTextF];
    
    //投诉/建议内容
    contentTextF = [self createUITextFieldObjectWithFrame:CGRectMake(80*ScreenWidth/320, 90*ScreenHeight/568, 240*ScreenWidth/320, 30*ScreenHeight/568)];
    [bgView addSubview:contentTextF];
    
    //添加照片
    //照片View
    photoView = [[UIView alloc] initWithFrame:CGRectZero];
    [photoView setBackgroundColor:[UIColor whiteColor]];
    [bgView addSubview:photoView];
    
    //拍照按钮
    [self setButtonImageView:self.assets];
}

//创建UITextField
- (UITextField *)createUITextFieldObjectWithFrame:(CGRect)frame
{
    UITextField *textF = [[UITextField alloc] initWithFrame:frame];
    [textF setDelegate:self];
    //    [textF setSecureTextEntry:YES];
    [textF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [textF setReturnKeyType:UIReturnKeyDone];
    [textF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textF setKeyboardType:UIKeyboardTypeDefault];
    [textF setTextColor:[UIColor blackColor]];
    [textF setTextAlignment:NSTextAlignmentLeft];
    
    return textF;
}

- (void)setButtonImageView:(NSMutableArray *)photoArray
{
    for (int i = 0; i<[photoArray count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setFrame:CGRectMake(8*ScreenWidth/320+i%4*(78* ScreenWidth/320),5*ScreenHeight/568+ i/4*(75*ScreenHeight/568),70* ScreenWidth/320, 70*ScreenHeight/568)];
        [imageView setTag:(100000+i)];
        imageView.userInteractionEnabled = YES;
        [photoView addSubview:imageView];
        
        ALAsset *asset = self.assets[i];
        if ([asset isKindOfClass:[ALAsset class]]) {
            imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
        }else if ([asset isKindOfClass:[NSString class]]){
            //            [imageView setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"wallpaper_placeholder"]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"wallpaper_placeholder"]];
        }else if([asset isKindOfClass:[UIImage class]]){
            imageView.image = (UIImage *)asset;
        }
        
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setupPhotoBrowser:)]];
    }
    //添加照片按钮
    UIButton *addPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addPhotoBtn.layer.borderColor = [[UIColor grayColor] CGColor];
//    addPhotoBtn.layer.borderWidth = 0.5f;
    [addPhotoBtn setImage:LoadImage(@"addPhoto@2x", @"png") forState:UIControlStateNormal];
    [addPhotoBtn addTarget:self action:@selector(selectPhotos) forControlEvents:UIControlEventTouchUpInside];
    [photoView addSubview:addPhotoBtn];
    
    if ([self.assets count] >= 9) {
        [addPhotoBtn setHidden:YES];
    }else
    {
        [addPhotoBtn setHidden:NO];
    }
    
    [addPhotoBtn setFrame:CGRectMake(8*ScreenWidth/320+[photoArray count]%4*(78* ScreenWidth/320),5*ScreenHeight/568+ [photoArray count]/4*(75*ScreenHeight/568),70* ScreenWidth/320, 70*ScreenHeight/568)];
    [photoView setFrame:CGRectMake(0, 150*ScreenHeight/568, ScreenWidth,[photoArray count]/4*75*ScreenHeight/568+80*ScreenHeight/568)];
}
//选取照片
- (void)selectPhotos {
    
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    cameraVc.cameraArray = self.assets;
    __weak typeof(self) weakSelf = self;
    [cameraVc startCameraOrPhotoFileWithViewController:self complate:^(id object) {
        [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [weakSelf.assets addObjectsFromArray:[obj allValues]];
            }else{
                [weakSelf.assets addObject:obj];
            }
        }];
        //        [weakSelf.tableView reloadData];
        NSLog(@"%@",self.assets);
        [self setButtonImageView:self.assets];
    }];
    self.cameraVc = cameraVc;
    
    // 可以用下面来创建ZLPickerViewController, 就没有拍照的选项了
    /*
     // 创建控制器
     ZLPickerViewController *pickerVc = [[ZLPickerViewController alloc] init];
     // 默认显示相册里面的内容SavePhotos
     pickerVc.status = PickerViewShowStatusCameraRoll;
     // 选择图片的最大数
     // pickerVc.maxCount = 4;
     pickerVc.delegate = self;
     [pickerVc show];
     */
    
    /**
     *
     传值可以用代理，或者用block来接收，以下是block的传值
     __weak typeof(self) weakSelf = self;
     pickerVc.callBack = ^(NSArray *assets){
     weakSelf.assets = assets;
     [weakSelf.tableView reloadData];
     };
     */
    
    
}

//#pragma mark <ZLPickerBrowserViewControllerDataSource>
- (NSInteger) numberOfPhotosInPickerBrowser:(ZLPickerBrowserViewController *)pickerBrowser{
    return self.assets.count;
}

- (ZLPickerBrowserPhoto *) photoBrowser:(ZLPickerBrowserViewController *)pickerBrowser photoAtIndex:(NSUInteger)index{
    
    id imageObj = [self.assets objectAtIndex:index];
    ZLPickerBrowserPhoto *photo = [ZLPickerBrowserPhoto photoAnyImageObjWith:imageObj];
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:index-100000];
    photo.thumbImage = imageView.image;
    
    return photo;
}



- (void)setupPhotoBrowser:(UITapGestureRecognizer *)imageTap{
    // 图片游览器
    ZLPickerBrowserViewController *pickerBrowser = [[ZLPickerBrowserViewController alloc] init];
    // 传入点击图片View的话，会有微信朋友圈照片的风格
    pickerBrowser.toView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
    // 数据源/delegate
    pickerBrowser.delegate = self;
    pickerBrowser.dataSource = self;
    // 是否可以删除照片
    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentPage = imageTap.view.tag -100000;
    // 展示控制器
    [pickerBrowser show];
    self.pickerBrowser = pickerBrowser;
}

#pragma mark <ZLPickerBrowserViewControllerDelegate>
- (void)photoBrowser:(ZLPickerBrowserViewController *)photoBrowser removePhotoAtIndex:(NSUInteger)index{
    if (index > self.assets.count) return;
    [self.assets removeObjectAtIndex:index];
    for (UIView *view in [photoView subviews]) {
        [view removeFromSuperview];
    }
    [self setButtonImageView:self.assets];
}

// 代理回调方法
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    [self.assets addObjectsFromArray:assets];
    for (UIView *view in [photoView subviews]) {
        [view removeFromSuperview];
    }
    [self setButtonImageView:self.assets];
}




//压缩图片
-(UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [addressTextF resignFirstResponder];
    [unameTextF resignFirstResponder];
    [telphoneTextF resignFirstResponder];
    [contentTextF resignFirstResponder];
    
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [addressTextF resignFirstResponder];
    [unameTextF resignFirstResponder];
    [telphoneTextF resignFirstResponder];
    [contentTextF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
