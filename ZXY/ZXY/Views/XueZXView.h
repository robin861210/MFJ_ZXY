//
//  XueZXView.h
//  ZXY
//
//  Created by acewill on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADCustomView.h"
#import "ADDataBean.h"
#import "CLLRefreshHeadController.h"

@interface XueZXView : UIView<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,CLLRefreshHeadControllerDelegate,ADCustomViewDelegate>
{
    ADCustomView *adView;
    float viewWidth, viewHeight;
    UITableView *BD_tableView;
    UISearchBar *customSearchBar;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
    
    int cellType;
}

@property (nonatomic, assign)NSInteger selectType;
@property (nonatomic, strong)NSArray *tableDataArray;
@property (nonatomic, strong) CLLRefreshHeadController *refreshControll;

- (void)sendXueZX_ZSK_NetworkInfoData:(NSString *)postInfoData;

- (void)updataTableViewData:(NSArray *)InfoArray;

- (void)transfromXueZX_Info:(int)typeNum;

@end
