//
//  EMobUserInfo.h
//  DynamicCellTest
//
//  Created by 华诺东方 on 15/4/29.
//  Copyright (c) 2015年 于立兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RwSandbox.h"

@interface EMobUserInfo : NSObject
+ (EMobUserInfo *)sharedEMobInfo;
+ (void)initEmobInfo;
+ (void)setEmobInfoData;
+ (BOOL)setEmobInfoData:(NSMutableDictionary *)infoData;
+ (void)setEmobInfoDataWithUserId:(NSString *)userId userNickName:(NSString *)nickName userIcon:(NSString *)userIcon;
+ (NSMutableDictionary *)getEmobUserInfo:(NSString *)userId;
+ (BOOL )searchEmobUserInfo:(NSString *)userId;

@property (nonatomic, strong)NSMutableDictionary *infoDic;
@property (nonatomic, assign)BOOL isEmpty;

@end
