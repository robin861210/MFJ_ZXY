//
//  EMobUserInfo.m
//  DynamicCellTest
//
//  Created by 华诺东方 on 15/4/29.
//  Copyright (c) 2015年 于立兵. All rights reserved.
//

#import "EMobUserInfo.h"

@implementation EMobUserInfo
@synthesize infoDic = _infoDic;
@synthesize isEmpty = _isEmpty;

static EMobUserInfo *singetonInfoUtils;
+ (EMobUserInfo *)sharedEMobInfo
{
    @synchronized(self)
    {
        if (!singetonInfoUtils) {
            singetonInfoUtils = [[EMobUserInfo alloc]init];
        }
        [self setEmobInfoData];
        return singetonInfoUtils;
    }
}

+ (void)initEmobInfo
{
    @synchronized(self)
    {
        singetonInfoUtils = [[EMobUserInfo alloc] init];
    }
}

+ (void)setEmobInfoData
{
    if ([RwSandbox propertyFileExists:[NSString stringWithFormat:@"%@/EmobInfo.plist",Documents_FilePath]]) {
        NSMutableDictionary *sandBoxDic = [[NSMutableDictionary alloc] initWithDictionary:[RwSandbox readPropertyFile:[NSString stringWithFormat:@"%@/EmobInfo.plist",Documents_FilePath]]];
        singetonInfoUtils.infoDic = [[NSMutableDictionary alloc] initWithDictionary:sandBoxDic];
        singetonInfoUtils.isEmpty = NO;
    }else {
        singetonInfoUtils.infoDic = nil;
        singetonInfoUtils.isEmpty = YES;
    }
}

+ (BOOL)setEmobInfoData:(NSMutableDictionary *)infoData
{
    return [RwSandbox writePropertyFile:infoData FilePath:[NSString stringWithFormat:@"%@/EmobInfo.plist",Documents_FilePath]];
}

//存字典
+ (void)setEmobInfoDataWithUserId:(NSString *)userId userNickName:(NSString *)nickName userIcon:(NSString *)userIcon
{
    NSMutableDictionary *sandBoxDic = [[NSMutableDictionary alloc] initWithDictionary:[RwSandbox readPropertyFile:[NSString stringWithFormat:@"%@/EmobInfo.plist",Documents_FilePath]]];
    NSMutableDictionary *eUserDic = [[NSMutableDictionary alloc] init];
    [eUserDic setValue:nickName forKey:@"userNickName"];
    [eUserDic setValue:userIcon forKey:@"userIcon"];
    //
    NSString *lowerUserId = userId.lowercaseString;
    NSLog(@"~~~~~~~~~~~~~~~~~~~~    lowerUserId:%@",lowerUserId);
    [sandBoxDic setObject:eUserDic forKey:lowerUserId];
    
    [RwSandbox writePropertyFile:sandBoxDic FilePath:[NSString stringWithFormat:@"%@/EmobInfo.plist",Documents_FilePath]];
    NSLog(@"%@",NSHomeDirectory());
}

//取字典
+ (NSMutableDictionary *)getEmobUserInfo:(NSString *)userId
{
    NSMutableDictionary *sandBoxDic = [[NSMutableDictionary alloc] initWithDictionary:[RwSandbox readPropertyFile:[NSString stringWithFormat:@"%@/EmobInfo.plist",Documents_FilePath]]];
    for (int i = 0; i<[[sandBoxDic allKeys] count]; i++) {
        if ([userId isEqualToString:[[sandBoxDic allKeys] objectAtIndex:i]]) {
            return [sandBoxDic objectForKey:userId];
        }
    }
    return nil;
}

//查询
+ (BOOL)searchEmobUserInfo:(NSString *)userId
{
    NSMutableDictionary *sandBoxDic = [[NSMutableDictionary alloc] initWithDictionary:[RwSandbox readPropertyFile:[NSString stringWithFormat:@"%@/EmobInfo.plist",Documents_FilePath]]];
    for (int i = 0; i<[[sandBoxDic allKeys] count]; i++) {
        if ([userId isEqualToString:[[sandBoxDic allKeys] objectAtIndex:i]]) {
            return YES;
        }
    }
    return NO;
}



@end
