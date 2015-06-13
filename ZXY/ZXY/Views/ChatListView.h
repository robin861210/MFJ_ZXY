//
//  ChatListView.h
//  ZXYY
//
//  Created by hndf on 15/4/25.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "EMSearchBar.h"
#import "NSDate+Category.h"
#import "RealtimeSearchUtil.h"
#import "ChatViewController.h"
#import "EMSearchDisplayController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "UIImageView+MJWebCache.h"

@protocol ChatListViewDelegat <NSObject>

- (void)chatListViewWillEnterVC:(ChatViewController *)chatVC;
- (void)chatListViewHidden;

@end

@interface ChatListView : UIView<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate,SRRefreshDelegate, UISearchBarDelegate, IChatManagerDelegate>

@property (strong, nonatomic) NSMutableArray        *dataSource;
@property (strong, nonatomic) UITableView           *tableView;
@property (nonatomic, strong) EMSearchBar           *searchBar;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@property (nonatomic, strong) UIView                *networkStateView;
@property (strong, nonatomic) EMSearchDisplayController *searchController;

@property (nonatomic, strong)id<ChatListViewDelegat>delegate;

- (void)refreshDataSource;
- (void)isConnect:(BOOL)isConnect;

- (void)networkChanged:(EMConnectionState)connectionState;
-(void)registerNotifications;
-(void)unregisterNotifications;

@end
