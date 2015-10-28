//
//  ActivityViewController.m
//  ZXY
//
//  Created by soldier on 15/6/20.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityDetailViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    allActiveArray = [[NSMutableArray alloc] init];
    myActionArray = [[NSMutableArray alloc] init];
    
    [self setActivityCustomView];
    [self setActivityTitleView];
    [self addScreeningBarButton];
}

//设置标题（选择开关按钮）
- (void)setActivityTitleView
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"全部优惠",@"我的优惠", nil]];
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
//    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"zyyy_choose_middle.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"zyyy_choose_middle_touch.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;//设置样式      segmentedControl.frame = CGRectMake(100, 100, 120, 44);
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    self.navigationItem.titleView = segmentedControl; //添加到导航栏（通过视图控制器）
    
    [self sendActiveRequest:GetActList];
}

//设置右导航“筛选”按钮addNavigationRightItem
- (void)addScreeningBarButton
{
    UIButton *searchBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [searchBt setBackgroundColor:[UIColor clearColor]];
//    [searchBt setImage:LoadImage(@"searchBt@2x", @"png") forState:UIControlStateNormal];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:LoadImage(@"", @"png")];
    [imgV setFrame:CGRectMake(0, 10, 10, 10)];
    [searchBt addSubview:imgV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [label setText:@"筛选"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:11.0f]];
    [searchBt addSubview:label];
    
    [searchBt addTarget:self action:@selector(searchBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:searchBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];

}

//设置活动页面
- (void)setActivityCustomView
{
    bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
    [bgImgV setBackgroundColor:[UIColor clearColor]];
    //        UIImage *image = LoadImage(@"bgImgV@2x", @"jpg");
    UIImage *image = LoadImage(@"BgActivityImgV@2x", @"jpg");
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/5*3, 0, 0, 0);
    [bgImgV setImage:[image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch]];
    [self.view addSubview:bgImgV];

    activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [activityTableView setBackgroundColor:[UIColor clearColor]];
    [activityTableView setShowsHorizontalScrollIndicator:NO];
//    [activityTableView setScrollEnabled:NO];
    [activityTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    activityTableView.delegate = self;
    activityTableView.dataSource = self;
    [self.view addSubview:activityTableView];
    
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(networkActiveResult:)];
    
    refreshHeader = [SDRefreshHeaderView refreshView];
    [refreshHeader addToScrollView:activityTableView];
    [refreshHeader addTarget:self refreshAction:@selector(headerRereshing)];
    
    refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:activityTableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRereshing)];
}

//- (void)updateViewInfo:(int)type Num:(int)num {
//    [allActivesBt setSelected:YES];
//    [myActivesBt setSelected:NO];
//    pageNum = num;
//    self.selectType = type;
//    [self sendActiveRequest:GetActList];
//    
//}


#pragma mark -
#pragma mark NetworkInterface Delegate
//发送获取活动列表请求
- (void)sendActiveRequest:(NSString *)url {
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:[NSString stringWithFormat:@"%d",self.selectType] forKey:@"Type"];
    [postData setValue:[NSString stringWithFormat:@"%d",pageNum] forKey:@"NodeID"];
    
    NSLog(@"~~~~~~~~ postData :%@",postData);
    
    [interface setInterfaceDidFinish:@selector(networkActiveResult:)];
    [interface sendRequest:url Parameters:postData Type:get_request];
}
//获取活动列表请求
- (void)networkActiveResult:(NSDictionary *)result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        pageNum = [[self getMixActID:dataArray] intValue];
        NSLog(@"~~~ 获取完成正常请求的活动数据 ~~~");
        if (self.selectType == 0) {
            [allActiveArray setArray:dataArray];
        }else if (self.selectType == 1) {
            [myActionArray setArray:dataArray];
        }
        [bgImgV setHidden:YES];
    }else {
        NSLog(@"~~~ Error Msg :%@ ~~~",[result objectForKey:@"Msg"]);
        if (self.selectType == 0) {
            UIImage *image = LoadImage(@"BgActivityImgV@2x", @"jpg");
            UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/5*3, 0, 0, 0);
            [bgImgV setImage:[image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch]];
            [bgImgV setHidden:NO];
        }else if (self.selectType == 1) {
            UIImage *image = LoadImage(@"BgActivityImgV@2x", @"jpg");
            UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/5*3, 0, 0, 0);
            [bgImgV setImage:[image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch]];
            [bgImgV setHidden:NO];
        }
        
    }
    [activityTableView reloadData];
}

