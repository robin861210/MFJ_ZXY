//
//  MainViewController.h
//  ZXY
//
//  Created by acewill on 15/6/12.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#import "HomeView.h"
#import "KanZXView.h"
#import "XueZXView.h"
#import "ChatListView.h"

@interface MainViewController : UIViewController<TabBarViewDelegate,HomeDelegate>
{
    UIView *tmpView;
    TabBarView *tabBarView;
    NSArray *tabArray;
    
    HomeView *homeView;
    KanZXView *kanZXView;
    XueZXView *xueZXView;
    
    NSInteger switchIndex;
    
    //*** MFJ 环信 ***//
    EMConnectionState _connectionState;
}

@property(nonatomic,retain)AVCaptureSession *AVSession;

//*** MFJ 环信 ***//
- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)networkChanged:(EMConnectionState)connectionState;

@end
