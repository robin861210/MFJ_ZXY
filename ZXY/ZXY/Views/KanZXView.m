//
//  KanZXView.m
//  ZXY
//
//  Created by acewill on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "KanZXView.h"

@implementation KanZXView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        kanZX_TableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        [kanZX_TableV setBackgroundColor:[UIColor clearColor]];
        [kanZX_TableV setDelegate:self];
        [kanZX_TableV setDataSource:self];
        [kanZX_TableV setSeparatorColor:[UIColor clearColor]];
        [self addSubview:kanZX_TableV];
        
        dataInfoType = 33;
        Kan_tableViewArray = [[NSMutableArray alloc] init];
        
        progressView = [[MRProgressOverlayView alloc] init];
        progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
        [self addSubview:progressView];
        //初始化AFNetwork
        interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(KanZX_JX_NetworkResult:)];
        
        //添加上提加载、下拉更多
        self.refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:kanZX_TableV viewDelegate:self];
    }
    return self;
}


#pragma mark -
#pragma mark UITableView Delegate
- (void)updateTableViewInfo:(NSMutableArray *)tableViewArray {
    [Kan_tableViewArray setArray:tableViewArray];
    [kanZX_TableV reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Kan_tableViewArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"kan_ZX";
    KanZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[KanZXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if (dataInfoType == 33) {
        [cell setKanZX_360AllSDisplay:YES];
        [cell setKanZX_JingXuanDisplayHidden:NO];
        [cell setKanZX_JingXuanCell:[Kan_tableViewArray objectAtIndex:indexPath.row]];
    }else {
        [cell setKanZX_JingXuanDisplayHidden:YES];
        [cell setKanZX_360AllSDisplay:NO];
        [cell setKanZX_360Alls:[Kan_tableViewArray objectAtIndex:indexPath.row]];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataInfoType == 33) {
        NSLog(@"选择了dataInfoType 33，第几个单元格");
    }
    if (dataInfoType == 35) {
        NSLog(@"选择了dataInfoType 35，第几个单元格");
    }
    
}

- (void)transfromKanZX_Info:(int)typeNum
{
    if (typeNum == 33) {
        dataInfoType = 33; //看装修中的精选
        [self sendKanZX_NetworkInfoData:GetListOfImpressionDrawing];
    }
    if (typeNum == 35) {
        dataInfoType = 35; //看装修中的360
        [self sendKanZX_NetworkInfoData:GetListOfPano];
    }
}

#pragma mark -
#pragma mark NetworkInterface Delegate
- (void)sendKanZX_NetworkInfoData:(NSString *)urlStr {
    if (!PullDown)
        [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:@"0" forKey:@"NodeID"];
//    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ProjectID"] forKey:@"ProjectID"];
    
    [interface setInterfaceDidFinish:@selector(KanZX_NetworkResult:)];
    [interface sendRequest:urlStr Parameters:postData Type:get_request];
}

- (void)KanZX_NetworkResult:(NSDictionary *)result
{
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        if (!PullDown)
            [self dismissProgressView:nil];
        NSLog(@"KanZXView.m Line:114行 KanZX_JX_NetworkResult:/n %@",result);
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:        [FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        [self updateTableViewInfo:dataArray];
        
    }else {
        NSLog(@"KanZXView.m Line:118行 KanZX_JX_NetworkResult ErrorMsg :/n %@ ~~~",[result objectForKey:@"Msg"]);
        if (!PullDown)
            [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
    if (PullUp) {
        PullUp = NO;
        [self endLoadMore];
    }
    if (PullDown) {
        PullDown = NO;
        [self endRefreshing];
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
    PullDown = YES;
    if (dataInfoType == 33) {
        //看装修中的精选
        [self sendKanZX_NetworkInfoData:GetListOfImpressionDrawing];
    }else if (dataInfoType == 35) {
        //看装修中的360
        [self sendKanZX_NetworkInfoData:GetListOfPano];
    }

}
- (void)beginPullUpLoading {
    PullUp = YES;
    if (dataInfoType == 33) {
        //看装修中的精选
        [self sendKanZX_NetworkInfoData:GetListOfImpressionDrawing];
    }else if (dataInfoType == 35) {
        //看装修中的360
        [self sendKanZX_NetworkInfoData:GetListOfPano];
    }
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
