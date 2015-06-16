//
//  LoginViewController.m
//  ZXYY
//
//  Created by hndf on 15-4-1.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setLoginCustomView];
    
    //初始化AFNetwork
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(loginNetworkResult:)];
}

//设置登陆页面视图
- (void)setLoginCustomView
{
    //logo
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 125*ScreenWidth/320)/2, 30*ScreenHeight/568,125*ScreenWidth/320, 125*ScreenWidth/320)];
    [logoImgView setImage:LoadImage(@"icon-60@3x", @"png")];
    [self.view addSubview:logoImgView];
    
    //分割线
    for (int i = 0; i<3; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 185*ScreenHeight/568 +45*ScreenHeight/568 *i, ScreenWidth, 1.0f)];
        [lineView setBackgroundColor:UIColorFromHex(0xebebeb)];
        [self.view addSubview:lineView];
    }
    
    //用户名
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 185*ScreenHeight/568, 50*ScreenWidth/320, 45*ScreenHeight/568)];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setText:@"账号"];
    [userNameLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [userNameLabel setTextColor:[UIColor blackColor]];
    [userNameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:userNameLabel];
    
    userNameTf = [[UITextField alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, userNameLabel.frame.origin.y, ScreenWidth-userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
    [userNameTf setDelegate:self];
    [userNameTf setTag:90];
    [userNameTf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [userNameTf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [userNameTf setReturnKeyType:UIReturnKeyDone];
    [userNameTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userNameTf setKeyboardType:UIKeyboardTypeDefault];
    [userNameTf setPlaceholder:@"请输入用户名"];
    [userNameTf setTextColor:[UIColor blackColor]];
    [userNameTf setTextAlignment:NSTextAlignmentLeft];
    [userNameTf setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:userNameTf];
    
    //密码
    UILabel *passWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, userNameLabel.frame.size.height + userNameLabel.frame.origin.y,userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
    [passWordLabel setBackgroundColor:[UIColor clearColor]];
    [passWordLabel setText:@"密码"];
    [passWordLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [passWordLabel setTextColor:[UIColor blackColor]];
    [passWordLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:passWordLabel];
    
    passWordTf = [[UITextField alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, passWordLabel.frame.origin.y, ScreenWidth-passWordLabel.frame.size.width, passWordLabel.frame.size.height)];
    [passWordTf setDelegate:self];
    [passWordTf setTag:91];
    [passWordTf setSecureTextEntry:YES];
    [passWordTf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [passWordTf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [passWordTf setReturnKeyType:UIReturnKeyDone];
    [passWordTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [passWordTf setKeyboardType:UIKeyboardTypeDefault];
    [passWordTf setPlaceholder:@"请输入密码"];
    [passWordTf setTextColor:[UIColor blackColor]];
    [passWordTf setTextAlignment:NSTextAlignmentLeft];
    [passWordTf setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:passWordTf];
    
    //“登录”按钮
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 300*ScreenHeight/568, ScreenWidth-10, 40*ScreenHeight/568)];
    [loginBtn setBackgroundColor:UIColorFromHex(0x60d3c4)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 2.0f;
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //邀请码登录 按钮
    UIButton *inviteCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inviteCodeBtn setFrame:CGRectMake(5, 350*ScreenHeight/568, (ScreenWidth-20)/2, 40*ScreenHeight/568)];
    [inviteCodeBtn setBackgroundColor:[UIColor whiteColor]];
    inviteCodeBtn.layer.cornerRadius = 3.0f;
    inviteCodeBtn.layer.borderColor = [UIColorFromHex(0x60d3c4) CGColor];
    inviteCodeBtn.layer.borderWidth = 1.0f;
    [inviteCodeBtn addTarget:self action:@selector(clickInviteCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inviteCodeBtn];
    
    UIImageView *inviteImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7*ScreenHeight/568, 26*ScreenHeight/568, 26*ScreenHeight/568)];
    [inviteImgV setImage:LoadImage(@"invScanBtn@2x", @"png")];
    [inviteCodeBtn addSubview:inviteImgV];
    
    UILabel *inviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(inviteImgV.frame.size.width +inviteImgV.frame.origin.x, 0, inviteCodeBtn.frame.size.width-inviteImgV.frame.size.width, inviteCodeBtn.frame.size.height)];
    [inviteLabel setText:@"邀请码登录"];
    [inviteLabel setTextAlignment:NSTextAlignmentCenter];
    [inviteLabel setTextColor:[UIColor blackColor]];
    [inviteLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [inviteCodeBtn addSubview:inviteLabel];
    
    //二维码登录 按钮
    UIButton *qrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qrCodeBtn setFrame:CGRectMake(15 +inviteCodeBtn.frame.size.width, 350*ScreenHeight/568, (ScreenWidth-20)/2, 40*ScreenHeight/568)];
    [qrCodeBtn setBackgroundColor:[UIColor whiteColor]];
    qrCodeBtn.layer.cornerRadius = 3.0f;
    qrCodeBtn.layer.borderColor = [UIColorFromHex(0x60d3c4) CGColor];
    qrCodeBtn.layer.borderWidth = 1.0f;
    [qrCodeBtn addTarget:self action:@selector(clickQrCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qrCodeBtn];
    
    UIImageView *qrCodeImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7*ScreenHeight/568, 26*ScreenHeight/568, 26*ScreenHeight/568)];
    [qrCodeImgV setImage:LoadImage(@"qrScanBtn@2x", @"png")];
    [qrCodeBtn addSubview:qrCodeImgV];
    
    UILabel *qrLabel = [[UILabel alloc] initWithFrame:CGRectMake(qrCodeImgV.frame.size.width +qrCodeImgV.frame.origin.x, 0, qrCodeBtn.frame.size.width-qrCodeImgV.frame.size.width, qrCodeBtn.frame.size.height)];
    [qrLabel setText:@"二维码登录"];
    [qrLabel setTextAlignment:NSTextAlignmentCenter];
    [qrLabel setTextColor:[UIColor blackColor]];
    [qrLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [qrCodeBtn addSubview:qrLabel];
    
}

//登录
- (void)clickLoginBtn:(id)sender
{
    [self keyBoardDownAndTextFieldHidden];
    NSLog(@"~~~~~~~~  登录 ！~~~~~~~~~~~~");
    if (userNameTf.text == nil||[userNameTf.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号不能为空,请重新输入。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else if(passWordTf.text == nil||[passWordTf.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空,请重新输入。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        [self sendLoginNetWorkRequest];
    }

}

//邀请码登录
- (void)clickInviteCodeBtn:(id)sender
{
    [self keyBoardDownAndTextFieldHidden];
    NSLog(@"~~~~~~~~  邀请码登录 ！~~~~~~~~~~~~");
    InviteLoginViewController *inviteLoginVC = [[InviteLoginViewController alloc] init];
    [inviteLoginVC setTitle:@"邀请码登录"];
    [self.navigationController pushViewController:inviteLoginVC animated:YES];
}

//二维码登录
- (void)clickQrCodeBtn:(id)sender
{
    [self keyBoardDownAndTextFieldHidden];
    NSLog(@"~~~~~~~~  二维码登录 ！~~~~~~~~~~~~");
    QrCodeViewController *qrCodeVC = [[QrCodeViewController alloc] init];
    [qrCodeVC setDelegate:self];
    [qrCodeVC setTitle:@"扫描二维码"];
    [self presentViewController:qrCodeVC animated:YES completion:^{}];
}


- (void)sendLoginNetWorkRequest
{
    [self showProgressView];
    //    [networkData startGet:@"UserLogin?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&UserName=ym15898765432&PassWD=Aa1234" tag:0];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        NSLog(@"请打开您的位置服务!");
//        if ([[UserInfoUtils sharedUserInfoUtils] isEmpty])            //判断是否有地址信息
        if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lat"] length] == 0 &&[[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lon"] length] == 0 && [[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"LocaDesc"] length] == 0)
        {
            //存入沙盒
            NSMutableDictionary *addressInfoDic = [[NSMutableDictionary alloc] init];
            [addressInfoDic setValue:@"38.76623" forKey:@"Lat"];
            [addressInfoDic setValue:@"116.43213" forKey:@"Lon"];
            [addressInfoDic setValue:@"辽宁省沈阳市中山路15号3-5-3" forKey:@"LocaDesc"];
            [UserInfoUtils setUserInfoData:addressInfoDic];
        }else
        {
            NSMutableDictionary *addressInfoDic = [[UserInfoUtils sharedUserInfoUtils] infoDic];
            [addressInfoDic setValue:@"38.76623" forKey:@"Lat"];
            [addressInfoDic setValue:@"116.43213" forKey:@"Lon"];
            [addressInfoDic setValue:@"辽宁省沈阳市中山路15号3-5-3" forKey:@"LocaDesc"];
            NSLog(@"%@",[[UserInfoUtils sharedUserInfoUtils] infoDic]);
            [UserInfoUtils setUserInfoData:addressInfoDic];
        }
    }else
    {
//        if ([[UserInfoUtils sharedUserInfoUtils] isEmpty])        //判断是否有地址信息
        if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lat"] length] == 0 &&[[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lon"] length] == 0 && [[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"LocaDesc"] length] == 0)
        {
            //存入沙盒
            NSMutableDictionary *addressInfoDic = [[NSMutableDictionary alloc] init];
            [addressInfoDic setValue:@"38.76623" forKey:@"Lat"];
            [addressInfoDic setValue:@"116.43213" forKey:@"Lon"];
            [addressInfoDic setValue:@"辽宁省沈阳市中山路15号3-5-3" forKey:@"LocaDesc"];
            [UserInfoUtils setUserInfoData:addressInfoDic];
        }
    }
    if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] length] == 0) {
        [postData setValue:@"aabbcc" forKey:@"MachineID"];
        NSMutableDictionary *machineDic = [[UserInfoUtils sharedUserInfoUtils] infoDic];
        [machineDic setValue:@"aabbcc" forKey:@"MachineID"];
        [UserInfoUtils setUserInfoData:machineDic];
    }
    else{
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    }
    [postData setValue:userNameTf.text forKey:@"UserName"];
    [postData setValue:passWordTf.text forKey:@"PassWD"];
    
    [interface sendRequest:UserLogin Parameters:postData Type:get_request];
}

