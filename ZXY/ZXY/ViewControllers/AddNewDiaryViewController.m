//
//  AddNewDiaryViewController.m
//  ZXY
//
//  Created by soldier on 15/7/1.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "AddNewDiaryViewController.h"
#import "ZLPickerViewController.h"
#import "UIView+Extension.h"
#import "ZLPickerBrowserViewController.h"
#import "ZLPickerCommon.h"
#import "ZLAnimationBaseView.h"
#import "UIImageView+WebCache.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLCameraViewController.h"
#import "ZLAnimationBaseView.h"

@interface AddNewDiaryViewController ()<ZLPickerViewControllerDelegate,ZLPickerBrowserViewControllerDataSource,ZLPickerBrowserViewControllerDelegate>

@property (nonatomic , strong) NSMutableArray *assets;

@property (nonatomic , strong) UIImageView *currentImageView;
@property (nonatomic , strong) ZLPickerBrowserViewController *pickerBrowser;
@property (nonatomic , strong) ZLCameraViewController *cameraVc;


@end

@implementation AddNewDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.assets = [[NSMutableArray alloc] init];
    
    chooseMarkVC = [[ChooseMarkViewController alloc] init];
    choosePhaseVC = [[ChoosePhaseViewController alloc] init];
    
    [self setAddNewDiaryCustomView];

    [self setAddDiaryBarButton];
    
}

//设置右导航“发送”按钮addNavigationRightItem
- (void)setAddDiaryBarButton
{
    UIButton *sendAddDiaryBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [sendAddDiaryBt setTitle:@"发送" forState:UIControlStateNormal];
    [sendAddDiaryBt setTitleColor:UIColorFromHex(0x35c083) forState:UIControlStateNormal];
    sendAddDiaryBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [sendAddDiaryBt addTarget:self action:@selector(sendAddNewDiaryRequest:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:sendAddDiaryBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];
    
}


- (void)setAddNewDiaryCustomView
{
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, 10*ScreenHeight/568, 310*ScreenWidth/320, 150*ScreenHeight/568)];
    [contentTextView setEditable:YES];
    [contentTextView setTextColor:UIColorFromHex(0x999999)];
    [contentTextView setText:@"记录/分享装修的酸甜苦辣……"];
    [contentTextView setFont:[UIFont systemFontOfSize:13.0f]];
    [contentTextView setDelegate:self];
    [contentTextView setReturnKeyType:UIReturnKeyDone];
    [contentTextView setKeyboardType:UIKeyboardTypeDefault];
    [contentTextView setScrollEnabled:YES];
    [contentTextView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:contentTextView];
    
    _edited = YES;

    
    //添加照片
    //照片View
    photoView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:photoView];
    
    otherView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:otherView];

    //拍照按钮
    [self setButtonImageView:self.assets];
    
    //装修阶段
    [self createDiaryBtn:CGRectMake(0, 0, ScreenWidth, 35*ScreenHeight/568) WithTitleLabText:@"装修阶段" WithBtnTag:201 WithIcon:LoadImage(@"", @"png")];
    zxPhaseLab = [[UILabel alloc] initWithFrame:CGRectMake(190*ScreenWidth/320, 0, 100*ScreenWidth/320, 35*ScreenHeight/568)];
    [zxPhaseLab setText:@"准备"];
    [zxPhaseLab setTextAlignment:NSTextAlignmentRight];
    [zxPhaseLab setFont:[UIFont systemFontOfSize:13.0f]];
    [zxPhaseLab setTextColor:[UIColor grayColor]];
    [otherView addSubview:zxPhaseLab];
    
    //装修标签
    [self createDiaryBtn:CGRectMake(0, 35*ScreenHeight/568, ScreenWidth, 35*ScreenHeight/568) WithTitleLabText:@"装修标签" WithBtnTag:202 WithIcon:LoadImage(@"", @"png")];
    zxMarkLab = [[UILabel alloc] initWithFrame:CGRectMake(190*ScreenWidth/320, 35*ScreenHeight/568, 100*ScreenWidth/320, 35*ScreenHeight/568)];
    [zxMarkLab setText:@"碎碎念"];
    [zxMarkLab setTextAlignment:NSTextAlignmentRight];
    [zxMarkLab setFont:[UIFont systemFontOfSize:13.0f]];
    [zxMarkLab setTextColor:[UIColor grayColor]];
    [otherView addSubview:zxMarkLab];
    
    //装修日期
    [self createDiaryBtn:CGRectMake(0, 70*ScreenHeight/568, ScreenWidth, 35*ScreenHeight/568) WithTitleLabText:@"日期" WithBtnTag:203 WithIcon:LoadImage(@"", @"png")];
    zxDateLab = [[UILabel alloc] initWithFrame:CGRectMake(190*ScreenWidth/320, 70*ScreenHeight/568, 100*ScreenWidth/320, 35*ScreenHeight/568)];
    [zxDateLab setText:@"2015年6月19日"];
    [zxDateLab setTextAlignment:NSTextAlignmentRight];
    [zxDateLab setFont:[UIFont systemFontOfSize:13.0f]];
    [zxDateLab setTextColor:[UIColor grayColor]];
    [otherView addSubview:zxDateLab];
    
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
    [photoView setFrame:CGRectMake(0, 170*ScreenHeight/568, ScreenWidth,[photoArray count]/4*75*ScreenHeight/568+80*ScreenHeight/568)];
    [otherView setFrame:CGRectMake(0, photoView.frame.size.height +photoView.frame.origin.y, ScreenWidth, 105*ScreenHeight/568)];
}

