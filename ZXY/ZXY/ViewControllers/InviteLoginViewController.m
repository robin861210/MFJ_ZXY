//
//  InviteLoginViewController.m
//  ZXYY
//
//  Created by soldier on 15/4/2.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "InviteLoginViewController.h"

@interface InviteLoginViewController ()

@end

@implementation InviteLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setInviteLoginCustomView];
    
    //初始化AFNetwork
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(inviteLoginNetworkResult:)];

}

- (void)setInviteLoginCustomView
{
    //logo
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 125*ScreenWidth/320)/2, 30*ScreenHeight/568,125*ScreenWidth/320, 125*ScreenWidth/320)];
    [logoImgView setImage:LoadImage(@"icon-60@3x", @"png")];
    [self.view addSubview:logoImgView];
    
    //分割线
    for (int i = 0; i<2; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 185*ScreenHeight/568 +45*ScreenHeight/568 *i, ScreenWidth, 1.0f)];
        [lineView setBackgroundColor:UIColorFromHex(0xebebeb)];
        [self.view addSubview:lineView];
    }
    
    //邀请码
    UILabel *inviteCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 185*ScreenHeight/568, 60*ScreenWidth/320, 45*ScreenHeight/568)];
    [inviteCodeLabel setBackgroundColor:[UIColor clearColor]];
    [inviteCodeLabel setText:@"邀请码："];
    [inviteCodeLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [inviteCodeLabel setTextColor:[UIColor blackColor]];
    [inviteCodeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:inviteCodeLabel];
    
    inviteCodeTf = [[UITextField alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, inviteCodeLabel.frame.origin.y, ScreenWidth-inviteCodeLabel.frame.size.width, inviteCodeLabel.frame.size.height)];
    [inviteCodeTf setDelegate:self];
    [inviteCodeTf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [inviteCodeTf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [inviteCodeTf setReturnKeyType:UIReturnKeyDone];
    [inviteCodeTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [inviteCodeTf setKeyboardType:UIKeyboardTypeDefault];
    [inviteCodeTf setPlaceholder:@"请输入邀请码"];
    [inviteCodeTf setTextColor:[UIColor blackColor]];
    [inviteCodeTf setTextAlignment:NSTextAlignmentLeft];
    [inviteCodeTf setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:inviteCodeTf];
    
    //“登录”按钮
    UIButton *inviteLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, inviteCodeLabel.frame.origin.y + inviteCodeLabel.frame.size.height + 20, ScreenWidth-10, 40*ScreenHeight/568)];
    [inviteLoginBtn setBackgroundColor:UIColorFromHex(0x60d3c4)];
    [inviteLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    inviteLoginBtn.layer.cornerRadius = 2.0f;
    inviteLoginBtn.titleLabel.textColor = [UIColor whiteColor];
    inviteLoginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [inviteLoginBtn addTarget:self action:@selector(clickInviteLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inviteLoginBtn];

}

//邀请码登录
- (void)clickInviteLoginBtn:(id)sender
{
    [self keyBoardDownAndTextFieldHidden];
    NSLog(@"~~~~~~~~  登录 ！~~~~~~~~~~~~");
    if (inviteCodeTf.text == nil||[inviteCodeTf.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号不能为空,请重新输入。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        [self sendInviteLoginNetWorkRequest];
    }
    
}

- (void)sendInviteLoginNetWorkRequest
{
    [self showProgressView];
    //    [networkData startGet:@"UserLogin?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&UserName=ym15898765432&PassWD=Aa1234" tag:0];

    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        NSLog(@"请打开您的位置服务!");
//        if ([[UserInfoUtils sharedUserInfoUtils] isEmpty])      //判断是否有地址信息
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
    [postData setValue:inviteCodeTf.text forKey:@"InvCode"];
    
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
//        [self dismissProgressView:nil];
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

- (void)getProjectNetworkResult:(NSDictionary *)getProjectResult
{
    if ([[getProjectResult objectForKey:@"Code"] integerValue] == 0 &&
        [[getProjectResult objectForKey:@"Msg"] length] == 7) {
        NSLog(@"~~~~~~~~~~~~ 获取成功 ~~~~~~~~~~");
        //存入本地
        NSMutableDictionary *projectInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[[FilterData filterNerworkData:[getProjectResult objectForKey:@"Response"]] objectAtIndex:0]];
        [ProjectInfoUtils setProjectInfoData:projectInfoDic];
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
#pragma UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, -40, ScreenWidth, ScreenHeight-64)];
    [UIView commitAnimations];
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
    [inviteCodeTf resignFirstResponder];
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
