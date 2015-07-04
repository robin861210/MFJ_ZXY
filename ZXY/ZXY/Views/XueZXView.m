//
//  XueZXView.m
//  ZXY
//
//  Created by acewill on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "XueZXView.h"
#import "ParallaxHeaderView.h"
#import "ZSK_TableViewCell.h"
#import "XueZX_TableViewCell.h"
#import "WebViewController.h"

@implementation XueZXView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        
        viewWidth = self.frame.size.width;
        viewHeight = self.frame.size.height;
        /*
        customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 5, viewWidth-20, 30)];
        [customSearchBar setDelegate:self];
        [customSearchBar setPlaceholder:@"请输入搜索内容"];
        [customSearchBar setBackgroundColor:[UIColor clearColor]];
        [customSearchBar setBarTintColor:[UIColor clearColor]];
        [customSearchBar setKeyboardType:UIKeyboardTypeDefault];
        [customSearchBar setShowsCancelButton:YES animated:YES];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0) {
            [[[[customSearchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
        }
        [customSearchBar setHidden:YES];
        [self addSubview:customSearchBar];
        */
        BD_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, viewHeight)];
        [BD_tableView setBackgroundColor:[UIColor clearColor]];
        [BD_tableView setDelegate:self];
        [BD_tableView setDataSource:self];
//        [BD_tableView setSeparatorColor:[UIColor clearColor]];
        [self addSubview:BD_tableView];
        cellType = 33;
        
        interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(NetworkResult:)];
        [self creatADView];
        [self updateAD_Data];
        [self createOtherWidget];
        
        //[self addNavigationRightItem];
        
    }
    return self;
}

- (void)updataTableViewData:(NSArray *)InfoArray
{
    self.tableDataArray = [[NSArray alloc] initWithArray:InfoArray];
    [BD_tableView reloadData];
}

//广告
- (void)creatADView
{
    adView = [[ADCustomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 135*ScreenHeight/568)];
    adView.delegate = self;
    [adView setType:left_Circle];
    [BD_tableView setTableHeaderView:adView];
}
//更新广告数据
- (void)updateAD_Data
{
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
#pragma mark ADViewDelegate
- (void)selectADCustomViewItem:(NSString *)ad_Id infoStr:(NSString *)info
{
    NSLog(@"~~~ ADCustomViewItem Selected Item ad_id %@ ~~~",ad_Id);
}

//创建其他控件
- (void)createOtherWidget
{
    //添加上提加载、下拉更多
    self.refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:BD_tableView viewDelegate:self];
}
/*
//添加搜索按钮
- (void)addNavigationRightItem
{
    UIButton *searchBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [searchBt setBackgroundColor:[UIColor clearColor]];
    [searchBt setImage:LoadImage(@"searchBt@2x", @"png") forState:UIControlStateNormal];
    [searchBt addTarget:self action:@selector(searchBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:searchBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];
}
//点击搜索按钮
- (IBAction)searchBtClicked:(id)sender
{
    [UIView beginAnimations:@"moveTableView" context:nil];
    [UIView setAnimationDuration:0.3f];
    if (BD_tableView.frame.origin.y > 0) {
        [BD_tableView setFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
        [customSearchBar resignFirstResponder];
        [customSearchBar setHidden:YES];
    }else {
        [BD_tableView setFrame:CGRectMake(0, 40, viewWidth, viewHeight-104)];
        [customSearchBar setHidden:NO];
        [customSearchBar becomeFirstResponder];
        [customSearchBar setText:@""];
    }
    [UIView commitAnimations];
}
*/
#pragma mark -
#pragma makr UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cellType == 33) {
        return 80.0f;
    }else {
        return 260.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellStr";
    XueZX_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[XueZX_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    if (cellType == 33) {
        [cell setZXRJ_CellDisplay:YES];
        [cell setZSK_CellDisplay:NO];

        [cell setCellImageView:[[self.tableDataArray objectAtIndex:indexPath.row] objectForKey:@"DecKBIcon"]];
        [cell setCellTitleInfo:[[self.tableDataArray objectAtIndex:indexPath.row] objectForKey:@"DecKBTitle"]];
        [cell setCellHotReadType:![[self.tableDataArray objectAtIndex:indexPath.row] objectForKey:@"isHot"]];
        [cell setCellTimeInfo:[[self.tableDataArray objectAtIndex:indexPath.row] objectForKey:@"DecKBDateTime"]];

    }else if (cellType == 35) {
        [cell setZSK_CellDisplay:YES];
        [cell setZXRJ_CellDisplay:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (BD_tableView.frame.origin.y > 0) {
        [BD_tableView setFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
        [customSearchBar resignFirstResponder];
        [customSearchBar setHidden:YES];
    }
    //发送获取文章请求
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:[[self.tableDataArray objectAtIndex:indexPath.row] objectForKey:@"KBArtID"] forKey:@"KBArtID"];
    [interface setInterfaceDidFinish:@selector(NetworkResult:)];
    [interface sendRequest:GetKBDetail Parameters:postData Type:get_request];
    [self showProgressView];
    //发送
}

- (void)transfromXueZX_Info:(int)typeNum
{
    if (typeNum == 33) {
        cellType = 33; //学装修中的知识库
        [BD_tableView reloadData];
        [BD_tableView setTableHeaderView:adView];
    }
    if (typeNum == 35) {
        cellType = 35; //学装修中的装修日记
        [BD_tableView reloadData];
        [BD_tableView setTableHeaderView:nil];
    }
}

- (void)clearTableViewCell {
    for (int i = 0; i < [[BD_tableView subviews] count]; i++) {
        [[[BD_tableView subviews] objectAtIndex:i] removeFromSuperview];
    }
}

/*
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [customSearchBar setShowsCancelButton:YES animated:YES];
    for (id bt in [[customSearchBar.subviews objectAtIndex:0] subviews]) {
        if ([bt isKindOfClass:[UIButton class]]) {
            UIButton *cancel = (UIButton *)bt;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [customSearchBar resignFirstResponder];
    [customSearchBar setShowsCancelButton:NO animated:YES];
    [UIView beginAnimations:@"moveTableView" context:nil];
    [UIView setAnimationDuration:0.3f];
    [BD_tableView setFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
    [UIView commitAnimations];
    [customSearchBar setHidden:YES];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [customSearchBar resignFirstResponder];
    [customSearchBar setShowsCancelButton:NO animated:YES];
    NSLog(@"~~~ Clicked SearchBar Button searchInfo: %@ ~~~",searchBar.text);
    [UIView beginAnimations:@"moveTableView" context:nil];
    [UIView setAnimationDuration:0.3f];
    [BD_tableView setFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
    [UIView commitAnimations];
    [customSearchBar setHidden:YES];
    
    [self searchZXBD_LintInfo:searchBar.text];
}

- (void)searchZXBD_LintInfo:(NSString *)searchKeys
{
    [self showProgressView];;
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:searchKeys forKey:@"Keys"];
    
    [interface setInterfaceDidFinish:@selector(QueryListNetworkResult:)];
    [interface sendRequest:QueryKBList Parameters:postData Type:get_request];
}
*/
- (void)saveReadNumber:(NSString *)KBArtID
{
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:KBArtID forKey:@"KBArtID"];
    
    [interface setInterfaceDidFinish:@selector(ReadNumberNetworkResult:)];
    [interface sendRequest:SaveReadNumber Parameters:postData Type:get_request];
}

#pragma mark -
#pragma mark NetworkInterface Delegate
- (void)sendXueZX_ZSK_NetworkInfoData:(NSString *)urlStr {
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:@"0" forKey:@"NodeID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ProjectID"] forKey:@"ProjectID"];
    [interface setInterfaceDidFinish:@selector(ZSK_NetworkResult:)];
    [interface sendRequest:urlStr Parameters:postData Type:get_request];
}