#pragma mark--
#pragma NetWorkResult
- (void)loginNetworkResult:(NSDictionary *)loginResult
{
    NSLog(@"%@",loginResult);
    NSLog(@"~~~ Result :%@ ~~~",[loginResult objectForKey:@"Code"]);
    NSLog(@"%@",[loginResult objectForKey:@"Msg"]);
    
    if ([[loginResult objectForKey:@"Code"] intValue] == 0 &&
        [[loginResult objectForKey:@"Msg"] length] == 7) {
        NSLog(@"~~~~~~~~~~~~ 登录成功 ~~~~~~~~~~");
        //存入本地
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[[FilterData filterNerworkData:[loginResult objectForKey:@"Response"]] objectAtIndex:0]];
//        [userInfoDic setValue:@"aabbcc" forKey:@"Mac hineID"];
        [userInfoDic setValue:@"0" forKey:@"EaseMobLoginStatus"];
        NSLog(@"%@",[[UserInfoUtils sharedUserInfoUtils] infoDic]);
        NSMutableDictionary *infoDic = [[UserInfoUtils sharedUserInfoUtils] infoDic];
        [infoDic setValuesForKeysWithDictionary:userInfoDic];
        [UserInfoUtils setUserInfoData:infoDic];
        NSLog(@"%@",[[UserInfoUtils sharedUserInfoUtils] infoDic]);
        
        //存储用户信息到环信
        [EMobUserInfo setEmobInfoDataWithUserId:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"IMLoginID"] userNickName:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"IMNick"] userIcon:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserLogo"]];
        
        //发送获取施工工作请求
        NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
        [interface setInterfaceDidFinish:@selector(getProjectNetworkResult:)];
        NSLog(@"%@",NSHomeDirectory());
        [interface sendRequest:GetProject Parameters:postData Type:get_request];
    }else if([[loginResult objectForKey:@"Code"] integerValue] >0)
    {
        [self dismissProgressView:[loginResult objectForKey:@"Msg"]];
    }else{
        NSLog(@"登录请求返回错误码：%@，错误信息：%@",[loginResult objectForKey:@"Code"],[loginResult objectForKey:@"Msg"]);
        [self dismissProgressView:[loginResult objectForKey:@"Msg"]];
    }

}

