//
//  TabBarView.h
//  ZXYY
//
//  Created by soldier on 15/3/31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarViewDelegate <NSObject>

- (void)selectTabBarItem:(NSString *)itemIndex;

@end

@interface TabBarView : UIView
{
    NSMutableDictionary *tabBarBtDic;
    NSInteger normalSelectTag;
    NSInteger tabBarCount;
    NSArray *normalImgArr,*selectImgArr;
    
    UILabel *numLab;
}

@property (nonatomic,strong) UILabel *numLab;
@property (nonatomic,assign) id <TabBarViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
         tabBarInfo:(NSArray *) tabBarInfo
         normalImageArr:(NSArray *) normalImageArr
         selectImageArr:(NSArray *) selectImageArr;

- (void)setNumOfChatView:(NSString *)num;

@end

