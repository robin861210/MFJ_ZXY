//
//  ChoosePhaseViewController.m
//  ZXY
//
//  Created by soldier on 15/7/2.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ChoosePhaseViewController.h"

@interface ChoosePhaseViewController ()

@end

@implementation ChoosePhaseViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    titleArray = @[@"设计",@"水电",@"瓦工",@"木工",@"油工",@"成品安装",@"工程竣工",@"售后服务"];
    
    [self setChoosePhaseCustomView];
    
    [self addChoosePhaseBarButton];
    
}

- (void)setChoosePhaseCustomView
{
    for (int i = 0; i<[titleArray count]; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((20+i%4*80)*ScreenWidth/320, 74 +i/4*80*ScreenHeight/568, 40*ScreenHeight/568, 40*ScreenHeight/568)];
        [btn setBackgroundColor:UIColorFromHex(0x35c083)];
        btn.layer.borderWidth = 0.6f;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 20*ScreenHeight/568;
        [btn addTarget:self action:@selector(choosePhaseBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+2000;
        [self.view addSubview:btn];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(i%4*80*ScreenWidth/320, 74 +i/4*80*ScreenHeight/568+45*ScreenHeight/568, 80*ScreenWidth/320, 20*ScreenHeight/568)];
        [titleLab setText:[titleArray objectAtIndex:i]];
        [titleLab setTextAlignment:NSTextAlignmentCenter];
        [titleLab setFont:[UIFont systemFontOfSize:13.0f]];
        [titleLab setTextColor:UIColorFromHex(0x999999)];
        [self.view addSubview:titleLab];
        
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, 74+170*ScreenHeight/568, 310*ScreenWidth/320, 1.0f)];
    [lineView setBackgroundColor:UIColorFromHex(0xf7f7f7)];
    [self.view addSubview:lineView];
    
    //装修阶段标题
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*ScreenWidth/320,10+ lineView.frame.size.height + lineView.frame.origin.y, 300*ScreenWidth/320, 20*ScreenHeight/568)];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [titleLabel setTextColor:UIColorFromHex(0x35c083)];
    [self.view addSubview:titleLabel];

    //阶段描述
    describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, titleLabel.frame.size.height + titleLabel.frame.origin.y, 300*ScreenWidth/320, 20*ScreenHeight/568)];
    [describeLabel setTextAlignment:NSTextAlignmentLeft];
    [describeLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [describeLabel setTextColor:UIColorFromHex(0x999999)];
    [describeLabel setNumberOfLines:0];
    [describeLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [self.view addSubview:describeLabel];
}

//设置右导航“筛选”按钮addNavigationRightItem
- (void)addChoosePhaseBarButton
{
    UIButton *completeBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [completeBt setBackgroundColor:[UIColor clearColor]];
    [completeBt setTitle:@"完成" forState:UIControlStateNormal];
    completeBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [completeBt setTitleColor:UIColorFromHex(0x35c083) forState:UIControlStateNormal];
    [completeBt addTarget:self action:@selector(completeChoosePhaseBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:completeBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];
    
}


- (void)choosePhaseBtn:(id)sender
{
    for (int i = 0; i<[titleArray count]; i++) {
        UIButton *phaseButton = (UIButton *)[self.view viewWithTag:i+2000];
//        [phaseButton setImage:LoadImage(@"", @"png") forState:UIControlStateNormal];
        [phaseButton setBackgroundColor:[UIColor blackColor]];
    }
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 2000:
            NSLog(@"设计阶段");
            break;
        case 2001:
            NSLog(@"水电阶段");
            break;
        case 2002:
            NSLog(@"瓦工阶段");
            break;
        case 2003:
            NSLog(@"木工阶段");
            break;
        case 2004:
            NSLog(@"油工阶段");
            break;
        case 2005:
            NSLog(@"成品安装阶段");
            break;
        case 2006:
            NSLog(@"工程竣工阶段");
            break;
        case 2007:
            NSLog(@"售后服务阶段");
            break;
            
        default:
            break;
    }
    
    
    //按钮换图片
    UIButton *phaseBtn = (UIButton *)[self.view viewWithTag:button.tag];
//    [phaseBtn setImage:LoadImage(@"", @"png") forState:UIControlStateNormal];
    [phaseBtn setBackgroundColor:UIColorFromHex(0x35c083)];
    
    //记录选择各阶段按钮
    phaseType = button.tag - 2000;
    
    [titleLabel setText:[titleArray objectAtIndex:phaseType]];

    [describeLabel setText:@"开工前确认图纸以及装修方案，材料，工人，时间等……"];
}

//确认 选择 阶段 按钮
- (void)completeChoosePhaseBtClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(setPhaseLabelText:)]) {
        [_delegate setPhaseLabelText:titleLabel.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