- (void)getProjectNetworkResult:(NSDictionary *)getProjectResult
{
    if ([[getProjectResult objectForKey:@"Code"] integerValue] == 0 &&
        [[getProjectResult objectForKey:@"Msg"] length] == 7) {
        NSLog(@"~~~~~~~~~~~~ 获取成功 ~~~~~~~~~~");
        //存入本地
        //        [FilterData filterNerworkData:[loginResult objectForKey:@"Response"]];
        NSMutableDictionary *projectInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[[FilterData filterNerworkData:[getProjectResult objectForKey:@"Response"]] objectAtIndex:0]];
        [ProjectInfoUtils setProjectInfoData:projectInfoDic];
//        [((AppDelegate *)[UIApplication sharedApplication].delegate) enterHomeViewController];
        [self sendHomeNetWorkRequest];
    }else if([[getProjectResult objectForKey:@"Code"] integerValue] >0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[getProjectResult objectForKey:@"Msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        NSLog(@"获取工地请求返回错误码：%@，错误信息：%@",[getProjectResult objectForKey:@"Code"],[getProjectResult objectForKey:@"Msg"]);
        [self dismissProgressView:[getProjectResult objectForKey:@"Msg"]];
    }

}

- (void)sendHomeNetWorkRequest
{
    //   GetHomePage?MachineID=aabbcc&UserID=334&ClientID=325
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    NSLog(@"%@",NSHomeDirectory());
//    if ([[UserInfoUtils sharedUserInfoUtils] isEmpty])
    if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] length] == 0 && [[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] length] == 0)
    {
        [postData setValue:@"" forKey:@"MachineID"];
        [postData setValue:@"" forKey:@"UserID"];
        [postData setValue:@"" forKey:@"ClientID"];
        [postData setValue:@"" forKey:@"sessionid"];
    }else
    {
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    }
    
    [interface setInterfaceDidFinish:@selector(homeNetworkResult:)];
    [interface sendRequest:GetHomePage Parameters:postData Type:get_request];
}


