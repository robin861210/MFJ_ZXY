//
//  DiaryDetailViewController.m
//  ZXY
//
//  Created by soldier on 15/9/29.
//  Copyright © 2015年 MFJ_zxy. All rights reserved.
//

#import "DiaryDetailViewController.h"

@interface DiaryDetailViewController ()

@end

@implementation DiaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"装修日记列表";
    
    diaryArray = [NSMutableArray array];
    
    [self setDiaryDetailCustomView];
    
    //初始化AFNetwork     GetPrivate
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(diaryPrivateNetworkResult:)];
    
    [self sendDiaryPrivateRequest];

}

- (void)setDiaryDetailCustomView
{
    [self setTopView];
    [self setDairyDetailTableView];
    [self setMenuCustomView];
}

//顶部视图
- (void)setTopView
{
    //
    tableHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 175*ScreenHeight/568)];
//    [tableHeaderView setImage:LoadImage(@"", @"png")];
    [tableHeaderView sd_setImageWithURL:[NSURL URLWithString:@"http://218.25.17.238:8080/zxyPC/upload/mroom/220/zhgj08.jpg"]];
    [tableHeaderView setUserInteractionEnabled:YES];
    [self.view addSubview:tableHeaderView];

//    //收藏按钮
//    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [collectionBtn setFrame:CGRectMake(0, 0, 15, 15)];
//    [collectionBtn setImage:LoadImage(@"", @"png") forState:UIControlStateNormal];
//    [collectionBtn addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [tableHeaderView addSubview:collectionBtn];
//    
//    //分享按钮
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shareBtn setFrame:CGRectMake(0, 0, 15, 15)];
//    [shareBtn setImage:LoadImage(@"", @"png") forState:UIControlStateNormal];
//    [shareBtn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [tableHeaderView addSubview:shareBtn];
//    
//    //评论按钮
//    UIButton *commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [commentsBtn setFrame:CGRectMake(0, 0, 15, 15)];
//    [commentsBtn setImage:LoadImage(@"", @"png") forState:UIControlStateNormal];
//    [commentsBtn addTarget:self action:@selector(clickCommentsBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [tableHeaderView addSubview:commentsBtn];
    
    
    //头像
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 130*ScreenHeight/568, 30, 30)];
    headImgView.layer.masksToBounds = YES;
    headImgView.layer.cornerRadius = 15.0f;
    [headImgView sd_setImageWithURL:[self.diaryDic objectForKey:@""] placeholderImage:LoadImage(@"head", @"jpg")];
    [tableHeaderView addSubview:headImgView];
    
    //功能按钮 菜单
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setFrame:CGRectMake(ScreenWidth - 30, 10, 20, 20)];
    [menuBtn setBackgroundImage:LoadImage(@"zxy_diary_menu@2x",@"png") forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:menuBtn];
    
    //工地名称
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 130*ScreenHeight/568, 100*ScreenWidth/320, 16)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    CGSize maxSize = CGSizeMake(ScreenWidth, 20);
    UIFont *contentFont = [UIFont systemFontOfSize:13.0f];
    NSString *zxTitleStr = [self.diaryDic objectForKey:@"DecLabel"];
    CGSize contentSize = [zxTitleStr sizeWithFont:contentFont constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    [titleLabel setFont:contentFont];
    [titleLabel setFrame:CGRectMake(50, 130*ScreenHeight/568, contentSize.width, 16)];
    [titleLabel setText:zxTitleStr];
    [tableHeaderView addSubview:titleLabel];
    
    //日记篇数
    UILabel *diaryNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 130*ScreenHeight/568, 50*ScreenWidth/320, 16)];
    [diaryNumLabel setText:[self.diaryDic objectForKey:@""]];
    [diaryNumLabel setText:@"(12篇)"];
    [diaryNumLabel setTextColor:[UIColor whiteColor]];
    [diaryNumLabel setTextAlignment:NSTextAlignmentLeft];
    [diaryNumLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [tableHeaderView addSubview:diaryNumLabel];
    
    //工地信息
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x , 130*ScreenHeight/568+16, 200*ScreenWidth/320, 14)];
    [detailLabel setText:[NSString stringWithFormat:@"%@ | %@㎡ | %@ | %@",[self.diaryDic objectForKey:@"DecCommunity"],[self.diaryDic objectForKey:@"DecArea"],[self.diaryDic objectForKey:@"DecPrice"],[self.diaryDic objectForKey:@"DecLabel"]]];
    [detailLabel setTextColor:[UIColor whiteColor]];
    [detailLabel setTextAlignment:NSTextAlignmentLeft];
    [detailLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [tableHeaderView addSubview:detailLabel];
}

