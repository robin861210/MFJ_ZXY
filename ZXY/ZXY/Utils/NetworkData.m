//
//  NetworkData.m
//  Kingdal
//
//  Created by hndf on 14-12-31.
//  Copyright (c) 2014年 MFJ. All rights reserved.
//

#import "NetworkData.h"
#import "AFNetworking.h"

Class object_getClass(id object);

@interface NetworkData()
{
    Class afOrinClass;
}

@property(nonatomic, strong)AFHTTPRequestOperationManager *manager; //AF请求对象
@property(nonatomic, weak)id<NetworkDataDelegate> delegate;

@end

@implementation NetworkData

#pragma mark networkData
- (id)initWithDelegate:(id)delegate
{
    if (self == [super init]) {
        afOrinClass = object_getClass(delegate);
        [self setDelegate:delegate];
        //[self setDefault];
    }
    
    return self;
}

/**
 初始化设置
 */
- (void)setDefault
{
    
}

/*
 初始化HTTP
 */
- (void)httpInit
{
    //应用配置文件
    self.manager = [AFHTTPRequestOperationManager manager];
    
    //声明返回的结果是JSON类型
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //如果接受类型不一致请替换一致
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //请求时间设置
    self.manager.requestSerializer.timeoutInterval = 9.0f;
    
    //设置代理
    //[self setProxy];
    
    //添加header头信息
    //[self addRequestHeader];
    
}

/*
 添加header头信息
 */
- (void)addRequestHeader
{
    //当前应用板块号
    
    //应用类型IOS
    
    //当前应用
    [self.manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
}

/*
 发送get请求
 */

- (void)startGet:(NSString *)url tag:(NSInteger)tag
{
    [self httpInit];
    
    [self.manager GET:[NSString stringWithFormat:@"%@%@",BaseURL,url] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestFinished:responseObject tag:tag];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestFailed:tag Error:error];
    }];
    
}

- (AFHTTPRequestOperation *)cacheOperationWithRequest:(NSURLRequest *)urlRequest
                                                  tag:(NSInteger)tag
                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSCachedURLResponse *cachedURLResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:urlRequest];
        cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:operation.response data:operation.responseData userInfo:nil storagePolicy:NSURLCacheStorageAllowed];
        [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse forRequest:urlRequest];
        
        success(operation,responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == kCFURLErrorNotConnectedToInternet) {
            NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:urlRequest];
            if (cachedResponse != nil && [[cachedResponse data] length] > 0) {
                success(operation, cachedResponse.data);
            } else {
                failure(operation, error);
            }
        } else {
            failure(operation, error);
        }
    }];
    
    return operation;
}

/**
 发送GetCache请求
 */
- (void)startCache:(NSString *)aCacheName cacheTime:(NSInteger)aTime url:(NSString *)url
               tag:(NSInteger)tag
{
    [self httpInit];
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@%@",BaseURL,url] parameters:nil error:nil];
    
    [request setTimeoutInterval:20];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy]; //此处将NSURLRequestReturnCacheDataElseLoad替换要不然无论有无网络情况每次请求都会取本地缓存数据
    
    //请求成功Block块
    void (^requestSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self requestFinished:responseObject tag:tag];
    };
    
    //请求失败Block块
    void (^requestFailureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error){
        
        [self requestFailed:tag Error:error];
    };
    
    //请求数据
    AFHTTPRequestOperation *operation = [self cacheOperationWithRequest:request tag:tag success:requestSuccessBlock failure:requestFailureBlock];
    [self.manager.operationQueue addOperation:operation];
}

/**
 * 获取缓存数据
 */
- (id)cachedResponseObject:(AFHTTPRequestOperation *)operation{
    
    NSCachedURLResponse* cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:operation.request];
    AFHTTPResponseSerializer* serializer = [AFJSONResponseSerializer serializer];
    id responseObject = [serializer responseObjectForResponse:cachedResponse.response data:cachedResponse.data error:nil];
    return responseObject;
}

/**
 发送post请求
 */
- (void)startPost:(NSString *)url params:(NSDictionary *)params tag:(NSInteger)tag
{
    [self httpInit];
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self requestFinished:responseObject tag:tag];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error)
    {
        [self requestFailed:tag Error:error];
    }];
}

