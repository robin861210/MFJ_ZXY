//
//  ProjectInfoUtils.m
//  ZXYY
//
//  Created by soldier on 15/4/5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "ProjectInfoUtils.h"

@implementation ProjectInfoUtils
@synthesize infoDic = _infoDic;
@synthesize isEmpty = _isEmpty;

static ProjectInfoUtils *singetonInfoUtils;
+ (ProjectInfoUtils *)sharedProjectInfoUtils
{
    @synchronized(self)
    {
        if (!singetonInfoUtils) {
            singetonInfoUtils = [[ProjectInfoUtils alloc]init];
        }
        [self setProjectInfoData];
        return singetonInfoUtils;
    }
}

+ (void)initProjectInfo
{
    @synchronized(self)
    {
        singetonInfoUtils = [[ProjectInfoUtils alloc] init];
    }
}

+ (void)setProjectInfoData
{
    if ([RwSandbox propertyFileExists:[NSString stringWithFormat:@"%@/projectInfo.plist",Documents_FilePath]]) {
        NSMutableDictionary *sandBoxDic = [[NSMutableDictionary alloc] initWithDictionary:[RwSandbox readPropertyFile:[NSString stringWithFormat:@"%@/projectInfo.plist",Documents_FilePath]]];
        singetonInfoUtils.infoDic = [[NSMutableDictionary alloc] initWithDictionary:sandBoxDic];
        singetonInfoUtils.isEmpty = NO;
    }else {
        singetonInfoUtils.infoDic = nil;
        singetonInfoUtils.isEmpty = YES;
    }
}

+ (BOOL)setProjectInfoData:(NSMutableDictionary *)infoData
{
    return [RwSandbox writePropertyFile:infoData FilePath:[NSString stringWithFormat:@"%@/projectInfo.plist",Documents_FilePath]];
}


@end
