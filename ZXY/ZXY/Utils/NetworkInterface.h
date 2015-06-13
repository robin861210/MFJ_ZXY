//
//  NewworkInterface.h
//  ZXYY
//
//  Created by acewill on 15-4-1.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkData.h"

typedef NS_ENUM(NSUInteger, requstType) {
    get_request = 0,
    post_request = 1,
};

@interface NetworkInterface : NSObject<NetworkDataDelegate>
{
    NetworkData *networkData;
    
}

@property(nonatomic,unsafe_unretained) id target;
@property(nonatomic)SEL didFinish;

- (id)initWithTarget:(id)__target didFinish:(SEL)__didFinish;

- (void)setInterfaceDidFinish:(SEL)__didFinish;

- (BOOL)getNetWorkStatus;

- (void)cancelRequest;

- (void)sendRequest:(NSString *)url Parameters:(NSMutableDictionary *)loginDic
               Type:(requstType)type;

- (void)uploadFileURL:(NSString *)aUrl filePath:(NSString *)aPath keyName:(NSString *)aKeyName params:(NSDictionary *)params;

@end
