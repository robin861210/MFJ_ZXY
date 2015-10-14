//
//  DiaryDetailViewController.h
//  ZXY
//
//  Created by soldier on 15/9/29.
//  Copyright © 2015年 MFJ_zxy. All rights reserved.
//

#import "BaseViewController.h"
#import "DiaryDetailTableViewCell.h"
#import "UIImageView+MJWebCache.h"
#import "DiaryCommentsViewController.h"

@interface DiaryDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *tableHeaderView;
    NSMutableArray *diaryArray;
    UITableView *diaryTableView;
    UIView *bgMenuView;
    BOOL isBgViewHidder;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
}

@property (nonatomic, strong) NSMutableDictionary *diaryDic;


@end