- (UIButton *)createDiaryBtn:(CGRect)frame WithTitleLabText:(NSString *)titleText WithBtnTag:(NSInteger)index WithIcon:(UIImage *)iconImg
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.borderColor = [RGBACOLOR(234, 235, 237, 1) CGColor];
    button.layer.borderWidth = 0.5f;
    [button addTarget:self action:@selector(chooseDiaryOptions:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:index];
    
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, (frame.size.height-20)/2, 20 ,20)];
    [iconImgV setImage:iconImg];
    [button addSubview:iconImgV];
    
    //标题
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(35*ScreenWidth/320, 0, 60*ScreenWidth/320, frame.size.height)];
    [titleLab setText:titleText];
    [titleLab setTextAlignment:NSTextAlignmentLeft];
    [titleLab setFont:[UIFont systemFontOfSize:13.0f]];
    [button addSubview:titleLab];
    
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 30, (frame.size.height-17)/2, 17, 17)];
    [arrowImgV setImage:LoadImage(@"arrow@2x", @"png")];
    [button addSubview:arrowImgV];
    
    [otherView addSubview:button];
    
    return button;
}

//选择 日记 信息按钮
- (void)chooseDiaryOptions:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 201:
            NSLog(@"选择  装修阶段 ");
            [choosePhaseVC setTitle:@"装修阶段"];
            [choosePhaseVC setDelegate:self];
            [self.navigationController pushViewController:choosePhaseVC animated:YES];
            break;
        case 202:
            NSLog(@"选择  装修标签 ");
            [chooseMarkVC setTitle:@"选择标签"];
            [chooseMarkVC setDelegate:self];
            [self.navigationController pushViewController:chooseMarkVC animated:YES];
            break;
        case 203:
            NSLog(@"选择  装修日期 ");
            break;
            
        default:
            break;
    }
}

#pragma mark--
#pragma ChoosePhaseVCDelegate
- (void)setPhaseLabelText:(NSString *)labelT
{
    [zxPhaseLab setText:labelT];
}

#pragma mark-- 
#pragma ChooseMarkVCDelegate
- (void)setMarkLabelText:(NSString *)labelT
{
    [zxMarkLab setText:labelT];
}



//添加日记按钮
- (void)sendAddNewDiaryRequest:(id)sender
{
    NSLog(@"发送 添加日记");
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



#pragma mark--
#pragma UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_edited) {
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        [textView setText:@"记录/分享装修的酸甜苦辣……"];
        [textView setTextColor:UIColorFromHex(0x999999)];
        _edited = YES;
    }else{
        _edited = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
//    if (range.location >=100) {
//        [contentTextView.text substringToIndex:100];
//        return NO;
//    }
    return YES;
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
