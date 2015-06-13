//
//  ADDataBean.h
//  FrameWorkTest
//
//  Created by hndf on 14-5-20.
//  Copyright (c) 2014年 MFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADDataBean : NSObject

@property (nonatomic, retain) NSString *ad_id;

@property (nonatomic, retain) NSString *ad_image;
@property (nonatomic, retain) NSString *ad_info;
@property (assign) BOOL ad_image_flag;

@end
