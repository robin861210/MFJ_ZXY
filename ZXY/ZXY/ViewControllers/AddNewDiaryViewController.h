//
//  AddNewDiaryViewController.h
//  ZXY
//
//  Created by soldier on 15/7/1.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseMarkViewController.h"
#import "ChoosePhaseViewController.h"

@interface AddNewDiaryViewController : UIViewController <UITextViewDelegate,ChooseMarkVCDelegate,ChoosePhaseVCDelegate>
{
    UITextView *contentTextView;         //日记内容
    UIView *photoView;                      //照片View
    UIView *otherView;                      //其他标签
    UILabel   *zxPhaseLab,                 //装修阶段
                *zxMarkLab,                 //装修标签
                *zxDateLab;                 //装修日期
    
    ChooseMarkViewController *chooseMarkVC;
    ChoosePhaseViewController *choosePhaseVC;

}

@property(nonatomic,assign)BOOL edited;


@end
