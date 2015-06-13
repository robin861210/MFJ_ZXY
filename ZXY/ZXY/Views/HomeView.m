//
//  HomeView.m
//  ZXYY
//
//  Created by soldier on 15/3/31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];

        [self creatADView];
        [self updateHomeViewData];
        
        //初始化AFNetwork
//        progressView = [[MRProgressOverlayView alloc] init];
//        progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
//        [self addSubview:progressView];
//        
//        interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(homeNetworkResult:)];
    }
    return self;
}

#pragma mark -
#pragma mark Crear ADView and Delegate
- (void) creatADView
{
    adView = [[ADCustomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,125*ScreenHeight/568)];
    adView.delegate = self;
    [adView setType:left_Circle];
    [self addSubview:adView];
    
    viewHeight += adView.frame.size.height + adView.frame.origin.y;
    
}

- (void)selectADCustomViewItem:(NSString *)ad_Id infoStr:(NSString *)info {
    NSLog(@"~~~ Select ADViewItem AD_Id : %@ ~~~",ad_Id);
    if ([_delegate respondsToSelector:@selector(selectHomeADItem:)]) {
        [_delegate selectHomeADItem:info];
    }
    
}
//更新广告数据
- (void)updateHomeViewData {
    NSMutableArray *AD_InfoArray = [[NSMutableArray alloc] init];
    for (int i = 0;  i < 3; i++) {
        ADDataBean *bean = [[ADDataBean alloc] init];
        bean.ad_id = [NSString stringWithFormat:@"%d",i];
        bean.ad_image = @"http://img3.3lian.com/2013/v9/96/82.jpg";
        [AD_InfoArray addObject:bean];
    }
    [adView refreshImage:AD_InfoArray placeHolderImage:@"placeholder@2x"];
}



@end