//tableView
- (void)setDairyDetailTableView
{
    diaryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [diaryTableView setDelegate:self];
    [diaryTableView setDataSource:self];
    [diaryTableView setTableHeaderView:tableHeaderView];
//    diaryTableView.tableFooterView = [UIView new];
    [self.view addSubview:diaryTableView];
}

- (void)setMenuCustomView
{
    bgMenuView = [[UIView alloc] initWithFrame:CGRectMake(230*ScreenWidth/320, ScreenHeight-300*ScreenHeight/568, 90*ScreenWidth/320, 300*ScreenHeight/568)];
    [bgMenuView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.7]];
    [bgMenuView setHidden:YES];
    [self.view addSubview:bgMenuView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10*ScreenWidth/320, 15*ScreenHeight/568, 1, 240*ScreenHeight/568)];
    [lineView setBackgroundColor:[UIColor whiteColor]];
    [bgMenuView addSubview:lineView];
    
    NSArray *titleArray = @[@"准备",@"拆改",@"水电",@"瓦工",@"木工",@"油工",@"成品安装",@"工程竣工",@"入住"];
    for (int i = 0; i<9; i++) {
    
        UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(10*ScreenWidth/320-2.5, i*30*ScreenHeight/568+15*ScreenHeight/568-2.5, 5, 5)];
        roundView.layer.cornerRadius = 2.5f;
        roundView.backgroundColor = [UIColor whiteColor];
        [bgMenuView addSubview:roundView];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, i*30*ScreenHeight/568, 70*ScreenWidth/568, 30*ScreenHeight/568)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTag:i];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [btn addTarget:self action:@selector(zxStageClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgMenuView addSubview:btn];
    }
}

- (void)menuBtnClick
{
    NSLog(@"菜单按钮  点击 ");
    [bgMenuView setHidden:isBgViewHidden];
    isBgViewHidden = !isBgViewHidden;
}

#pragma mark  -- 侧边菜单选择按钮
//装修状态 选择
- (void)zxStageClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSLog(@"adas%lu  \ndad:%lu",button.tag,[diaryArray count]);
    for (int i = 0; i<[diaryArray count]; i++) {
        if ([diaryArray[i][@"Stage"] integerValue] == button.tag+1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [diaryTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

#pragma mark - Network
- (void)sendDiaryPrivateRequest
{
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:[self.diaryDic objectForKey:@"DecDiaryID"] forKey:@"DecDiaryID"];
    [postData setValue:[self.diaryDic objectForKey:@"diaryClientID"] forKey:@"diaryClientID"];
    
    [interface setInterfaceDidFinish:@selector(diaryPrivateNetworkResult:)];
    [interface sendRequest:GetPrivate Parameters:postData Type:get_request];
}

- (void)diaryPrivateNetworkResult:(NSDictionary *) result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        NSLog(@"~~~ dataArray:%@ ~~~",dataArray);
        diaryArray = dataArray;
        
        [diaryTableView reloadData];
    }else {
        NSLog(@"~~~ Error Msg :%@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [diaryArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DiaryDetailTableViewCell *cell = (DiaryDetailTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DiaryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DiaryDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell updateDiaryDetailCellInfoData:[diaryArray objectAtIndex:indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaryCommentsViewController *diaryCommentsVC = [[DiaryCommentsViewController alloc] init];
    NSLog(@"%@",diaryArray[indexPath.row]);
    diaryCommentsVC.diaryDetailDic = diaryArray[indexPath.row];
    [self.navigationController pushViewController:diaryCommentsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ViewController Delegate

- (void)viewDidDisappear:(BOOL)animated {
    [interface cancelRequest];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
