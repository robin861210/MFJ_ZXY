//
//  LeftViewController.m
//  ZXY
//
//  Created by acewill on 15/6/12.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "LeftViewController.h"
#import "DDMenuController.h"
#import "SettingViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor orangeColor]];
    listIconArray = @[@"center_dec_archives@2x",@"center_dec_diary@2x",@"center_computer@2x",@"center_activity@2x",@"center_score_shop@2x",@"center_give_angry@2x",@"center_advice@2x",@"center_setting@2x"];
    listNameArray = @[@"装修档案",@"装修日记",@"装修计算器",@"优惠活动",@"积分商城",@"投诉建议",@"意见反馈",@"设置"];
    
    UIImageView *backgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backgImgView setImage:LoadImage(@"center_back@2x", @"png")];
    [self.view addSubview:backgImgView];

    [self setPersonCenterView];
    
    [self setFundutionCustomView];
}


//“个人信息”页面
- (void)setPersonCenterView
{
    //头像
    UIImageView *headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(75, 65, 75, 75)];
    headImgV.layer.cornerRadius = 37.5f;
    [headImgV.layer setMasksToBounds:YES];
    [headImgV setImage:LoadImage(@"head", @"jpg ")];
    [self.view addSubview:headImgV];
    
    //用户昵称
    UILabel *nickNameLab = [[UILabel alloc] initWithFrame:CGRectMake(155, 90, 130, 20)];
    [nickNameLab setText:@"Melodo1019"];
    [nickNameLab setTextColor:[UIColor whiteColor]];
    [nickNameLab setTextAlignment:NSTextAlignmentLeft];
    [nickNameLab setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:nickNameLab];
    
    //积分
    UILabel *integralLab = [[UILabel alloc] initWithFrame:CGRectMake(155, 110, 130, 15)];
    [integralLab setText:@"当前积分：1250 可兑换"];
    [integralLab setTextColor:[UIColor whiteColor]];
    [integralLab setTextAlignment:NSTextAlignmentLeft];
    [integralLab setFont:[UIFont systemFontOfSize:11.0f]];
    [self.view addSubview:integralLab];
}

- (void)setFundutionCustomView
{
    listTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, 280, ScreenHeight-80) style:UITableViewStylePlain];
    [listTableV setBackgroundColor:[UIColor clearColor]];
    [listTableV setShowsHorizontalScrollIndicator:NO];
    [listTableV setScrollEnabled:NO];
    [listTableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    listTableV.delegate = self;
    listTableV.dataSource = self;
    [self.view addSubview:listTableV];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listNameArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        //图标
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, 12, 20, 20)];
        [iconImageView setImage:LoadImage([listIconArray objectAtIndex:indexPath.row], @"png")];
        [cell addSubview:iconImageView];
        
        //功能
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, 100, 20)];
        [label setText:[listNameArray objectAtIndex:indexPath.row]];
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setFont:[UIFont systemFontOfSize:18.0f]];
        [cell addSubview:label];
        
        //箭头
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 12, 20, 20)];
        [arrowImgView setImage:LoadImage(@"center_right@2x", @"png")];
        [cell addSubview:arrowImgView];
        
        //分割线
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 280, 10)];
        [lineImgView setImage:LoadImage(@"center_diviler@2x", @"png")];
        [cell addSubview:lineImgView];
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    
    [menuController showRootController:YES];
//    SettingViewController *settingVC = [[SettingViewController alloc] init];
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    
//    CustomNavigationController *navController = [[CustomNavigationController alloc] initWithRootViewController:mainVC];
////    [navController setToolbarHidden:NO animated:YES];
//
//    [menuController setRootController:navController animated:YES];
    
    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case 0:
            NSLog(@"装修档案");
            break;
        case 1:
            NSLog(@"装修日记");
            break;
        case 2:
            NSLog(@"装修计算器");
            break;
        case 3:
            NSLog(@"优惠活动");
            break;
        case 4:
            NSLog(@"积分商城");
            break;
        case 5:
            NSLog(@"投诉建议");
            break;
        case 6:
            NSLog(@"意见反馈");
            break;
        case 7:
            NSLog(@"设置");
        {
            SettingViewController *settingVC = [[SettingViewController alloc] init];
            [settingVC setTitle:@"设置"];
            viewController = settingVC;
        }
            break;
            
        default:
            break;
    }
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:viewController,@"viewC", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToFunctionVC" object:nil userInfo:dict];
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