#pragma mark--
#pragma NetWorkResult
- (void)homeNetworkResult:(NSDictionary *)homeResult
{
    //[progressView dismiss:YES];
    NSLog(@"%@",homeResult);
    NSLog(@"~~~ Result :%@ ~~~",[homeResult objectForKey:@"Code"]);
    NSLog(@"%@",[homeResult objectForKey:@"Msg"]);
    
    if ([[homeResult objectForKey:@"Code"] intValue] == 0 &&
        [[homeResult objectForKey:@"Msg"] length] == 7) {
        NSLog(@"~~~~~~~~~~~~首页请求成功 ~~~~~~~~~~");
        /*  ~~~~~~~  首页 三个 图片 ，目前为空
         [introductionBtn setImageWithURL:[NSURL URLWithString:[[[homeResult objectForKey:@"Response"] objectAtIndex:0] objectForKey:@"AboutURL"]] forState:UIControlStateNormal placeholderImage:LoadImage(@"comIntr@2x", @"jpg")];
         [productBtn setImageWithURL:[NSURL URLWithString:[[[homeResult objectForKey:@"Response"] objectAtIndex:0] objectForKey:@"AboutURL"]] forState:UIControlStateNormal placeholderImage:LoadImage(@"comPro@2x", @"jpg")];
         [serviceBtn setImageWithURL:[NSURL URLWithString:[[[homeResult objectForKey:@"Response"] objectAtIndex:0] objectForKey:@"AboutURL"]] forState:UIControlStateNormal placeholderImage:LoadImage(@"comSer@2x", @"jpg")];
         */
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[[FilterData filterNerworkData:[homeResult objectForKey:@"Response"]] objectAtIndex:0]];
        
        NSMutableDictionary *infoDic = [[UserInfoUtils sharedUserInfoUtils] infoDic];
        [infoDic setValuesForKeysWithDictionary:userInfoDic];
        [UserInfoUtils setUserInfoData:infoDic];
        
        //设置环信 新消息提醒 设置（声音和震动、新消息提醒）
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isVoice"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isVibration"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNewNoti"];
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate) enterHomeViewController];
    }else if([[homeResult objectForKey:@"Code"] integerValue] >0)
    {
        [self dismissProgressView:[homeResult objectForKey:@"Msg"]];
    }else{
        [self dismissProgressView:[homeResult objectForKey:@"Msg"]];
        NSLog(@"首页请求返回错误码：%@，错误信息：%@",[homeResult objectForKey:@"Code"],[homeResult objectForKey:@"Msg"]);
    }
    
}


