//
//  ChooseMarkViewController.h
//  ZXY
//
//  Created by soldier on 15/7/1.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseMarkVCDelegate <NSObject>

- (void)setMarkLabelText:(NSString *)labelT;

@end

@interface ChooseMarkViewController : UIViewController
{
    NSArray *commonMarkArray;
    NSArray *otherMarkArray;
}

@property (nonatomic,assign) id <ChooseMarkVCDelegate>delegate;


@end
