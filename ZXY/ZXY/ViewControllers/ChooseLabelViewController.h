//
//  ChooseLabelViewController.h
//  ZXY
//
//  Created by soldier on 15/6/17.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseLabelVCDelegate <NSObject>

- (void)setLabelText:(NSString *)labelT AndType:(NSInteger)chooseType;

@end

@interface ChooseLabelViewController : UIViewController
{
    NSArray *chooseArray;
}

@property (nonatomic,assign) id <ChooseLabelVCDelegate>delegate;

- (void)setChooseLabelCustomView:(NSInteger)chooseTy;

@end
