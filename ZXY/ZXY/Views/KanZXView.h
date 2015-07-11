//
//  KanZXView.h
//  ZXY
//
//  Created by acewill on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KanZXTableViewCell.h"
#import "CLLRefreshHeadController.h"

@interface KanZXView : UIView<UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
{
    UITableView *kanZX_TableV;
    NSMutableArray *Kan_tableViewArray;
    
    int dataInfoType;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
    
    BOOL PullDown, PullUp;
}

@property (nonatomic, strong) CLLRefreshHeadController *refreshControll;
- (void)sendKanZX_NetworkInfoData:(NSString *)urlStr;

- (void)transfromKanZX_Info:(int)typeNum;

@end
