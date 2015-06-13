//
//  NetworkData.h
//  Kingdal
//
//  Created by hndf on 14-12-31.
//  Copyright (c) 2014年 MFJ. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEFAULT_PAGESIZE 20 //默认分页数量

/**
 请求完成处理
 */
typedef void (^Complete)();


/**
 请求失败处理
 */
typedef void (^Failed)(NSString *state, NSString *errmsg);


/**
 数据请求模型的基类，包含基本网络请求
 */
@interface NetworkData : NSObject
{
    Complete _complete; //请求完成
    Failed _failed;     //请求失败
}

//HTTP参数设置
@property(nonatomic, strong)NSString *baseUrl;  //Api基础地址
@property(nonatomic, strong)NSString *host;     //代理主机IP地址
@property(nonatomic, assign)NSInteger port;     //代理主机端口

@property(nonatomic, strong)NSString *errCode;  //错误代码
@property(nonatomic, strong)NSString *errMsg;   //错误描述
@property(nonatomic, strong)NSString *version;  //协议版本（客户端兼容最小版本）

- (id)initWithDelegate:(id)delegate;

/**
 发送get请求
 */
- (void)startGet:(NSString *)url tag:(NSInteger)tag;

/**
 发送getCache请求
 */
- (void)startCache:(NSString *)aCacheName cacheTime:(NSInteger)aTime url:(NSString *)url tag:(NSInteger)tag;

/**
 发送post请求
 */
- (void)startPost:(NSString *)url params:(NSDictionary *)params tag:(NSInteger)tag;

/**
 上传文件
 */
- (void)uploadFileURL:(NSString *)aUrl filePath:(NSString *)aPath keyName:(NSString *)aKeyName params:(NSDictionary *)params;


/*
 取消请求
 */
- (void)cancel;

@end

#pragma make - delegate
@protocol NetworkDataDelegate <NSObject>
@optional

/*
 请求完成时-调用
 */
- (void)getFinished:(NSDictionary *)msg tag:(NSInteger)tag;

/*
 请求失败时-调用
 */
- (void)getError:(NSDictionary *)msg tag:(NSInteger)tag;

@end
