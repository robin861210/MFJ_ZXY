//
//  RwSandbox.m
//  ZXYY
//
//  Created by soldier on 15/4/2.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "RwSandbox.h"
#import "CommonCrypto/CommonDigest.h"

@implementation RwSandbox

// 判断程序沙盒文件是否存在
+ (BOOL) propertyFileExists:(NSString *) filePath
{
    return ([[NSFileManager defaultManager] fileExistsAtPath:filePath]);
}

//读取程序沙盒文件
+ (NSMutableDictionary *)readPropertyFile:(NSString *) filePath
{
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    return contentDic;
}

// 写入程序沙盒文件i
+ (BOOL) writePropertyFile:(NSMutableDictionary *) writeData FilePath:(NSString *) filePath
{
    return ([writeData writeToFile:filePath atomically:YES]);
}

// 删除程序沙盒文件
+ (BOOL) deletePropertyFile:(NSString *) filePath
{
    BOOL isResult = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        isResult = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }else {
        isResult = YES;
    }
    return isResult;
}

// 获取原始时间戳1970
+ (NSString *) getCurrentTimeStamp
{
    NSDate *localeDate = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    
    return timeSp;
}

//MD5加密
+(NSString *)md5:(NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//ylb
//判断文件是否相同
+(BOOL) samePath1:(NSString *) path1 AndPath2:(NSString *)path2
{
    ////contentsEqualAtPath:path1 andPath:path2
    return [[NSFileManager defaultManager] contentsEqualAtPath:path1 andPath:path2];
}


@end
