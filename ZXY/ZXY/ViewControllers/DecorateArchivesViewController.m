//
//  DecorateArchivesViewController.m
//  ZXY
//
//  Created by soldier on 15/6/15.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "DecorateArchivesViewController.h"
#import "RenderingViewController.h"
#import "DA_ListViewController.h"

@interface DecorateArchivesViewController () 
@end

@implementation DecorateArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    archivTitleArray = @[@"效果图",@"施工图",@"基础预算",@"主材预算",@"基础变更单",@"主材变更单",@"主材订单",@"交费记录",@"特殊需求"];
    
    [self setDecorateArchivesCustomView];
    [self initNetworkInterface];
}

- (void)setDecorateArchivesCustomView
{
    archiviesTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [archiviesTableView setBackgroundColor:[UIColor clearColor]];
    [archiviesTableView setShowsHorizontalScrollIndicator:NO];
    [archiviesTableView setScrollEnabled:NO];
    [archiviesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    archiviesTableView.delegate = self;
    archiviesTableView.dataSource = self;
    [self.view addSubview:archiviesTableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [archivTitleArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.0f*ScreenHeight/568;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        //功能
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 35*ScreenHeight/568)];
        [label setText:[archivTitleArray objectAtIndex:indexPath.row]];
//        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setFont:[UIFont systemFontOfSize:10.0f]];
        [cell addSubview:label];
        
        //分割线
        UIView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35*ScreenHeight/568, ScreenWidth, 1.0f)];
        [lineView setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        [cell addSubview:lineView];
        
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.textLabel.text = [archivTitleArray objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"~~~~~~~  效果图 ~~~~~~~~");
            self.selectTitle = @"效果图";
            self.selectType = -1;
            [self sendZXDA_Request:GetEffectDraw];
        }
            break;
        case 1:
        {
            self.selectTitle = @"施工图";
            self.selectType = -1;
            [self sendZXDA_Request:GetWorkDraw];
        }
            break;
        case 2:
            self.selectTitle = @"基础预算";
            self.selectType = 0;
            [self sendZXDA_Request:GetBaseBudget];
            break;
        case 3:
            self.selectTitle = @"主材预算";
            self.selectType = 0;
            [self sendZXDA_Request:GetZCBudget];
            break;
        case 4:  //基础变更单
            self.selectTitle = @"基础变更单";
            self.selectType = 1;
            [self sendZXDA_Request:GetChangeBaseBudget];
            break;
        case 5: //主材变更单
            self.selectTitle = @"主材变更单";
            self.selectType = 1;
            [self sendZXDA_Request:GetChangeZCBudget];
            break;
        case 6:
        {
        }
            break;
        case 7:
            self.selectTitle = @"交费记录";
            self.selectType = 2;
            [self sendZXDA_Request:GetPayment];
            break;
        case 8:
        {
        }
            break;
        default:
            break;
    }

}


//初始化progress NetworkInterface
- (void)initNetworkInterface
{
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(DA_NetworkResult:)];
}

#pragma mark -
#pragma mark Network Delegate

- (void)sendZXDA_Request:(NSString *)Url {
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:[[[ProjectInfoUtils sharedProjectInfoUtils] infoDic] objectForKey:@"ProjectID"] forKey:@"ProjectID"];
    
    [interface setInterfaceDidFinish:@selector(DA_NetworkResult:)];
    [interface sendRequest:Url Parameters:postData Type:get_request];
}

- (void)DA_NetworkResult:(NSDictionary *) result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        NSLog(@"~~~ dataArray:%@ ~~~",dataArray);
        
        if (self.selectType == -1) {
            RenderingViewController *renderingVC = [[RenderingViewController alloc] init];
            [renderingVC setTitle:self.selectTitle];
            [renderingVC updateRenderingViewControllerInfo:dataArray];
            [self.navigationController pushViewController:renderingVC animated:YES];
        }else
        {
            DA_ListViewController *listVC = [[DA_ListViewController alloc] init];
            [listVC setTitle:self.selectTitle];
            listVC.headType = self.selectType;
            [listVC updateDA_ListViewControllerInfo:dataArray];
            [self.navigationController pushViewController:listVC animated:YES];
        }
        
    }else {
        NSLog(@"~~~ Error Msg :%@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
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