/**
 上传文件
 */
- (void)uploadFileURL:(NSString *)aUrl filePath:(NSString *)aPath keyName:(NSString *)aKeyName params:(NSDictionary *)params
{
    [self httpInit];
    [self addRequestHeader];
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,aUrl]  parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        NSData *imageData = [[NSData alloc] initWithContentsOfFile:aPath];
        //获取文件类型
        NSMutableString *filePath = [NSMutableString stringWithString:aPath];
        CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[filePath pathExtension], NULL);
        CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
        NSString *fileName = [filePath lastPathComponent];
        //将得到的二进制图片拼接到表单中
        /** data,指定上传的二进制流;name,服务器端所需参数名;fileName,指定文件名;mimeType,指定文件格式 */
        [formData appendPartWithFileData:imageData name:aKeyName fileName:fileName mimeType:(__bridge NSString *)(MIMEType)];
        
    }success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self requestFinished:responseObject tag:200];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    /*
     /设置上传操作的进度
     
     [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
     
     NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
     }];
     
     UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
     
     [progress setProgressWithUploadProgressOfOperation:operation animated:YES];
     
     [progress setFrame:CGRectMake(0, 130, 320, 30)];
     
     [self.view addSubview:progress];
     */
    //[operation start];
}

/**
 停止请求
 */
- (void)cancel
{
    if (_manager != nil) {
        _manager = nil;
    }
}

/**
 清理回调block
 */
- (void)cleanupBlocks
{
    _complete = nil;
    _failed = nil;
}

/*
 解析通用协议头:
 1.检查协议体合法性
 2.协议版本检查，执行协议版本客户端处理逻辑
 
 返回值：BOOL 通过解析检查返回YES,否则 NO
 对于没有通过检查的协议消息，返回客户端协议错误的消息，或者版本不支持的错误
 */
- (BOOL)parseHead:(NSDictionary *)msg
{
    return YES;
}

#pragma mark AFHTTPDelegate
/**
 *代理-请求结束
 */
- (void)requestFinished:(NSDictionary *)aDictionary tag:(NSInteger)aTag
{
    //如果消息头解析成功并通过合法性检查
    if([self parseHead:aDictionary] == YES){
        
        if ([self.errCode intValue] <= 0) {
            
            if ([self.delegate respondsToSelector:@selector(getFinished:tag:)]) {
                [self.delegate getFinished:aDictionary tag:aTag];
            }
        }else{
            if (_failed) {
                _failed(self.errCode,self.errMsg);
            }
            if ([self.delegate respondsToSelector:@selector(getError:tag:)]) {
                [self.delegate getError:aDictionary tag:aTag];
            }
        }
    }
}

/**
 * 代理-请求失败
 */
- (void)requestFailed:(NSInteger)aTag Error:(NSError *)errorMsg
{
    NSLog(@"~~~ errorMsg code :%lud ~~~ errorMsg Message :%@ ~~~",[errorMsg code],[errorMsg description]);
    
    if (afOrinClass != object_getClass(_delegate)) {
        NSLog(@"model已销毁");
        return;
    }
    
    if (_failed) {
        _failed(@"1",@"request error");
    }
    
    //检测如果有配置代理则去执行代理
    if ([self.delegate respondsToSelector:@selector(getError:tag:)])
    {
        NSMutableDictionary *dicMsg = [[NSMutableDictionary alloc] init];
        switch (errorMsg.code) {
            case -1001:
                [dicMsg setValue:@"-1001" forKey:@"Code"];
                [dicMsg setValue:@"请求超时" forKey:@"Msg"];
                break;
            case -1005:
                [dicMsg setValue:@"-1005" forKey:@"Code"];
                [dicMsg setValue:@"网络连接失败" forKey:@"Msg"];
                break;
            case -1004:
                [dicMsg setValue:@"-1004" forKey:@"Code"];
                [dicMsg setValue:@"未能连接到服务器" forKey:@"Msg"];
            
            default:
                break;
        }
        [self.delegate getError:dicMsg tag:aTag];
    }
}

@end
