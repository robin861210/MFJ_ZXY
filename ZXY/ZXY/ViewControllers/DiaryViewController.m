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
    
    //初始化AFNetwork
    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(diaryDetailNetworkResult:)];
    
}

- (void)setDiaryCustomView
{
    diaryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [diaryTableView setBackgroundColor:[UIColor clearColor]];
    [diaryTableView setShowsHorizontalScrollIndicator:NO];
    [diaryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205.0f*ScreenHeight/568;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"RenderingCell";
    diaryTableCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (diaryTableCell == nil) {
        diaryTableCell = [[DiaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
//        diaryTableCell.delegate = self;
    }
    
    
    [diaryTableCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return diaryTableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
