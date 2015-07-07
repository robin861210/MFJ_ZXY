//
//  ChoosePhaseViewController.h
//  ZXY
//
//  Created by soldier on 15/7/2.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoosePhaseVCDelegate <NSObject>

- (void)setPhaseLabelText:(NSString *)labelT;

@end

@interface ChoosePhaseViewController : UIViewController
{
    NSArray *titleArray;
    NSInteger phaseType;
    
    UILabel *titleLabel;         //装修阶段标题
    UILabel *describeLabel;     //阶段描述
}

@property (nonatomic,assign) id<ChoosePhaseVCDelegate> delegate;

@end
