//
//  ChooseMarkViewController.m
//  ZXY
//
//  Created by soldier on 15/7/1.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ChooseMarkViewController.h"

@interface ChooseMarkViewController ()

@end

@implementation ChooseMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    commonMarkArray = @[@"前期准备",@"交房验房",@"前期设计",@"前服务包",@"开工大吉"];
    otherMarkArray = @[@"装修开工",@"主体拆改",@"水电改造",@"水电验收",@"防水",@"贴砖",@"木工",@"泥土验收",@"墙面刷漆",@"家具刷漆",@"有功验收",@"厨卫吊顶",@"橱柜安装",@"门窗安装",@"铺地板",@"贴壁纸",@"插座安装",@"灯具安装",@"五金安装",@"洁具安装",@"窗帘安装",@"竣工验收",@"拓荒保洁",@"家具进场",@"家电安装",@"后期装饰",@"甲醛检测",@"乔迁新居",@"毕业照",@"经验总结",@"产品选购",@"碎碎念"];
    
    [self setChooseMarkCustomView];
}

//设置 “装修标签” 页面
- (void)setChooseMarkCustomView
{
    //常用标签
    UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 10*ScreenHeight/568, 55*ScreenWidth/320, 15*ScreenHeight/568)];
    [commonLabel setBackgroundColor:UIColorFromHex(0x35c083)];
    [commonLabel setText:@"常用标签"];
    [commonLabel setTextColor:[UIColor whiteColor]];
    [commonLabel setTextAlignment:NSTextAlignmentCenter];
    [commonLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:commonLabel];
    
    
    for (int i = 0; i<[commonMarkArray count]; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((10+i%5*62)*ScreenWidth/320, 64 + (35 + i/5*30)*ScreenHeight/568, 52*ScreenWidth/320, 20*ScreenHeight/568)];
        btn.layer.borderColor = [[UIColor grayColor] CGColor];
        btn.layer.borderWidth = 0.5f;
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:2.0f];
        [btn setTag:20000+i];
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [btn setTitle:[commonMarkArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseCommentMarkBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    //其他标签
    UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + (35 +(([commonMarkArray count] -1)/5 +1)*30)*ScreenHeight/568, 55*ScreenWidth/320, 15*ScreenHeight/568)];
    [otherLabel setBackgroundColor:UIColorFromHex(0x35c083)];
    [otherLabel setText:@"其他标签"];
    [otherLabel setTextColor:[UIColor whiteColor]];
    [otherLabel setTextAlignment:NSTextAlignmentCenter];
    [otherLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:otherLabel];
    
    
    for (int j = 0; j<[otherMarkArray count]; j++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((10 +j%5*62)*ScreenWidth/320, (10 + j/5*30)*ScreenHeight/568 + otherLabel.frame.size.height + otherLabel.frame.origin.y, 52*ScreenWidth/320, 20*ScreenHeight/568)];
        btn.layer.borderColor = [[UIColor grayColor] CGColor];
        btn.layer.borderWidth = 0.5f;
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:2.0f];
        [btn setTag:200000+j];
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [btn setTitle:[otherMarkArray objectAtIndex:j] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseOtherMarkBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)chooseCommentMarkBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([_delegate respondsToSelector:@selector(setMarkLabelText:)]) {
        [_delegate setMarkLabelText:[commonMarkArray objectAtIndex:(btn.tag - 20000)]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)chooseOtherMarkBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([_delegate respondsToSelector:@selector(setMarkLabelText:)]) {
        [_delegate setMarkLabelText:[otherMarkArray objectAtIndex:(btn.tag - 200000)]];
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
