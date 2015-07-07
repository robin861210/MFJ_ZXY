//
//  SmartOfferViewController.m
//  ZXY
//
//  Created by soldier on 15/7/4.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "SmartOfferViewController.h"

@interface SmartOfferViewController ()

@end

@implementation SmartOfferViewController
@synthesize smartOfferArr = _smartOfferArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setSmartOfferCustomView];
    [self setConfirmOfferBarButton];
}

- (void)setSmartOfferCustomView
{
    viewHeight = 64;
    //半包报价
    viewHeight += 15*ScreenHeight/568;
    UILabel *halfTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, viewHeight, 280*ScreenWidth/320, 15*ScreenHeight/568)];
    [halfTitleLab setText:@"半包预估价"];
    [halfTitleLab setTextColor:UIColorFromHex(0x999999)];
    [halfTitleLab setTextAlignment:NSTextAlignmentLeft];
    [halfTitleLab setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:halfTitleLab];
    viewHeight +=15*ScreenHeight/568;
    
    halfPriceLabel  = [[UILabel alloc] initWithFrame:CGRectMake(16*ScreenWidth/320, viewHeight, 280*ScreenWidth/320, 30*ScreenHeight/568)];
    [halfPriceLabel setText:@"￥26600.00"];
    [halfPriceLabel setTextColor:UIColorFromHex(0x35c083)];
    [halfPriceLabel setTextAlignment:NSTextAlignmentLeft];
    [halfPriceLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [self.view addSubview:halfPriceLabel];
    viewHeight +=35*ScreenHeight/568;
    
//    viewHeight +=10*ScreenHeight/568;
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, viewHeight, 280*ScreenWidth/320, 1.0f)];
    [lineView1 setBackgroundColor:UIColorFromHex(0x999999)];
    [self.view addSubview:lineView1];

    //全包报价
    viewHeight +=15*ScreenHeight/568;
    UILabel *allTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, viewHeight, 280*ScreenWidth/320, 15*ScreenHeight/568)];
    [allTitleLab setText:@"全包预估价"];
    [allTitleLab setTextColor:UIColorFromHex(0x999999)];
    [allTitleLab setTextAlignment:NSTextAlignmentLeft];
    [allTitleLab setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:allTitleLab];
    viewHeight +=15*ScreenHeight/568;
    
    allPriceLabel  = [[UILabel alloc] initWithFrame:CGRectMake(16*ScreenWidth/320, viewHeight, 280*ScreenWidth/320, 30*ScreenHeight/568)];
    [allPriceLabel setText:@"￥56392.00"];
    [allPriceLabel setTextColor:UIColorFromHex(0x35c083)];
    [allPriceLabel setTextAlignment:NSTextAlignmentLeft];
    [allPriceLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [self.view addSubview:allPriceLabel];
    viewHeight +=35*ScreenHeight/568;
    
//    viewHeight +=10*ScreenHeight/568;
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, viewHeight, 280*ScreenWidth/320, 1.0f)];
    [lineView2 setBackgroundColor:UIColorFromHex(0x999999)];
    [self.view addSubview:lineView2];
    viewHeight += 15*ScreenHeight/568;
    
    //温馨提示
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, viewHeight, 280*ScreenWidth/320, 20*ScreenHeight/568)];
    [promptLabel setText:@"温馨提示：以上数据仅供参考，如果要精确报价，请联系装修易在线客服进行咨询"];
    [promptLabel setTextColor:UIColorFromHex(0x999999)];
    [promptLabel setTextAlignment:NSTextAlignmentLeft];
    [promptLabel setNumberOfLines:0];
    [promptLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [promptLabel setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [self.view addSubview:promptLabel];
}

//设置右导航“确认”按钮addNavigationRightItem
- (void)setConfirmOfferBarButton
{
    UIButton *sendConfirmBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [sendConfirmBt setTitle:@"确认" forState:UIControlStateNormal];
    [sendConfirmBt setTitleColor:UIColorFromHex(0x35c083) forState:UIControlStateNormal];
    sendConfirmBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [sendConfirmBt addTarget:self action:@selector(sendConfirmOfferBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:sendConfirmBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];
    
}

//确认 并返回 首页
- (void)sendConfirmOfferBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
