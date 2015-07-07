//
//  HomeView.m
//  ZXYY
//
//  Created by soldier on 15/3/31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        homeTableDataArray = [[NSMutableArray alloc] init];
        homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        [homeTableView setBackgroundColor:[UIColor whiteColor]];
        [homeTableView setShowsHorizontalScrollIndicator:NO];
        [homeTableView setShowsVerticalScrollIndicator:NO];
        [homeTableView setDelegate:self];
        [homeTableView setDataSource:self];
        [homeTableView setSeparatorColor:[UIColor clearColor]];
        [self addSubview:homeTableView];
        
        [self creatADView];
        [self updateHomeViewData];
        
        progressView = [[MRProgressOverlayView alloc] init];
        progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
        [self addSubview:progressView];
        //初始化AFNetwork
        interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(homePageNetworkResult:)];
        
        //添加上提加载、下拉更多
        self.refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:homeTableView viewDelegate:self];

    }
    return self;
}

#pragma mark -
#pragma mark 广告类型_模板
- (void) creatADView
{
    adView = [[ADCustomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,125*ScreenHeight/568)];
    adView.delegate = self;
    [adView setType:left_Circle];
    [self addSubview:adView];
//    viewHeight += adView.frame.size.height + adView.frame.origin.y;
    [homeTableView setTableHeaderView:adView];
}

- (void)selectADCustomViewItem:(NSString *)ad_Id infoStr:(NSString *)info {
    NSLog(@"~~~ Select ADViewItem AD_Id : %@ ~~~",ad_Id);
    if ([_delegate respondsToSelector:@selector(selectHomeADItem:)]) {
        [_delegate selectHomeADItem:info];
    }
    
}

//更新广告数据
- (void)updateHomeViewData {
    NSMutableArray *AD_InfoArray = [[NSMutableArray alloc] init];
    for (int i = 0;  i < 3; i++) {
        ADDataBean *bean = [[ADDataBean alloc] init];
        bean.ad_id = [NSString stringWithFormat:@"%d",i];
        bean.ad_image = @"http://img3.3lian.com/2013/v9/96/82.jpg";
        [AD_InfoArray addObject:bean];
    }
    [adView refreshImage:AD_InfoArray placeHolderImage:@"placeholder@2x"];
}


#pragma mark -
#pragma mark UITableView Delegate
- (void)updateTableViewInfo:(NSMutableArray *)dataArray {
    
    if (NodeID == 0) {
        [homeTableDataArray removeAllObjects];
        [homeTableDataArray setArray:dataArray];
    }else if (NodeID > 0) {
        for (int i = 0; i < [dataArray count]; i++) {
            [homeTableDataArray addObject:[dataArray objectAtIndex:i]];
        }
    }
    [homeTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [homeTableDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int typeTag = [[[homeTableDataArray objectAtIndex:indexPath.row] objectForKey:@"NodeType"] intValue];
    switch (typeTag) {
        case 0://0为装修进度数据
        case 1://1为知识库数据
        case 3://3为阶段性进度报告
            return 200;
            break;
        case 2://2为提醒数据
            return 100;
            break;
        case 4://4为效果图
            return 310;
            break;
        case 5://5装修日记类型数据
        case 6://6为看装修数据
            return 260;
            break;
        default:
            return 310;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"homeTableCell";
    HomeViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[HomeViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    int typeTag = [[[homeTableDataArray objectAtIndex:indexPath.row] objectForKey:@"NodeType"] intValue];
    switch (typeTag) {
        case 0://0为装修进度数据
            [cell setHome_JDSJ_Cell:[homeTableDataArray objectAtIndex:indexPath.row]];
            break;
        case 1://1为知识库数据
            [cell setHome_ZSK_Cell:[homeTableDataArray objectAtIndex:indexPath.row]];
            break;
        case 2://2为提醒数据
            [cell setHome_TXSJ_Cell:[homeTableDataArray objectAtIndex:indexPath.row]];
            break;
        case 3://3为阶段性进度报告
            [cell setHome_JDSJ_Cell:[homeTableDataArray objectAtIndex:indexPath.row]];
            break;
        case 4://4为效果图
            [cell setHome_XGT_Cell:[homeTableDataArray objectAtIndex:indexPath.row]];
            break;
        case 5://5装修日记类型数据
            [cell setHome_ZXRJ_Cell:[homeTableDataArray objectAtIndex:indexPath.row]];
            break;
        case 6://6为看装修数据
            [cell setHome_KZX_Cell:[homeTableDataArray objectAtIndex:indexPath.row]];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark -
#pragma mark NetworkInterface Delegate
- (void)sendHome_NetworkInfoData:(NSString *)urlStr NodeID:(int) nodeId {
    NodeID = nodeId;
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:@"0" forKey:@"NodeID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ProjectID"] forKey:@"ProjectID"];
    [postData setValue:[NSString stringWithFormat:@"%d",NodeID] forKey:@"NodeID"];
    
    [interface setInterfaceDidFinish:@selector(homeNetworkResult:)];
    [interface sendRequest:urlStr Parameters:postData Type:get_request];
}

- (void)homeNetworkResult:(NSDictionary *)result
{
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSLog(@"HomeView Line:291行 homeNetworkResult:/n %@",result);
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:        [FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        [self updateTableViewInfo:dataArray];
        
    }else {
        NSLog(@"homeView.m Line:296行 homeNetworkResult ErrorMsg :/n %@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
}

#pragma mark -
#pragma mark CLLRefreshHeadController Delegate
- (CLLRefreshViewLayerType)refreshViewLayerType {
    return CLLRefreshViewLayerTypeOnSuperView;
}
- (BOOL)hasRefreshFooterView {
    return NO;
}
- (BOOL)hasRefreshHeaderView {
    return YES;
}
- (void)beginPullDownRefreshing {
    //        [postDtaDic setValue:@"1" forKey:@"page"];
    //        [networkData startPost:RestaurantInterface params:postDtaDic tag:33];
}
- (void)beginPullUpLoading {
    //    int pageCount = [[postDtaDic objectForKey:@"page"] intValue];
    //    [postDtaDic setValue:[NSString stringWithFormat:@"%d",pageCount+1] forKey:@"page"];
    //    [networkData startPost:RestaurantInterface params:postDtaDic tag:3];
}
- (void)endRefreshing {
    [self.refreshControll endPullDownRefreshing];
}
- (void)endLoadMore {
    [self.refreshControll endPullUpLoading];
}


#pragma mark -
#pragma mark ProgressView Delegate
- (void)showProgressView {
    [progressView removeFromSuperview];
    progressView = [[MRProgressOverlayView alloc] init];
    progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    [self addSubview:progressView];
    
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

@end