#pragma mark--
#pragma QrCodeViewControllerDelegate
-(void)getQrCodeInfoStr:(NSString *)qrCodeStr
{
    NSLog(@"扫码出来的：%@",qrCodeStr);
    [self sendInviteLoginNetWorkRequest:qrCodeStr];
}

- (void)sendInviteLoginNetWorkRequest:(NSString *)inviteString
{
    [self showProgressView];
    //    [networkData startGet:@"UserLogin?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&UserName=ym15898765432&PassWD=Aa1234" tag:0];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        NSLog(@"请打开您的位置服务!");
//        if ([[UserInfoUtils sharedUserInfoUtils] isEmpty])        //判断是否有地址信息
        if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lat"] length] == 0 &&[[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lon"] length] == 0 && [[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"LocaDesc"] length] == 0){
            //存入沙盒
            NSMutableDictionary *addressInfoDic = [[NSMutableDictionary alloc] init];
            [addressInfoDic setValue:@"38.76623" forKey:@"Lat"];
            [addressInfoDic setValue:@"116.43213" forKey:@"Lon"];
            [addressInfoDic setValue:@"辽宁省沈阳市中山路15号3-5-3" forKey:@"LocaDesc"];
            [UserInfoUtils setUserInfoData:addressInfoDic];
        }else
        {
            NSMutableDictionary *addressInfoDic = [[UserInfoUtils sharedUserInfoUtils] infoDic];
            [addressInfoDic setValue:@"38.76623" forKey:@"Lat"];
            [addressInfoDic setValue:@"116.43213" forKey:@"Lon"];
            [addressInfoDic setValue:@"辽宁省沈阳市中山路15号3-5-3" forKey:@"LocaDesc"];
            NSLog(@"%@",[[UserInfoUtils sharedUserInfoUtils] infoDic]);
            [UserInfoUtils setUserInfoData:addressInfoDic];
        }
    }else
    {
//        if ([[UserInfoUtils sharedUserInfoUtils] isEmpty])      //判断是否有地址信息
        if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lat"] length] == 0 &&[[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lon"] length] == 0 && [[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"LocaDesc"] length] == 0)
        {
            //存入沙盒
            NSMutableDictionary *addressInfoDic = [[NSMutableDictionary alloc] init];
            [addressInfoDic setValue:@"38.76623" forKey:@"Lat"];
            [addressInfoDic setValue:@"116.43213" forKey:@"Lon"];
            [addressInfoDic setValue:@"辽宁省沈阳市中山路15号3-5-3" forKey:@"LocaDesc"];
            [UserInfoUtils setUserInfoData:addressInfoDic];
        }
    }
    if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] length] == 0) {
        [postData setValue:@"aabbcc" forKey:@"MachineID"];
        NSMutableDictionary *machineDic = [[UserInfoUtils sharedUserInfoUtils] infoDic];
        [machineDic setValue:@"aabbcc" forKey:@"MachineID"];
        [UserInfoUtils setUserInfoData:machineDic];
    }
    else{
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    }
    [postData setValue:inviteString forKey:@"InvCode"];
    [interface setInterfaceDidFinish:@selector(inviteLoginNetworkResult:)];
    [interface sendRequest:InviteCodeLogin Parameters:postData Type:get_request];
}

