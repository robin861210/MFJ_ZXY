//
//  LeftViewController.m
//  ZXY
//
//  Created by acewill on 15/6/12.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "LeftViewController.h"
#import "CameraImage.h"
#import "DDMenuController.h"
#import "DecorateArchivesViewController.h"
#import "CalculatorViewController.h"
#import "ComplaintViewController.h"
#import "SettingViewController.h"



@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor orangeColor]];
    listIconArray = @[@"center_dec_archives@2x",@"center_dec_diary@2x",@"center_computer@2x",@"center_activity@2x",@"center_score_shop@2x",@"center_give_angry@2x",@"center_advice@2x",@"center_setting@2x"];
    listNameArray = @[@"装修档案",@"装修日记",@"装修计算器",@"优惠活动",@"积分商城",@"投诉建议",@"意见反馈",@"设置"];
    
    UIImageView *backgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backgImgView setImage:LoadImage(@"center_back@2x", @"png")];
    [self.view addSubview:backgImgView];

    [self setPersonCenterView];
    
    [self setFundutionCustomView];
    
    //初始化AFNetwork
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(updateHeadLogo:)];
}


//“个人信息”页面
- (void)setPersonCenterView
{
    //头像
    headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(75, 65, 75, 75)];
    headImgV.layer.cornerRadius = 37.5f;
    [headImgV.layer setMasksToBounds:YES];
    headImgV.userInteractionEnabled = YES;
    [headImgV setImageURLStr:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserLogo"] placeholder:LoadImage(@"head", @"jpg")];
    [headImgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPersonCenter:)]];

    [self.view addSubview:headImgV];
    
    //用户昵称
    UILabel *nickNameLab = [[UILabel alloc] initWithFrame:CGRectMake(155, 90, 130, 20)];
//    [nickNameLab setText:@"Melodo1019"];
    [nickNameLab setText:[[[ProjectInfoUtils sharedProjectInfoUtils] infoDic] objectForKey:@"ClientName"]];
    [nickNameLab setTextColor:[UIColor whiteColor]];
    [nickNameLab setTextAlignment:NSTextAlignmentLeft];
    [nickNameLab setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:nickNameLab];
    
    //积分
    UILabel *integralLab = [[UILabel alloc] initWithFrame:CGRectMake(155, 110, 130, 15)];
    [integralLab setText:@"当前积分：1250 可兑换"];
    [integralLab setTextColor:[UIColor whiteColor]];
    [integralLab setTextAlignment:NSTextAlignmentLeft];
    [integralLab setFont:[UIFont systemFontOfSize:11.0f]];
    [self.view addSubview:integralLab];
}

- (void)setFundutionCustomView
{
    listTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, 280, ScreenHeight-80) style:UITableViewStylePlain];
    [listTableV setBackgroundColor:[UIColor clearColor]];
    [listTableV setShowsHorizontalScrollIndicator:NO];
    [listTableV setScrollEnabled:NO];
    [listTableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    listTableV.delegate = self;
    listTableV.dataSource = self;
    [self.view addSubview:listTableV];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listNameArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        //图标
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, 12, 20, 20)];
        [iconImageView setImage:LoadImage([listIconArray objectAtIndex:indexPath.row], @"png")];
        [cell addSubview:iconImageView];
        
        //功能
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, 100, 20)];
        [label setText:[listNameArray objectAtIndex:indexPath.row]];
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setFont:[UIFont systemFontOfSize:18.0f]];
        [cell addSubview:label];
        
        //箭头
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 12, 20, 20)];
        [arrowImgView setImage:LoadImage(@"center_right@2x", @"png")];
        [cell addSubview:arrowImgView];
        
        //分割线
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 280, 10)];
        [lineImgView setImage:LoadImage(@"center_diviler@2x", @"png")];
        [cell addSubview:lineImgView];
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    
    [menuController showRootController:YES];
//    SettingViewController *settingVC = [[SettingViewController alloc] init];
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    
//    CustomNavigationController *navController = [[CustomNavigationController alloc] initWithRootViewController:mainVC];
////    [navController setToolbarHidden:NO animated:YES];
//
//    [menuController setRootController:navController animated:YES];
    
    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case 0:
            NSLog(@"装修档案");
        {
            DecorateArchivesViewController *decorateArchiveVC = [[DecorateArchivesViewController alloc] init];
            [decorateArchiveVC setTitle:@"装修档案"];
            viewController = decorateArchiveVC;
        }
            break;
        case 1:
            NSLog(@"装修日记");
            break;
        case 2:
            NSLog(@"装修计算器");
        {
            CalculatorViewController *calculatorVC = [[CalculatorViewController alloc] init];
            [calculatorVC setTitle:@"装修计算器"];
            viewController = calculatorVC;
        }
            break;
        case 3:
            NSLog(@"优惠活动");
            break;
        case 4:
            NSLog(@"积分商城");
            break;
        case 5:
            NSLog(@"投诉建议");
        {
            ComplaintViewController *complaintVC = [[ComplaintViewController alloc] init];
            [complaintVC setTitle:@"投诉建议"];
            viewController = complaintVC;
        }
            break;
        case 6:
            NSLog(@"意见反馈");
            break;
        case 7:
            NSLog(@"设置");
        {
            SettingViewController *settingVC = [[SettingViewController alloc] init];
            [settingVC setTitle:@"设置"];
            viewController = settingVC;
        }
            break;
            
        default:
            break;
    }
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:viewController,@"viewC", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToFunctionVC" object:nil userInfo:dict];
}

