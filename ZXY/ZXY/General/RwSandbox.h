//
//  RwSandbox.h
//  ZXYY
//
//  Created by soldier on 15/4/2.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FILE_PATH_CachesDir     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define FILE_PATH_Library       [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define Documents_FilePath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface RwSandbox : NSObject

// 判断程序沙盒文件是否存在
+ (BOOL) propertyFileExists:(NSString *) filePath;

//读取程序沙盒文件
+ (NSMutableDictionary *) readPropertyFile:(NSString *) filePath;

// 写入程序沙盒文件
+ (BOOL) writePropertyFile:(NSMutableDictionary *) writeData FilePath:(NSString *) filePath;

// 删除程序沙盒文件
+ (BOOL) deletePropertyFile:(NSString *) filePath;

// 获取当前时间戳
+ (NSString *) getCurrentTimeStamp;

//MD5加密
+(NSString *) md5:(NSString *) inPutText ;

@end
