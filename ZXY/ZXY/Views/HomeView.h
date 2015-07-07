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
#import "CLLRefreshHeadController.h"
#import "HomeViewTableViewCell.h"

@protocol HomeDelegate <NSObject>

- (void)selectHomeADItem:(NSString *)ad_Info;

@end

@interface HomeView : UIView <ADCustomViewDelegate,UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
{
    UITableView *homeTableView;
    NSMutableArray *homeTableDataArray;
    ADCustomView *adView;
    float viewHeight;
    NSArray *funTitleArray,*funImgArray;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
    int NodeID;
    
    UIButton *introductionBtn,*productBtn,*serviceBtn;
}

@property (nonatomic,assign) id <HomeDelegate> delegate;
@property (nonatomic, strong) CLLRefreshHeadController *refreshControll;

- (void)sendHome_NetworkInfoData:(NSString *)urlStr NodeID:(int) nodeId;

@end
