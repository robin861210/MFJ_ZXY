//
//  ActivityDetailViewController.m
//  ZXY
//
//  Created by soldier on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityApplyViewController.h"


@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
}

- (void)updateACDetailInfo:(NSArray *)infoArray ac_DetailType:(int)ac_Type
{
    NSLog(@"%@",infoArray);
    NSString *Urls = [[infoArray objectAtIndex:0] objectForKey:@"Urls"];
    NSString *logo = [[infoArray objectAtIndex:0] objectForKey:@"Logos"];
    NSString *start = [NSString stringWithFormat:@"%@",[[[[infoArray objectAtIndex:0] objectForKey:@"StartTime"] componentsSeparatedByString:@" "] objectAtIndex:0]];
    NSString *end = [NSString stringWithFormat:@"%@",[[[[infoArray objectAtIndex:0] objectForKey:@"EndTime"] componentsSeparatedByString:@" "] objectAtIndex:0]];
    activeID = [NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:0] objectForKey:@"ActID"]];
    
    
    imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 150*ScreenHeight/568)];
    [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Urls,logo]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
    [imgV setUserInteractionEnabled:YES];
    [self.view addSubview:imgV];
    
    //概要信息背景View
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 110*ScreenHeight/568, ScreenWidth, 40*ScreenHeight/568)];
    [infoView setBackgroundColor:RGBACOLOR(0, 0, 0, 0.6)];
    [imgV addSubview:infoView];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, 0, 230*ScreenWidth/320, 20*ScreenHeight/568)];
    [titleLab setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setText:[NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:0] objectForKey:@"ActName"]]];
    [infoView addSubview:titleLab];
    
    funBt = [[UIButton alloc] initWithFrame:CGRectMake(240*ScreenWidth/320, 10*ScreenHeight/568, 70*ScreenWidth/320, 20*ScreenHeight/568)];
    [funBt setBackgroundColor:UIColorFromHex(0xFFA500)];
    [funBt setTintColor:[UIColor whiteColor]];
    [funBt setTitle:@"活动报名" forState:UIControlStateNormal];
    [funBt addTarget:self action:@selector(AC_DetaillVCFuncBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    [funBt.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [funBt.layer setMasksToBounds:YES];
    [funBt.layer setCornerRadius:3.0f];
    [funBt setHidden:ac_Type];
    [infoView addSubview:funBt];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, 20*ScreenHeight/568, 230*ScreenWidth/320, 20*ScreenHeight/568)];
    [timeLab setFont:[UIFont systemFontOfSize:10.0f]];
    [timeLab setTextColor:[UIColor whiteColor]];
    [timeLab setText:[NSString stringWithFormat:@"活动时间:      %@到%@截止",start,end]];
    [infoView addSubview:timeLab];
    
    //地址 电话 View
    UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(0, imgV.frame.origin.y + imgV.frame.size.height , ScreenWidth, 30*ScreenHeight/568)];
    [addView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:addView];
    
    UIImageView *addImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, 10*ScreenHeight/568, 10*ScreenHeight/568, 10*ScreenHeight/568)];
    [addImgV setImage:LoadImage(@"", @"png")];
    [addView addSubview:addImgV];
    
    shopLab = [[UILabel alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, 0, 250*ScreenWidth/320, 30*ScreenHeight/568)];
    [shopLab setFont:[UIFont systemFontOfSize:12.0f]];
    [shopLab setTextColor:[UIColor grayColor]];
    [shopLab setText:[NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:0] objectForKey:@"Organizer"]]];
    [addView addSubview:shopLab];
    
    UIView *verticalView = [[UIView alloc] initWithFrame:CGRectMake(270*ScreenWidth/320, 0, 1.0f, 30*ScreenHeight/568)];
    [verticalView setBackgroundColor:UIColorFromHex(0xeeeeee)];
    [addView addSubview:verticalView];
    
    //电话
    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(270*ScreenWidth/320, 0, 30*ScreenHeight/568, 30*ScreenHeight/568)];
    [phoneBtn setImage:LoadImage(@"", @"png") forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(makeTelPhoneNum:) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:phoneBtn];
    
    //评星、报名View
    UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(0, addView.frame.origin.y + addView.frame.size.height + 5*ScreenHeight/568, ScreenWidth, 30*ScreenHeight/568)];
    [starView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:starView];
    
    peopleLab = [[UILabel alloc] initWithFrame:CGRectMake(240*ScreenWidth/320, 0, 80*ScreenWidth/320, 30*ScreenHeight/568)];
    [peopleLab setFont:[UIFont systemFontOfSize:10.0f]];
    [peopleLab setTextColor:[UIColor grayColor]];
    [peopleLab setText:[NSString stringWithFormat:@"已%@人报名参加",[[infoArray objectAtIndex:0] objectForKey:@"JoinMan"]]];
    [starView addSubview:peopleLab];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, starView.frame.origin.y + starView.frame.size.height, ScreenWidth, 1.0f)];
    [lineV setBackgroundColor:UIColorFromHex(0xeeeeee)];
    [infoView addSubview:lineV];
    

    //电话
    phoneStr = [[infoArray objectAtIndex:0] objectForKey:@"Contact"];
