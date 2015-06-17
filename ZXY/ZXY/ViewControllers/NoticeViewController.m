//
//  NoticeViewController.m
//  ZXY
//
//  Created by soldier on 15/6/14.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController
@synthesize newNotiSwitch = _newNotiSwitch;
@synthesize voiceSwitch = _voiceSwitch;
@synthesize vibrationSwitch = _vibrationSwitch;
@synthesize speakerSwitch = _speakerSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    
    noticeTitleArray = @[@"接收新消息通知",@"声音",@"震动",@"扬声器播放语音"];

    [self setNoticeCustomView];

}

//新消息提醒
- (UISwitch *)newNotiSwitch
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    if (_newNotiSwitch == nil) {
        _newNotiSwitch = [[UISwitch alloc] init];
        [_newNotiSwitch addTarget:self action:@selector(newNotiChanged:) forControlEvents:UIControlEventValueChanged];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isNewNoti"] intValue] == 0) {
            [_newNotiSwitch setOn:NO animated:YES];
            options.noDisturbStatus = YES;
        }else
        {
            [_newNotiSwitch setOn:YES animated:YES];
            options.noDisturbStatus = NO;
        }
        [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
    }
    
    return _newNotiSwitch;
}


//声音
- (UISwitch *)voiceSwitch
{
    if (_voiceSwitch == nil) {
        _voiceSwitch = [[UISwitch alloc] init];
        [_voiceSwitch addTarget:self action:@selector(voiceChanged:) forControlEvents:UIControlEventValueChanged];
        NSLog(@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"isVoice"] intValue]);
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isVoice"] intValue] == 0) {
            [_voiceSwitch setOn:NO animated:YES];
        }else
        {
            [_voiceSwitch setOn:YES animated:YES];
        }
    }
    
    return _voiceSwitch;
}

//震动
- (UISwitch *)vibrationSwitch
{
    if (_vibrationSwitch == nil) {
        _vibrationSwitch = [[UISwitch alloc] init];
        [_vibrationSwitch addTarget:self action:@selector(vibrationChanged:) forControlEvents:UIControlEventValueChanged];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isVibration"] intValue] == 0) {
            [_vibrationSwitch setOn:NO animated:YES];
        }else
        {
            [_vibrationSwitch setOn:YES animated:YES];
        }
        
    }
    
    return _vibrationSwitch;
}

//扬声器
- (UISwitch *)speakerSwitch
{
    if (_speakerSwitch == nil) {
        _speakerSwitch = [[UISwitch alloc] init];
        [_speakerSwitch addTarget:self action:@selector(speakerChanged:) forControlEvents:UIControlEventValueChanged];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isSpeaker"] intValue] == 0) {
            [_speakerSwitch setOn:NO animated:YES];
        }else
        {
            [_speakerSwitch setOn:YES animated:YES];
        }
        
    }
    
    return _speakerSwitch;
}


- (void)setNoticeCustomView
{
    //背景View
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, ScreenWidth, 99*ScreenHeight/568)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    
    //扬声器播放语音背景View
    UIView *speakerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 84 + bgView.frame.size.height, ScreenWidth, 33*ScreenHeight/568)];
    [speakerBgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:speakerBgView];
    
    //标题
    for (int i = 0; i<[noticeTitleArray count]; i++) {
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:[noticeTitleArray objectAtIndex:i]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setFont:[UIFont systemFontOfSize:13.0f]];

        if (i<3) {
            
            [titleLabel setFrame:CGRectMake(10, i*33*ScreenHeight/568, 100, 33*ScreenHeight/568)];
            [bgView addSubview:titleLabel];
            
            //分割线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*33*ScreenHeight/568, ScreenWidth, 1.0f)];
            [lineView setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
            [bgView addSubview:lineView];
        }
        else
        {
            [titleLabel setFrame:CGRectMake(10, 0, 100, 33*ScreenHeight/568)];
            [speakerBgView addSubview:titleLabel];
        }
        
    }
    
    //新消息提醒开关位置
    self.newNotiSwitch.frame = CGRectMake(ScreenWidth-self.newNotiSwitch.frame.size.width - 10, (33*ScreenHeight/568 - self.newNotiSwitch.frame.size.height) / 2 ,self.newNotiSwitch.frame.size.width, self.newNotiSwitch.frame.size.height);
    [bgView addSubview:self.newNotiSwitch];
    
    //声音开关位置
    self.voiceSwitch.frame = CGRectMake(ScreenWidth-(self.voiceSwitch.frame.size.width+10), 33*ScreenHeight/568 + (33*ScreenHeight/568 - self.voiceSwitch.frame.size.height) / 2, self.voiceSwitch.frame.size.width, self.voiceSwitch.frame.size.height);
    [bgView addSubview:self.voiceSwitch];
    
    //震动开关位置
    self.vibrationSwitch.frame = CGRectMake(ScreenWidth-(self.voiceSwitch.frame.size.width+10), 66*ScreenHeight/568 + (33*ScreenHeight/568 - self.voiceSwitch.frame.size.height) / 2, self.vibrationSwitch.frame.size.width, self.vibrationSwitch.frame.size.height);
    [bgView addSubview:self.vibrationSwitch];

    //扬声器开关位置
    self.speakerSwitch.frame = CGRectMake(ScreenWidth-self.speakerSwitch.frame.size.width - 10, (33*ScreenHeight/568 - self.speakerSwitch.frame.size.height) / 2 ,self.speakerSwitch.frame.size.width, self.speakerSwitch.frame.size.height);
    [speakerBgView addSubview:self.speakerSwitch];
    
    
}

- (void)newNotiChanged:(UISwitch *)noticeswitch
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    if (noticeswitch.isOn) {
        options.noDisturbStatus = ePushNotificationNoDisturbStatusClose;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNewNoti"];
        
    }else
    {
        options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isNewNoti"];
        
    }
    [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
    
}

- (void)voiceChanged:(UISwitch *)voiceSwitch
{
    if (voiceSwitch.isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isVoice"];
    }else
    {
        NSLog(@"声音关");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isVoice"];
    }
}

- (void)vibrationChanged:(UISwitch *)vibrationSwitch
{
    if (vibrationSwitch.isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isVibration"];
    }else
    {
        NSLog(@"震动关");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isVibration"];
    }
}

- (void)speakerChanged:(UISwitch *)vibrationSwitch
{
    if (vibrationSwitch.isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isSpeaker"];
    }else
    {
        NSLog(@"扬声器关");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isSpeaker"];
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