//点击个人中心按钮
- (void)clickPersonCenter:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"修改个人资料");
    //判断是否是游客身份，做权限设置
    if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"InvCode"] length] == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        [actionSheet showInView:self.view];
    }
}

#pragma mark--
#pragma UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"相机");
        [self addCarema];
    }else if(buttonIndex == 1)
    {
        NSLog(@"图库");
        [self openPicLibrary];
    }
}
//开发相机
- (void)addCarema {
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        functionFlag = YES;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES; //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

//打开照片库
- (void)openPicLibrary
{
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        functionFlag = NO;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES; //是否可以编辑
        
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

/* 选中图片进入的代理方法
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 */

//拍摄完成后要执行的方法 或 选中相册图片后执行的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [CameraImage setCameraImage:image];
    
    //图片存入相册
    if (functionFlag)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    //上传图片
    UIImage * uploadImg = [self scale:image toSize:CGSizeMake(300, 300)];
    NSData * uploadImgData = UIImagePNGRepresentation(uploadImg);
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:uploadImgData attributes:nil];
    //得到选择后沙盒中图片的完整路径
    NSString * filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
    
    //发发送 上传图片 请求
    [self sendUpdateLoadPicRequest:filePath];
    
    functionFlag = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击Cancel按钮后执行方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//打开闪光灯
- (void)openFlashlight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOff) {
        //Create an AV session
        AVCaptureSession * session = [[AVCaptureSession alloc]init];
        
        // Create device input and add to current session
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [session addInput:input];
        
        // Create video output and add to current session
        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
        [session addOutput:output];
        
        // Start session configuration
        [session beginConfiguration];
        [device lockForConfiguration:nil];
        
        // Set torch to on
        [device setTorchMode:AVCaptureTorchModeOn];
        
        [device unlockForConfiguration];
        [session commitConfiguration];
        
        // Start the session
        [session startRunning];
        
        // Keep the session around
        [self setAVSession:self.AVSession];
    }
}

//关闭上光灯
- (void)closeFlashlight
{
    [self.AVSession stopRunning];
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

- (void)sendUpdateLoadPicRequest:(NSString *)headImgData
{
    [self showProgressView];

    [interface setInterfaceDidFinish:@selector(updateFileResult:)];
    [interface uploadFileURL:UpdateLoadPic filePath:headImgData keyName:@"picture" params:nil];
}

- (void)updateFileResult:(NSDictionary *)updateResult
{
    NSLog(@"上传文件：%@",updateResult);
    if ([[updateResult objectForKey:@"Code"] intValue] == 0 && [[updateResult objectForKey:@"Msg"] length] == 7) {
        //UpdateHeadLogo?MachineID=aabbcc&UserID=13112344321&ClientID=1234&Logo=aaaa.jpg
        
        NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
        [postData setValue:[updateResult objectForKey:@"Response"] forKey:@"Logo"];
        headUrl = [NSString stringWithFormat:@"http://218.25.17.238:8016/pictmp/%@",[updateResult objectForKey:@"Response"]];
        [interface setInterfaceDidFinish:@selector(updateHeadLogo:)];
        [interface sendRequest:UpdateHeadLogo Parameters:postData Type:get_request];
    }else
    {
        [self dismissProgressView:@"上传失败"];
    }
}

- (void)updateHeadLogo:(NSDictionary *)updateHeadResult
{
    NSLog(@"%@",updateHeadResult);
    if ([[updateHeadResult objectForKey:@"Code"] intValue] == 0 && [[updateHeadResult objectForKey:@"Msg"] length] == 7) {
        [self dismissProgressView:@"上传头像成功"];
        //1、是再次请求getProject接口  2、还是直接将上传文件拼接显示  简单起见：目前第二种
        //        NSMutableDictionary *proDic = [[NSMutableDictionary alloc] initWithDictionary:[[ProjectInfoUtils sharedProjectInfoUtils] infoDic]];
        //        [proDic setValue:headUrl forKey:@"ProjectLogo"];
        //        [ProjectInfoUtils setProjectInfoData:proDic];
        //        [personCenterView.headImgView setImageURLStr:headUrl placeholder:LoadImage(@"placeholder@2x", @"png")];
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[[UserInfoUtils sharedUserInfoUtils] infoDic]];
        [userDic setValue:headUrl forKey:@"UserLogo"];
        [UserInfoUtils setUserInfoData:userDic];
        [headImgV setImageURLStr:headUrl placeholder:LoadImage(@"placeholder@2x", @"png")];
        
    }else
    {
        [self dismissProgressView:[updateHeadResult objectForKey:@"Msg"]];
    }
}



#pragma mark - ProgressView Delegate
- (void)showProgressView {
    [progressView removeFromSuperview];
    progressView = [[MRProgressOverlayView alloc] init];
    progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    [self.view addSubview:progressView];
    
    [progressView show:YES];
}
- (void)dismissProgressView:(NSString *)titleStr {
    if (titleStr.length > 0) {
        [progressView setTitleLabelText:titleStr];
        [progressView performBlock:^{
            [progressView dismiss:YES];
        }afterDelay:0.8f];
    }else {
        [progressView dismiss:YES];
    }
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