//    phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 300*ScreenWidth/320, 15)];
//    [phoneLab setFont:[UIFont systemFontOfSize:10.0f]];
//    [phoneLab setTextColor:[UIColor grayColor]];
//    [phoneLab setText:[NSString stringWithFormat:@"活动时间:      %@",[[infoArray objectAtIndex:0] objectForKey:@"Contact"]]];
//    [self.view addSubview:phoneLab];
    
    limitNumLab = [[UILabel alloc] initWithFrame:CGRectMake(165, 185, 150*ScreenWidth/320, 15)];
    [limitNumLab setFont:[UIFont systemFontOfSize:10.0f]];
    [limitNumLab setTextColor:[UIColor grayColor]];
    [limitNumLab setText:[NSString stringWithFormat:@"限定人数:      %@",[[infoArray objectAtIndex:0] objectForKey:@"LimitNum"]]];
//    [self.view addSubview:limitNumLab];
    
    detailWebV = [[UIWebView alloc] initWithFrame:CGRectMake(0, lineV.frame.size.height + lineV.frame.origin.y, 320*ScreenWidth/320, ScreenHeight-264)];
    [detailWebV setBackgroundColor:[UIColor whiteColor]];
    [detailWebV setDelegate:self];
    [detailWebV loadHTMLString:[[infoArray objectAtIndex:0] objectForKey:@"ActDetail"] baseURL:nil];
    [self.view addSubview:detailWebV];
    
    //    self.shareLogoImg = [Urls stringByAppendingString:logo];
    self.shareLogoImg = [self loadWebImage:[Urls stringByAppendingString:logo]];
    self.shareActID = [[infoArray objectAtIndex:0] objectForKey:@"ActID"];
    self.shareText = [[infoArray objectAtIndex:0] objectForKey:@"ShareText"];
    self.shareUrl = [[infoArray objectAtIndex:0] objectForKey:@"ShareUrl"];
}

- (void)addNavigationRightItem {
    UIButton *sharedBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [sharedBt setImage:LoadImage(@"shareBt@2x", @"png") forState:UIControlStateNormal];
    [sharedBt addTarget:self action:@selector(searchBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:sharedBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];
}
- (IBAction)searchBtClicked:(id)sender {
    NSLog(@"~~~  点击了WebViewController 中的分享按钮 ~~~");
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UmengKey
//                                      shareText:self.shareText
//                                     shareImage:self.shareLogoImg
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,nil]
//                                       delegate:self];
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
//    [UMSocialData defaultData].extConfig.qqData.title = @"";
//    [UMSocialData defaultData].extConfig.qqData.url = self.shareUrl;
    

}

//#pragma mark--
//#pragma 分享统计
////实现回调方法（可选）：
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


- (IBAction)AC_DetaillVCFuncBtClicked:(id)sender {
    NSLog(@"~~~  点击了活动报名 ~~~");
    ActivityApplyViewController *activityApplyVC = [[ActivityApplyViewController alloc] init];
    [activityApplyVC setTitle:@"活动报名"];
    [self.navigationController pushViewController:activityApplyVC animated:YES];
//    SubmitAppliViewController *submitAppVC = [[SubmitAppliViewController alloc] init];
//    [submitAppVC setTitle:@"活动报名"];
//    submitAppVC.SubmitFlag = 0;
//    submitAppVC.activeID = activeID;
//    [self.navigationController pushViewController:submitAppVC animated:YES];
}

//打电话
- (void)makeTelPhoneNum:(id)sender
{
    NSLog(@"拨打电话");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"电话咨询" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:phoneStr otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
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

#pragma mark - ProgressView Delegate
- (void)showProgressView {
    [progressView removeFromSuperview];
    progressView = [[MRProgressOverlayView alloc] init];
    progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    [self.view addSubview:progressView];
    
    [progressView show:YES];
}
- (void)dismissProgressView:(NSString *)titleStr {
    if (titleStr.length > 0) {
        [progressView setTitleLabelText:titleStr];
        [progressView performBlock:^{
            [progressView dismiss:YES];
        }afterDelay:0.8f];
    }else {
        [progressView dismiss:YES];
    }
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
