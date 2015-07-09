//
//  CalculatorViewController.h
//  ZXY
//
//  Created by soldier on 15/6/17.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseLabelViewController.h"

@interface CalculatorViewController : UIViewController <UITextFieldDelegate,ChooseLabelVCDelegate>
{
    UITextField *areaTextF;             //面积
    UILabel   *modelLabel,              //户型
                *roomHallWhoLabel,     //房厅卫
                *gradeLabel,             //装修档次
                *styleLabel,              //装修风格
                *cityLabel;               //所在城市
    ChooseLabelViewController *chooseLabelVC;
    
    NetworkInterface *interface;
    MRProgressOverlayView *progressView;
}

@end
