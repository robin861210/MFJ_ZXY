//
//  ActivityViewController.h
//  ZXY
//
//  Created by soldier on 15/6/20.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityTableViewCell.h"
#import "SDRefresh.h"

@interface ActivityViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *activityTableView;
    ActivityTableViewCell *activityTableVcell;
    int pageNum;

    NSMutableArray *allActiveArray, *myActionArray;
    UIImageView *bgImgV;

    
    NetworkInterface *interface;
    MRProgressOverlayView *progressView;
    
    SDRefreshHeaderView *refreshHeader;
    SDRefreshFooterView *refreshFooter;
}

@property (nonatomic, assign)int selectType; //0:全部活动, 1:我的活动
@property (nonatomic, assign)int refreshType;

- (void)updateViewInfo:(int)type Num:(int)num;


@end
