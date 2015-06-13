//
//  ADCustomView.h
//  FrameWorkTest
//
//  Created by hndf on 14-5-20.
//  Copyright (c) 2014年 MFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"

typedef enum _DisplayModel
{
    left_Circle = 1,
    all_Circle = 2
}DisplayModel;

@protocol ADCustomViewDelegate <NSObject>

- (void) selectADCustomViewItem:(NSString *) ad_Id infoStr:(NSString *)info;

@end

@interface ADCustomView : UIView<UIScrollViewDelegate>
{
    UIScrollView *adScrollView;
    UIPageControl *adPageControl;
    UIView *pageBgView;
    NSArray *itemArray;
    NSInteger imageInfoCount;
    NSTimer *timer;
    NSMutableDictionary *adCustomInfoDic;
}

@property (assign) DisplayModel type;

@property (nonatomic, retain) id<ADCustomViewDelegate> delegate;

/* m
 refresh Data for Ad View 
 */
- (void)refreshImage:(NSArray *)infoArray
    placeHolderImage:(NSString *) placeHolderStr;

/* 
 set Left Circle Display Model 
 */
- (void) setScrollLeftCircle:(NSString *) placeHolderImage;
/*
 set PageBgView Color
 */
- (void)setPageBackgroundViewColor:(UIColor *)bgColor;

/*
 set adPageController Color
 */
- (void)setPageControllerColor:(UIColor *)currentIndicatorColor
                IndicatorColor:(UIColor *)backgroundindicatorColor;

/*
 set adPageController Alinment
 */
- (void)setPageControllerAlignment:(NSInteger)AlignmentFlag;

/* 
 set All Circle Display Model 
 */
- (void) setScrollAllCircle:(NSString *) placeHolderImage;

/* 
 set No Circle Display Model
 */
- (void) setScrollNoCircle:(NSString *) placeHolderImage;

/* 
 set AD page startPoint 
 */
- (void) setADPageStartPoint:(NSInteger) startPoint;

/* 
 create Timer
 timeInterval 为定时器的时间间隔
 */
- (void) createScrollTimer:(float) timeInterval;

/* 
 start timer 
 */
- (void) startTimerAnimation;

/* 
 stop timer
 */
- (void) stopTimerAnimation;

@end