- (void)ZSK_NetworkResult:(NSDictionary *)result
{
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSLog(@"XueZXView.m Line:291行 ZSK_NetworkResult:/n %@",result);
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:        [FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        [self updataTableViewData:dataArray];
    }else {
        NSLog(@"XueZXView.m Line:296行 ZSK_NetworkResult ErrorMsg :/n %@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
}

- (void)NetworkResult:(NSDictionary *)result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] ==7)
    {
        [self dismissProgressView:nil];
        NSLog(@"~~~ BDXQ_ViewController.m 218行 result:%@ ~~~",result);
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.htmlFlag = YES;
        webVC.webHtmlTitleStr = [[dataArray objectAtIndex:0] objectForKey:@"KBArtTitle"];
        webVC.webHtmlStr = [[dataArray objectAtIndex:0] objectForKey:@"Content"];
        [webVC setTitle:@"装修小常识"];
        //分享需要
        webVC.shareLogoImg = [[dataArray objectAtIndex:0] objectForKey:@"KBArtPic"];
        webVC.shareText = [[dataArray objectAtIndex:0] objectForKey:@"ShareText"];
        webVC.shareUrl = [[dataArray objectAtIndex:0] objectForKey:@"ShareUrl"];
        webVC.shareID = [[dataArray objectAtIndex:0] objectForKey:@"KBArtID"];
////////[self.navigationController pushViewController:webVC animated:YES];
        [self saveReadNumber:[[dataArray objectAtIndex:0] objectForKey:@"KBArtID"]];
    }else {
        NSLog(@"~~~ BDXQ_ViewController.m 227行 ErrorMsg :%@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
}

- (void)QueryListNetworkResult:(NSDictionary *)result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSLog(@"~~~ BDXQ_ViewController.m 251行 result:%@ ~~~",result);
        NSArray *dataArray = [[NSArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        NSLog(@"~~~ dataArray:%@ ~~~",dataArray);
        [self updataTableViewData:dataArray];
    }else {
        NSLog(@"~~~ BDXQ_ViewController.m 227行 ErrorMsg :%@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
}

- (void)ReadNumberNetworkResult:(NSDictionary *)result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        NSLog(@"~~~ BDXQ_ViewController.m 277行 result:%@ ~~~",result);
    }else {
        NSLog(@"~~~ BDXQ_ViewController.m 227行 ErrorMsg :%@ ~~~",[result objectForKey:@"Msg"]);
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
    if (cellType == 35) {
        return YES;
    }else {
        return NO;
    }
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
#pragma mark ViewController Delegate

- (void)viewDidDisappear:(BOOL)animated {
    [interface cancelRequest];
}

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
