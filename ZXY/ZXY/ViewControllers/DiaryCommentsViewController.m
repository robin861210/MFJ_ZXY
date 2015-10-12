//
//  DiaryCommentsViewController.m
//  ZXY
//
//  Created by soldier on 15/9/29.
//  Copyright © 2015年 MFJ_zxy. All rights reserved.
//

#import "DiaryCommentsViewController.h"

@interface DiaryCommentsViewController ()

@end

@implementation DiaryCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    diaryCommentsArray = [NSMutableArray array];
    [self setDiaryCommentsCustomView];

    interface = [[NetworkInterface alloc] initWithTarget:self didFinish:@selector(getDecDiaryCommandsNetworkResult:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self sendDecDiaryCommentsRequest];

}

- (void)setDiaryCommentsCustomView
{
    tableHeadView = [[UIView alloc] init];
    
    //图片
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10*ScreenWidth/320, 10*ScreenHeight/568, 300*ScreenWidth/320, 230*ScreenHeight/568)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://218.25.17.238:8080/zxyPC/upload/mroom/220/zhgj08.jpg"]];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:LoadImage(@"", @"png")];
    [tableHeadView addSubview:imgView];
    
    //日记详情
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    [contentLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [contentLabel setText:[self.diaryDetailDic objectForKey:@"DecDiary"]];
    CGSize boundSize = CGSizeMake(300*ScreenWidth/320, CGFLOAT_MAX);
    CGSize requiredSize = [contentLabel.text boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} context:nil].size;
    NSLog(@"%f",requiredSize.height);
    [contentLabel setFrame:CGRectMake(10*ScreenWidth/320, imgView.frame.origin.y + imgView.frame.size.height + 10, 300*ScreenWidth/320, requiredSize.height)];
    [tableHeadView addSubview:contentLabel];
    
    //评论
    UILabel *commentTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, contentLabel.frame.origin.y + contentLabel.frame.size.height +5, 300*ScreenWidth/320, 15*ScreenHeight/568)];
    [commentTitleLabel setText:@"评论"];
    [commentTitleLabel setTextColor:UIColorFromHex(0xcececf)];
    [commentTitleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [tableHeadView addSubview:commentTitleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, commentTitleLabel.frame.origin.y + commentTitleLabel.frame.size.height +5, self.view.frame.size.width, .5)];
    [lineView setBackgroundColor:UIColorFromHex(0xdedede)];
    [tableHeadView addSubview:lineView];
    
    [tableHeadView setFrame:CGRectMake(0, 0, ScreenWidth, lineView.frame.origin.y + lineView.frame.size.height)];
    
    diaryCommentTableV = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [diaryCommentTableV setDelegate:self];
    [diaryCommentTableV setDataSource:self];
    [diaryCommentTableV setTableHeaderView:tableHeadView];
    [diaryCommentTableV setTableFooterView:[UIView new]];
    [self.view addSubview:diaryCommentTableV];
    
    [self setCommentsOnTheInputBox];
}

//评论输入框
- (void)setCommentsOnTheInputBox
{
    commentsInputView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    [commentsInputView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:commentsInputView];
    
    UITextField *commentTextF = [[UITextField alloc] initWithFrame:CGRectMake(10*ScreenWidth/320, 5, 300*ScreenWidth/320, 30)];
    [commentTextF setDelegate:self];
    [commentTextF setPlaceholder:@" 我也说两句"];
    commentTextF.layer.borderColor = [UIColor blackColor].CGColor;
    commentTextF.layer.borderWidth = 0.5f;
    commentTextF.layer.masksToBounds = YES;
    commentTextF.layer.cornerRadius = 3.0f;
    [commentsInputView addSubview:commentTextF];
}

- (void)sendDecDiaryCommentsRequest
{
    [self showProgressView];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"UserID"] forKey:@"UserID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"ClientID"] forKey:@"ClientID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"MachineID"] forKey:@"MachineID"];
    [postData setValue:[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"sessionid"] forKey:@"sessionid"];
    [postData setValue:[self.diaryDetailDic objectForKey:@"PrivateDiaryID"] forKey:@"PrivateDiaryID"];
//    [postData setValue:[self.diaryDic objectForKey:@"diaryClientID"] forKey:@"diaryClientID"];
    
    [interface setInterfaceDidFinish:@selector(getDecDiaryCommandsNetworkResult:)];
    [interface sendRequest:getDecDiaryCommands Parameters:postData Type:get_request];
}

- (void)getDecDiaryCommandsNetworkResult:(NSDictionary *) result
{
    if ([[result objectForKey:@"Code"] intValue] == 0 &&
        [[result objectForKey:@"Msg"] length] == 7)
    {
        [self dismissProgressView:nil];
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[FilterData filterNerworkData:[result objectForKey:@"Response"]]];
        NSLog(@"~~~ dataArray:%@ ~~~",dataArray);
        
        diaryCommentsArray = dataArray;
        [diaryCommentTableV reloadData];
    }else {
        NSLog(@"~~~ Error Msg :%@ ~~~",[result objectForKey:@"Msg"]);
        [self dismissProgressView:[result objectForKey:@"Msg"]];
    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [diaryCommentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DiaryCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DiaryCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell updateDiaryCommentCellInfo:diaryCommentsArray[indexPath.row]];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaryCommentCell *cell = (DiaryCommentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [commentsInputView setFrame:CGRectMake(0, self.view.frame.size.height - 216 -80 , self.view.frame.size.width, 40)];
    }];
    return YES;
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
