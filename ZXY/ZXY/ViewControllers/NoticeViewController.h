//
//  NoticeViewController.h
//  ZXY
//
//  Created by soldier on 15/6/14.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeViewController : UIViewController
{
    NSArray *noticeTitleArray;
}

@property (strong, nonatomic) UISwitch *newNotiSwitch;
@property (strong, nonatomic) UISwitch *voiceSwitch;
@property (strong, nonatomic) UISwitch *vibrationSwitch;
@property (strong, nonatomic) UISwitch *speakerSwitch;

@end
