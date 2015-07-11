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
    iconArray = @[@"sj@2x",@"dg@2x",@"wg@2x",@"mg@2x",@"yg@2x",@"zpaz@2x",@"ztjg@2x",@"shfw@2x"];
    iconSelectArray = @[@"sjed@2x",@"dged@2x",@"wged@2x",@"mged@2x",@"yged@2x",@"zpazed@2x",@"ztjged@2x",@"shfwed@2x"];
    
    [self setChoosePhaseCustomView];
    
    [self addChoosePhaseBarButton];
    
}

- (void)setChoosePhaseCustomView
{
    for (int i = 0; i<[titleArray count]; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((20+i%4*80)*ScreenWidth/320, 74 +i/4*80*ScreenHeight/568, 40*ScreenHeight/568, 40*ScreenHeight/568)];
        [imgView setImage:LoadImage([iconArray objectAtIndex:i], @"png")];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 20*ScreenHeight/568;
        imgView.userInteractionEnabled = YES;
        imgView.tag = i+2000;
        [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhaseBtn:)] ];
        [self.view addSubview:imgView];

        
        
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


- (void)choosePhaseBtn:(UITapGestureRecognizer *)imageTap
{
    for (int i = 0; i<[titleArray count]; i++) {
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag:i+2000 ];
        [imageView setImage:LoadImage([iconArray objectAtIndex:i], @"png")];
    }
    

    //记录选择各阶段按钮
    phaseType = imageTap.view.tag - 2000;
    
    //按钮换图片
    UIImageView * imageV = (UIImageView *)[self.view viewWithTag: imageTap.view.tag];
    [imageV setImage:LoadImage([iconSelectArray objectAtIndex:phaseType], @"png")];

    
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