- (void)DownRefreshingRequest:(NSString *)url{
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:[NSString stringWithFormat:@"%d",self.selectType] forKey:@"Type"];
    [postData setValue:[NSString stringWithFormat:@"%d",pageNum] forKey:@"NodeID"];
    [interface setInterfaceDidFinish:@selector(DownRefreshingResult:)];
    [interface sendRequest:url Parameters:postData Type:get_request];
}

- (void)DownRefreshingResult:(NSDictionary *)result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        pageNum = [[self getMixActID:dataArray] intValue];
        NSLog(@"~~~ 获取完成加载或刷新请求的活动数据 ~~~");
        if (self.selectType == 0) {
            if (self.refreshType == 1) {
                for (int i = 0; i < [dataArray count]; i++) {
                    [allActiveArray addObject:[dataArray objectAtIndex:i]];
                }
                [refreshFooter endRefreshing];
            }else {
                [allActiveArray setArray:dataArray];
                [refreshHeader endRefreshing];
            }
            [activityTableView reloadData];
        }else if (self.selectType == 1) {
            if (self.refreshType == 1) {
                for (int i = 0; i < [dataArray count]; i++) {
                    [myActionArray addObject:[dataArray objectAtIndex:i]];
                }
                [refreshFooter endRefreshing];
            }else {
                [myActionArray setArray:dataArray];
                [refreshHeader endRefreshing];
            }
            [activityTableView reloadData];
        }
    }else {
        NSLog(@"~~~ Error Msg :%@ ~~~",[result objectForKey:@"Msg"]);
        if (self.refreshType == 1) {
            [refreshFooter endRefreshing];
        }else {
            [refreshHeader endRefreshing];
        }
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectType == 0) {
        return [allActiveArray count];
    }else if (self.selectType == 1) {
        return [myActionArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f*ScreenHeight/568;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"listCell";
    activityTableVcell= [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!activityTableVcell) {
        activityTableVcell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        
        [activityTableVcell setBackgroundColor:[UIColor clearColor]];
        
    }
    
    if (self.selectType == 0) {
        [activityTableVcell updateActiveCellData:[allActiveArray objectAtIndex:indexPath.row]];
    }else if (self.selectType == 1) {
        [activityTableVcell updateActiveCellData:[myActionArray objectAtIndex:indexPath.row]];
    }
    
    return activityTableVcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectType == 0) {
        [self sendActiveDetailRequest:GetActDetail ActivID:[[allActiveArray objectAtIndex:indexPath.row] objectForKey:@"ActID"]];
    }else
    {
        [self sendActiveDetailRequest:GetActDetail ActivID:[[myActionArray objectAtIndex:indexPath.row] objectForKey:@"ActID"]];

    }

}

//发送获取活动详情请求
- (void)sendActiveDetailRequest:(NSString *)url ActivID:(NSString *)activID {
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:activID forKey:@"ActID"];
    
    [interface setInterfaceDidFinish:@selector(networkActiveDetailResult:)];
    [interface sendRequest:url Parameters:postData Type:get_request];
}
//获取活动详情结果
- (void)networkActiveDetailResult:(NSDictionary *)result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        NSLog(@"~~~ Detail dataArray:%@ ~~~",dataArray);
        
        ActivityDetailViewController *ac_dVC = [[ActivityDetailViewController alloc] init];
        [ac_dVC setTitle:@"优惠活动"];
        [ac_dVC updateACDetailInfo:dataArray ac_DetailType:1];
        [self.navigationController pushViewController:ac_dVC animated:YES];
        
    }else {
        NSLog(@"~~~ Error Msg :%@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
}



//选择控制事件
-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    NSLog(@"Index %lu", Index);
    
    switch (Index) {
            
        case 0:
            pageNum = 0;
            self.selectType = 0;
            break;
        case 1:
            pageNum = 0;
            self.selectType = 1;
            break;
    }
    [self sendActiveRequest:GetActList];

}

//"筛选"按钮
- (void)searchBtClicked:(id)sender
{
    NSLog(@"筛选 ………………");
}

#pragma mark -
#pragma mark CLLRefreshHeadController Delegate
- (void)headerRereshing {
    self.refreshType = 0;
    pageNum = 0;
    [self DownRefreshingRequest:GetActList];
}

- (void)footerRereshing {
    self.refreshType = 1;
    [self DownRefreshingRequest:GetActList];
}

- (NSString *)getMixActID:(NSMutableArray *)dataArray {
    NSMutableArray *storeArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArray.count; i++) {
        [storeArray addObject:[[dataArray objectAtIndex:i] objectForKey:@"ActID"]];
    }
    NSString *minActID = [storeArray valueForKeyPath:@"@min.intValue"];
    return minActID;
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

- (void)dealloc
{
    [refreshHeader deallocObserver];
    [refreshFooter deallocObserver];
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
