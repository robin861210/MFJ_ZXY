//
//  WebViewController.m
//  ZXYY
//
//  Created by hndf on 15-3-31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [webView setDelegate:self];
    
    NSLog(@"~~~ logo:%@\n~~~ text:%@\n~~~ url:%@\n~~~",self.shareLogoImg,self.shareText,self.shareUrl);
    
    if (self.htmlFlag) {
        NSString *htmlStr = [NSString stringWithFormat:@"<p style=\"margin-bottom: -10px;text-align: center;border-bottom:1px solid #000;color:#000;text-indent:0px;background-color:#FFFFFF;font-size:20px;line-height: 50px;\">%@</p>",self.webHtmlTitleStr];
        [webView loadHTMLString:[htmlStr stringByAppendingString:self.webHtmlStr] baseURL:nil];
    }else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]];
        [webView loadRequest:request];
    }
    [self.view addSubview:webView];
    if (self.canShare) {
        [self addNavigationRightItem];
    }
}

- (void)addNavigationRightItem {
    UIButton *sharedBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [sharedBt setBackgroundColor:[UIColor clearColor]];
    [sharedBt setImage:LoadImage(@"shareBt@2x", @"png") forState:UIControlStateNormal];
    [sharedBt addTarget:self action:@selector(searchBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:sharedBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];
}

- (IBAction)searchBtClicked:(id)sender {
//    NSLog(@"~~~  点击了WebViewController 中的分享按钮 ~~~");
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UmengKey
//                                      shareText:self.shareText
//                                     shareImage:[self loadWebImage:self.shareLogoImg]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,nil]
//                                       delegate:self];
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
//    [UMSocialData defaultData].extConfig.qqData.title = @"";
//    [UMSocialData defaultData].extConfig.qqData.url = self.shareUrl;
}

#pragma mark--
#pragma 分享统计
//实现回调方法（可选）：
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//        
//    }
//}

- (UIImage *)loadWebImage:(NSString *)imageUrlPath
{
    UIImage* image=nil;
    NSURL* url = [NSURL URLWithString:[imageUrlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//网络图片url
    NSData* data = [NSData dataWithContentsOfURL:url];//获取网咯图片数据
    if(data!=nil)
    {
        image = [[UIImage alloc] initWithData:data];//根据图片数据流构造image
    }
    return image;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始载入网页!");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"网页载入完成!");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"网页载入错误!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
