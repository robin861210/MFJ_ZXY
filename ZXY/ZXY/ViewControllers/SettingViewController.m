//
//  SettingViewController.m
//  ZXY
//
//  Created by soldier on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "SettingViewController.h"
#import "NoticeViewController.h"
#import "ModifyPWViewController.h"

@interface SettingViewController ()


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    
    settingArray = @[@"新消息通知",@"修改密码",@"关于我们"];
    
    [self setSettingCustomView];
    
    //初始化AFNetwork
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(logOutNetworkResult:)];
}

- (void)setSettingCustomView
{
    for (int i = 0; i < [settingArray count]; i++) {
        UIButton *optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64 + 10 + 36*i, ScreenWidth, 35)];
        [optionBtn setBackgroundColor:[UIColor whiteColor]];
        [optionBtn addTarget:self action:@selector(clickSettingOptionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [optionBtn setTag:(800+i)];
        [self.view addSubview:optionBtn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, optionBtn.frame.size.height)];
        [label setText:[settingArray objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [optionBtn addSubview:label];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-30, 7, 20, 20)];
        [arrowImgView setBackgroundColor:[UIColor redColor]];
        [arrowImgView setImage:LoadImage(@"center_right@2x", @"png")];
        [optionBtn addSubview:arrowImgView];
        
    }
    
    //退出登录
    UIButton *logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200*ScreenHeight/568, ScreenWidth, 35*ScreenHeight/568)];
    [logoutBtn setBackgroundColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [logoutBtn addTarget:self action:@selector(clickLogoutBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    
    
}


//“设置”页面功能选项
- (void)clickSettingOptionBtn:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger index = button.tag;
    if (index == 800) {
        NSLog(@"新消息通知…………");
        NoticeViewController *noticeVC = [[NoticeViewController alloc] init];
        [noticeVC setTitle:@"新消息通知"];
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    else if (index == 801)
    {
        NSLog(@"修改密码…………");
        ModifyPWViewController *modifyPWVC = [[ModifyPWViewController alloc] init];
        [modifyPWVC setTitle:@"修改密码"];
        [self.navigationController pushViewController:modifyPWVC animated:YES];
    }
    else
    {
        NSLog(@"关于我们…………");
    }
}

//“退出登录”
- (void)clickLogoutBtn:(id)sender
{
    //退出登录
    NSLog(@"退出登录…………");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"注销?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView setTag:803];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 803) {
        if (buttonIndex == 0) {
            NSLog(@"~~~~~~~~~~~ 取消注销~~~~~~~~~~~~~");
        }else
        {
            NSLog(@"~~~~~~~~~~~ 确认注销,发送注销请求~~~~~~~~~~~~~");
            [self sendLogOutNetWorkRequest];
        }
    }
}

#pragma mark--
#pragma NetWorkResult
- (void)sendLogOutNetWorkRequest
{
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    
    [interface setInterfaceDidFinish:@selector(logOutNetworkResult:)];
    [interface sendRequest:UserLogout Parameters:postData Type:get_request];
}

- (void)logOutNetworkResult:(NSDictionary *)logOutResult
{
    NSLog(@"%@",logOutResult);
    NSLog(@"~~~ Result :%@ ~~~",[logOutResult objectForKey:@"Code"]);
    NSLog(@"%@",[logOutResult objectForKey:@"Msg"]);
    
    if ([[logOutResult objectForKey:@"Code"] integerValue] == 0) {
        NSLog(@"~~~~~~~~~~~~ 注销成功 ~~~~~~~~~~");
        [self dismissProgressView:nil];
        //删除用户登录信息
        [RwSandbox deletePropertyFile:[NSString stringWithFormat:@"%@/userInfo.plist",Documents_FilePath]];
        //注销环信
        //        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        //            if (!error && info) {
        //                NSLog(@"退出成功");
        //            }
        //        } onQueue:nil];
        
        EMError *error = nil;
        NSDictionary *info = [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:&error];
        if (!error && info) {
            NSLog(@"退出成功");
        }
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate) enterLoginViewController];
        
    }else if([[logOutResult objectForKey:@"Code"] integerValue] >0)
    {
        [self dismissProgressView:nil];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[logOutResult objectForKey:@"Msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        NSLog(@"登录请求返回错误码：%@，错误信息：%@",[logOutResult objectForKey:@"Code"],[logOutResult objectForKey:@"Msg"]);
        [self dismissProgressView:[logOutResult objectForKey:@"Msg"]];
    }
    
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
