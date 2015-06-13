//
//  UserInfoUtils.h
//  Kingdal
//
//  Created by hndf on 15-1-20.
//  Copyright (c) 2015年 MFJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RwSandbox.h"

@interface UserInfoUtils : NSObject

+ (UserInfoUtils *)sharedUserInfoUtils;
+ (void)initUserInfo;
+ (void)setUserInfoData;
+ (BOOL)setUserInfoData:(NSMutableDictionary *)infoData;

@property (nonatomic, strong)NSMutableDictionary *infoDic;
@property (nonatomic, assign)BOOL isEmpty;


@end
