//
//  DiaryViewController.h
//  ZXY
//
//  Created by soldier on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryTableViewCell.h"
#import "DiaryDetailViewController.h"
#import "CLLRefreshHeadController.h"

@interface DiaryViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
{
    DiaryTableViewCell *diaryTableCell;
    UITableView *diaryTableView;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
    
    NSMutableArray *diaryListArray;
    NSMutableDictionary *postData;
}

@property (nonatomic, strong) CLLRefreshHeadController *refreshControll;


@end
