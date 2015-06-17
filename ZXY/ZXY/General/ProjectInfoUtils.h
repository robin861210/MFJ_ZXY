//
//  ProjectInfoUtils.h
//  ZXYY
//
//  Created by soldier on 15/4/5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RwSandbox.h"


@interface ProjectInfoUtils : NSObject

+ (ProjectInfoUtils *)sharedProjectInfoUtils;
+ (void)initProjectInfo;
+ (void)setProjectInfoData;
+ (BOOL)setProjectInfoData:(NSMutableDictionary *)infoData;

@property (nonatomic, strong)NSMutableDictionary *infoDic;
@property (nonatomic, assign)BOOL isEmpty;



@end
