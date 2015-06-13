//
//  UserInfoUtils.m
//  Kingdal
//
//  Created by hndf on 15-1-20.
//  Copyright (c) 2015年 MFJ. All rights reserved.
//

#import "UserInfoUtils.h"

@implementation UserInfoUtils

@synthesize infoDic = _infoDic;

static UserInfoUtils *singetonInfoUtils;
+ (UserInfoUtils *)sharedUserInfoUtils
{
    @synchronized(self)
    {
        if (!singetonInfoUtils) {
            singetonInfoUtils = [[UserInfoUtils alloc]init];
        }
        [self setUserInfoData];
        return singetonInfoUtils;
    }
}

+ (void)initUserInfo
{
    @synchronized(self)
    {
        singetonInfoUtils = [[UserInfoUtils alloc] init];
    }
}

+ (void)setUserInfoData
{
    if ([RwSandbox propertyFileExists:[NSString stringWithFormat:@"%@/userInfo.plist",Documents_FilePath]]) {
        NSMutableDictionary *sandBoxDic = [[NSMutableDictionary alloc] initWithDictionary:[RwSandbox readPropertyFile:[NSString stringWithFormat:@"%@/userInfo.plist",Documents_FilePath]]];
        singetonInfoUtils.infoDic = [[NSMutableDictionary alloc] initWithDictionary:sandBoxDic];
        singetonInfoUtils.isEmpty = NO;
    }else {
        singetonInfoUtils.infoDic = nil;
        singetonInfoUtils.isEmpty = YES;
    }
}

+ (BOOL)setUserInfoData:(NSMutableDictionary *)infoData
{
    return [RwSandbox writePropertyFile:infoData FilePath:[NSString stringWithFormat:@"%@/userInfo.plist",Documents_FilePath]];
}

@end
