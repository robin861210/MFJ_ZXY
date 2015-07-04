//
//  HomeView.h
//  ZXYY
//
//  Created by soldier on 15/3/31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADCustomView.h"
#import "ADDataBean.h"
#import "UIButton+WebCache.h"

@protocol HomeDelegate <NSObject>

- (void)selectHomeADItem:(NSString *)ad_Info;

@end

@interface HomeView : UIView <ADCustomViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *homeScrollView;
    ADCustomView *adView;
    float viewHeight;
    NSArray *funTitleArray,*funImgArray;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
    
    UIButton *introductionBtn,*productBtn,*serviceBtn;
}

@property (nonatomic,assign) id <HomeDelegate> delegate;

//- (void)sendHomeNetWorkRequest;

@end