#pragma mark--
#pragma NetWorkResult
- (void)inviteLoginNetworkResult:(NSDictionary *)inviteLoginResult
{
    NSLog(@"%@",inviteLoginResult);
    NSLog(@"~~~ Result :%@ ~~~",[inviteLoginResult objectForKey:@"Code"]);
    NSLog(@"%@",[inviteLoginResult objectForKey:@"Msg"]);
    
    if ([[inviteLoginResult objectForKey:@"Code"] integerValue] == 0) {
        NSLog(@"~~~~~~~~~~~~ 登录成功 ~~~~~~~~~~");
        //存入本地
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[[inviteLoginResult objectForKey:@"Response"] objectAtIndex:0]];
        [userInfoDic setValue:@"0" forKey:@"EaseMobLoginStatus"];
        NSMutableDictionary *infoDic = [[UserInfoUtils sharedUserInfoUtils] infoDic];
        [infoDic setValuesForKeysWithDictionary:userInfoDic];
        [UserInfoUtils setUserInfoData:infoDic];
        
        //存储用户信息到环信
        [EMobUserInfo setEmobInfoDataWithUserId:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"IMLoginID"] userNickName:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"IMNick"] userIcon:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserLogo"]];
        
        //发送获取施工工作请求
        NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
        [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
        [interface setInterfaceDidFinish:@selector(getProjectNetworkResult:)];
        [interface sendRequest:GetProject Parameters:postData Type:get_request];
    }else if([[inviteLoginResult objectForKey:@"Code"] integerValue] >0)
    {
        [self dismissProgressView:[inviteLoginResult objectForKey:@"Msg"]];
    }else{
        NSLog(@"登录请求返回错误码：%@，错误信息：%@",[inviteLoginResult objectForKey:@"Code"],[inviteLoginResult objectForKey:@"Msg"]);
        [self dismissProgressView:[inviteLoginResult objectForKey:@"Msg"]];
    }
}


#pragma mark--
#pragma UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 90:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [self.view setFrame:CGRectMake(0, -70, ScreenWidth, ScreenHeight-64)];
            [UIView commitAnimations];
            break;
        case 91:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [self.view setFrame:CGRectMake(0, -70, ScreenWidth, ScreenHeight-64)];
            [UIView commitAnimations];
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self keyBoardDownAndTextFieldHidden];
}

- (void)keyBoardDownAndTextFieldHidden
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [UIView commitAnimations];
    [userNameTf resignFirstResponder];
    [passWordTf resignFirstResponder];
}

- (void)dismissProgressAlert {
    [self dismissProgressView:nil];
}

#pragma mark -
#pragma mark ViewController Delegate
- (void)viewDidDisappear:(BOOL)animated {
    [interface cancelRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
