//
//  NewworkInterface.m
//  ZXYY
//
//  Created by acewill on 15-4-1.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "NetworkInterface.h"
#import "AFNetworkReachabilityManager.h"

@implementation NetworkInterface

- (id)initWithTarget:(id)__target didFinish:(SEL)__didFinish {
    self = [super init];
    if (self) {
        self.target = __target;
        self.didFinish = __didFinish;
        
        networkData = [[NetworkData alloc] initWithDelegate:self];
    }
    return self;
}

- (void)setInterfaceDidFinish:(SEL)__didFinish; {
    self.didFinish = __didFinish;
}
//检查网络是否可用
- (BOOL)getNetWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        NSLog(@"%ld", status);
    }];
    
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}
//发送请求
- (void)sendRequest:(NSString *)url Parameters:(NSMutableDictionary *)parameters
               Type:(requstType)type {
    
    if (type == get_request && [parameters count] > 0) {
        NSString *getUrl = [url stringByAppendingString:@"?"];
        for (NSString *key in [parameters allKeys])
        {
            NSString *parent = [NSString stringWithFormat:@"%@=%@&",key,[parameters objectForKey:key]];
            getUrl = [getUrl stringByAppendingString:parent];
        }
        
        getUrl = [getUrl stringByAppendingString:[NSString stringWithFormat:@"VerNum=%@&Src=%@&Channels=%@",@"1.0",@"0",@"1"]];
        
        getUrl = [getUrl stringByAppendingString:[NSString stringWithFormat:@"&Lat=%@&Lon=%@&LocaDesc=%@",[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lat"],[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"Lon"],[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"LocaDesc"]]];
        NSLog(@"~~~ getUrl :%@ ~~~",getUrl);
//        getUrl = [getUrl substringToIndex:getUrl.length-1];
        [networkData startGet:getUrl tag:0];
        
    }else if(type == post_request) {
        [networkData startPost:url params:parameters tag:0];
    }
}
//上传图片
- (void)uploadFileURL:(NSString *)aUrl filePath:(NSString *)aPath keyName:(NSString *)aKeyName params:(NSDictionary *)params
{
    [networkData uploadFileURL:aUrl filePath:aPath keyName:aKeyName params:params];
}
//取消请求
- (void)cancelRequest
{
    [networkData cancel];
}
//获取数据成功
- (void)getFinished:(NSDictionary *)dicMsg tag:(NSInteger)tag {
    [self getResultInfo:dicMsg];
}
//获取数据失败
- (void)getError:(NSDictionary *)dicMsg tag:(NSInteger)tag {
    [self getResultInfo:dicMsg];
}
//返回获取结果
- (void)getResultInfo:(NSDictionary *)dataDic {
    [self.target performSelector:self.didFinish withObject:dataDic];
}

@end
