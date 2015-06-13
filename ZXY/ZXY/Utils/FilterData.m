//
//  FilterData.m
//  ZXYY
//
//  Created by hndf on 15-4-3.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "FilterData.h"

@implementation FilterData

+(NSMutableArray *)filterNerworkData:(NSMutableArray *)sourceDataArray
{
    NSMutableArray *filterArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [sourceDataArray count]; i++) {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithDictionary:[sourceDataArray objectAtIndex:i]];
        for (NSString *key in [tmpDic allKeys]) {
            if ([[tmpDic objectForKey:key] isEqual:[NSNull null]]) {
                [tmpDic setValue:@"" forKey:key];
            }
        }
        
        [filterArray addObject:tmpDic];
        
    }
    
    return filterArray;
}

@end
