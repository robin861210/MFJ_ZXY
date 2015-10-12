//
//  DiaryViewController.m
//  ZXY
//
//  Created by soldier on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "DiaryViewController.h"
#import "AddNewDiaryViewController.h"

@interface DiaryViewController ()

@end

@implementation DiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;     //ylb iOS7之后UIScrollView向下便宜64像素
    
    [self addDiaryBarButton];
    [self setDiaryCustomView];
    
    diaryListArray = [[NSMutableArray alloc] init];
    
    //初始化AFNetwork
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(diaryDetailNetworkResult:)];
    
    [self sendDiaryDetailRequest];
    
}

- (void)setDiaryCustomView
{
    diaryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [diaryTableView setBackgroundColor:[UIColor clearColor]];
    [diaryTableView setShowsHorizontalScrollIndicator:NO];
    [diaryTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    diaryTableView.delegate = self;
    diaryTableView.dataSource = self;
    [self.view addSubview:diaryTableView];
}

//设置右导航“新建”按钮addNavigationRightItem
- (void)addDiaryBarButton
{
    UIButton *addDiaryBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [addDiaryBt setBackgroundColor:[UIColor clearColor]];
    //    [searchBt setImage:LoadImage(@"searchBt@2x", @"png") forState:UIControlStateNormal];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:LoadImage(@"", @"png")];
    [imgV setFrame:CGRectMake(0, 10, 10, 10)];
    [addDiaryBt addSubview:imgV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [label setText:@"新建"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:11.0f]];
    [addDiaryBt addSubview:label];
    
    [addDiaryBt addTarget:self action:@selector(addDiaryBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtItem = [[UIBarButtonItem alloc] initWithCustomView:addDiaryBt];
    [self.navigationItem setRightBarButtonItem:barBtItem];
    
}

#pragma mark -
#pragma mark Network Delegate

- (void)sendDiaryDetailRequest{
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:[[[ProjectInfoUtils sharedProjectInfoUtils] infoDic] objectForKey:@"ProjectID"] forKey:@"ProjectID"];
    
    [interface setInterfaceDidFinish:@selector(diaryDetailNetworkResult:)];
    [interface sendRequest:GetDecDiary Parameters:postData Type:get_request];
}

- (void)diaryDetailNetworkResult:(NSDictionary *) result {
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        NSLog(@"~~~ dataArray:%@ ~~~",dataArray);
        diaryListArray = dataArray;
        
        [diaryTableView reloadData];
    }else {
        NSLog(@"~~~ Error Msg :%@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [diaryListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 205.0f*ScreenHeight/568;
    DiaryTableViewCell *cell = (DiaryTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"cell height %f",cell.frame.size.height);
    
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"RenderingCell";
    diaryTableCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (diaryTableCell == nil) {
        diaryTableCell = [[DiaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    [diaryTableCell updateDiaryCellInfoData:[diaryListArray objectAtIndex:indexPath.row]];
    
    [diaryTableCell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return diaryTableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中的日记 id = %@",[[diaryListArray objectAtIndex:indexPath.row] objectForKey:@"DecDiaryID"]);
    DiaryDetailViewController *diaryDetailVC = [[DiaryDetailViewController alloc] init];
    diaryDetailVC.diaryDic = [diaryListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:diaryDetailVC animated:YES];
}

//新建日记按钮
- (void)addDiaryBtClicked:(id)sender
{
    NSLog(@"新建装修日记");
    AddNewDiaryViewController *addNewDiaryVC = [[AddNewDiaryViewController alloc] init];
    [addNewDiaryVC setTitle:@"新建日记"];
    [self.navigationController pushViewController:addNewDiaryVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
