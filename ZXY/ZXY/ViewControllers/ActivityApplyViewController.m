//
//  ActivityApplyViewController.m
//  ZXY
//
//  Created by soldier on 15/6/21.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ActivityApplyViewController.h"

@interface ActivityApplyViewController ()

@end

@implementation ActivityApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setActivityApplyCustomView];

}

- (void)setActivityApplyCustomView
{
    //核对活动信息
    UILabel *activityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 30*ScreenHeight/568)];
    [activityTitleLabel setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    [activityTitleLabel setText:@"  核对活动信息"];
    [activityTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [activityTitleLabel setTextColor:[UIColor blackColor]];
    [activityTitleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:activityTitleLabel];
    
    NSArray *activityArray = @[@"活动名称",@"活动时间",@"活动地点"];
    for (int i = 0; i<[activityArray count]; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64+(30+i*35)*ScreenHeight/568, 50*ScreenWidth/320, 35*ScreenHeight/568)];
        [titleLabel setText:[activityArray objectAtIndex:i]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.view addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+(30+i*35)*ScreenHeight/568, ScreenWidth, 1.0f)];
        [lineView setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        [self.view addSubview:lineView];
    }
    
    //活动名称
    UILabel *activityNameLab = [[UILabel alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, 64+30*ScreenHeight/568, 270*ScreenWidth/320, 35*ScreenHeight/568)];
    [activityNameLab setText:@"林凤装饰 回馈新老用户 洁具全场6折起"];
    [activityNameLab setTextAlignment:NSTextAlignmentLeft];
    [activityNameLab setTextColor:[UIColor grayColor]];
    [activityNameLab setFont:[UIFont systemFontOfSize:11.0f]];
    [self.view addSubview:activityNameLab];
    
    //活动时间
    UILabel *activityTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, 64+65*ScreenHeight/568, 270*ScreenWidth/320, 35*ScreenHeight/568)];
    [activityTimeLab setText:@"2015-05-01至2015-05-03"];
    [activityTimeLab setTextAlignment:NSTextAlignmentLeft];
    [activityTimeLab setTextColor:[UIColor grayColor]];
    [activityTimeLab setFont:[UIFont systemFontOfSize:11.0f]];
    [self.view addSubview:activityTimeLab];
    
    //活动地点
    UILabel *activityAddLab = [[UILabel alloc] initWithFrame:CGRectMake(50*ScreenWidth/320,64+ 100*ScreenHeight/568, 270*ScreenWidth/320, 35*ScreenHeight/568)];
    [activityAddLab setText:@"沈阳市铁西区建设大路1-1号第一商城B座2208室"];
    [activityAddLab setTextAlignment:NSTextAlignmentLeft];
    [activityAddLab setTextColor:[UIColor grayColor]];
    [activityAddLab setFont:[UIFont systemFontOfSize:11.0f]];
    [self.view addSubview:activityAddLab];
    
    //填写报名信息
    UILabel *signUpInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64+135*ScreenHeight/568, ScreenWidth, 30*ScreenHeight/568)];
    [signUpInfoLabel setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    [signUpInfoLabel setText:@"  填写报名信息"];
    [signUpInfoLabel setTextAlignment:NSTextAlignmentLeft];
    [signUpInfoLabel setTextColor:[UIColor blackColor]];
    [signUpInfoLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:signUpInfoLabel];


    NSArray *signUpArray = @[@"姓名",@"电话",@"地址"];
    for (int j = 0; j<[activityArray count]; j++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64+(165+j*35)*ScreenHeight/568, 50*ScreenWidth/320, 35*ScreenHeight/568)];
        [titleLabel setText:[signUpArray objectAtIndex:j]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.view addSubview:titleLabel];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0,64+(165+j*35)*ScreenHeight/568, ScreenWidth, 1.0f)];
        [lineView1 setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        [self.view addSubview:lineView1];
    }
    
    //姓名
    nameTextF = [[UITextField alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, 64+165*ScreenHeight/568, 270*ScreenWidth/320, 35*ScreenHeight/568)];
    [nameTextF setDelegate:self];
    [nameTextF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [nameTextF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [nameTextF setReturnKeyType:UIReturnKeyDone];
    [nameTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [nameTextF setTextColor:[UIColor blackColor]];
    [nameTextF setTextAlignment:NSTextAlignmentLeft];
    [nameTextF setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:nameTextF];

     //电话
    phoneTextF = [[UITextField alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, 64+200*ScreenHeight/568, 270*ScreenWidth/320, 35*ScreenHeight/568)];
    [phoneTextF setDelegate:self];
    [phoneTextF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [phoneTextF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [phoneTextF setReturnKeyType:UIReturnKeyDone];
    [phoneTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextF setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneTextF setTextColor:[UIColor blackColor]];
    [phoneTextF setTextAlignment:NSTextAlignmentLeft];
    [phoneTextF setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:phoneTextF];

    //地址
    addressTextF = [[UITextField alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, 64+235*ScreenHeight/568, 270*ScreenWidth/320, 35*ScreenHeight/568)];
    [addressTextF setDelegate:self];
    [addressTextF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [addressTextF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [addressTextF setReturnKeyType:UIReturnKeyDone];
    [addressTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [addressTextF setTextColor:[UIColor blackColor]];
    [addressTextF setTextAlignment:NSTextAlignmentLeft];
    [addressTextF setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:addressTextF];

    
    //分隔View
    UIView *separatedView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+270*ScreenHeight/568, ScreenWidth, 10*ScreenHeight/568)];
    [separatedView setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    [self.view addSubview:separatedView];
    
    //提示Label
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, 64+300*ScreenHeight/568, 280*ScreenWidth/320, 30*ScreenHeight/568)];
    [promptLabel setText:@"温馨提示：亲爱的用户您好，请您填好个人信息，提交申请，我们会已最快的速度与您取得联系，请您耐心等待。"];
    [promptLabel setTextColor:[UIColor grayColor]];
    [promptLabel setTextAlignment:NSTextAlignmentLeft];
    [promptLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [promptLabel setNumberOfLines:0];
    [promptLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [self.view addSubview:promptLabel];
    
    //提交申请 按钮
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*ScreenWidth/320, 64+350*ScreenHeight/568, 280*ScreenWidth/320, 30*ScreenHeight/568)];
    [submitBtn setBackgroundColor:RGBACOLOR(61, 191, 134, 1)];
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [submitBtn.layer setMasksToBounds:YES];
    [submitBtn.layer setCornerRadius:2.0f];
    submitBtn.titleLabel.textColor = [UIColor whiteColor];
    [submitBtn addTarget:self action:@selector(submitApplyFor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
}

//"提交申请" 按钮 响应事件
- (void)submitApplyFor:(id)sender
{
    NSLog(@"提交申请 ………………");
}

#pragma mark == 
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [nameTextF resignFirstResponder];
    [phoneTextF resignFirstResponder];
    [addressTextF resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextF resignFirstResponder];
    [phoneTextF resignFirstResponder];
    [addressTextF resignFirstResponder];
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
