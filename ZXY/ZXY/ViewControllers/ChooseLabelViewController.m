//
//  ChooseLabelViewController.m
//  ZXY
//
//  Created by soldier on 15/6/17.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ChooseLabelViewController.h"

@interface ChooseLabelViewController ()

@end

@implementation ChooseLabelViewController
@synthesize delegate = _delegate;

- (id)init
{
    //户型
    NSArray *modelArray = @[@"小户型",@"中户型",@"大户型",@"别墅"];
    //房厅卫
    NSArray *roomHallWhoArray = @[@"1房2厅3卫",@"1房2厅3卫",@"1房1厅1卫",@"1房2厅2卫",@"2房1厅1卫",@"3房2厅2卫",@"3房1厅2卫",@"3房1厅1卫"];
    //装修档次
    NSArray *gradeArray = @[@"经济实惠",@"奢华内涵",@"高端大气"];
    //装修风格
    NSArray *styleArray = @[@"简约",@"低调",@"豪华",@"奢靡",@"地中海"];
    //所在城市
    NSArray *cityArray = @[@"北京",@"上海",@"广州",@"深圳",@"沈阳",@"天津",@"济南",@"武汉",@"长沙",@"泉州"];
    
    chooseArray = @[modelArray,roomHallWhoArray,gradeArray,styleArray,cityArray];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setChooseLabelCustomView:(NSInteger)chooseTy
{
    for (UIView *v in self.view.subviews) {
        [v removeFromSuperview];
    }
    for (int i = 0; i<[[chooseArray objectAtIndex:(chooseTy-1)] count]; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((10+i%5*62)*ScreenWidth/320, (10 + i/5*30)*ScreenHeight/568, 52*ScreenWidth/320, 20*ScreenHeight/568)];
        btn.layer.borderColor = [[UIColor grayColor] CGColor];
        btn.layer.borderWidth = 0.5f;
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:2.0f];
        [btn setTag:(chooseTy*1000+i)];
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [btn setTitle:[[chooseArray objectAtIndex:(chooseTy-1)] objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseLabelType:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

}

- (void)chooseLabelType:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger labType = btn.tag/1000;
    NSInteger btnTag = btn.tag%1000;
    
    NSString *string = [[chooseArray objectAtIndex:(labType-1)] objectAtIndex:btnTag];
    if ([_delegate respondsToSelector:@selector(setLabelText:AndType:)]) {
        [_delegate setLabelText:string AndType:labType];
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
