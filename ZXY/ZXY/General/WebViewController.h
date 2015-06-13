//
//  WebViewController.h
//  ZXYY
//
//  Created by hndf on 15-3-31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UMSocial.h"

@interface WebViewController : UIViewController<UIWebViewDelegate/*,UMSocialUIDelegate,UMSocialDataDelegate*/>
{
    UIWebView *webView;
}

@property (nonatomic,assign)BOOL htmlFlag;
@property (nonatomic,assign)BOOL canShare;
@property (nonatomic, strong)NSString *webURL;
@property (nonatomic, strong)NSString *webHtmlStr;
@property (nonatomic, strong)NSString *webHtmlTitleStr;

@property (nonatomic, strong)NSString *shareLogoImg;
@property (nonatomic, strong)NSString *shareText;
@property (nonatomic, strong)NSString *shareUrl;
@property (nonatomic, strong)NSString *shareID;

@end
