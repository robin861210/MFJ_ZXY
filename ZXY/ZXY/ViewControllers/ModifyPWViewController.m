//
//  ModifyPWViewController.m
//  ZXY
//
//  Created by soldier on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ModifyPWViewController.h"

@interface ModifyPWViewController ()

@end

@implementation ModifyPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];

    [self setModifyPwCustomView];

}

- (void)setModifyPwCustomView
{
    //当前密码
    UIView *oldPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 + 64, ScreenWidth, 35*ScreenHeight/568)];
    [oldPasswordView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:oldPasswordView];
    
    UILabel *oldPwLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35*ScreenHeight/568)];
    [oldPwLab setBackgroundColor:[UIColor whiteColor]];
    [oldPwLab setText:@"    当前密码"];
    [oldPwLab setTextAlignment:NSTextAlignmentLeft];
    [oldPwLab setFont:[UIFont systemFontOfSize:13.0f]];
    [oldPasswordView addSubview:oldPwLab];
    
    oldPwTextF = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, ScreenWidth-120,oldPwLab.frame.size.height)];
    [oldPwTextF setDelegate:self];
    [oldPwTextF setSecureTextEntry:YES];
    [oldPwTextF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [oldPwTextF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [oldPwTextF setReturnKeyType:UIReturnKeyDone];
    [oldPwTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [oldPwTextF setKeyboardType:UIKeyboardTypeDefault];
//    [oldPwTextF setPlaceholder:@"重新输入新密码"];
    [oldPwTextF setTextColor:[UIColor blackColor]];
    [oldPwTextF setTextAlignment:NSTextAlignmentLeft];
    [oldPasswordView addSubview:oldPwTextF];
    
    //新密码
    UIView *newPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 85 +oldPasswordView.frame.size.height , ScreenWidth, 35*ScreenHeight/568)];
    [newPasswordView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:newPasswordView];
    
    UILabel *newPwLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35*ScreenHeight/568)];
    [newPwLab setBackgroundColor:[UIColor whiteColor]];
    [newPwLab setText:@"    新密码"];
    [newPwLab setTextAlignment:NSTextAlignmentLeft];
    [newPwLab setFont:[UIFont systemFontOfSize:13.0f]];
    [newPasswordView addSubview:newPwLab];
    
    newPwTextF = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, ScreenWidth-120,oldPwLab.frame.size.height)];
    [newPwTextF setDelegate:self];
    [newPwTextF setSecureTextEntry:YES];
    [newPwTextF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [newPwTextF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [newPwTextF setReturnKeyType:UIReturnKeyDone];
    [newPwTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [newPwTextF setKeyboardType:UIKeyboardTypeDefault];
//    [newPwTextF setPlaceholder:@"重新输入新密码"];
    [newPwTextF setTextColor:[UIColor blackColor]];
    [newPwTextF setTextAlignment:NSTextAlignmentLeft];
    [newPasswordView addSubview:newPwTextF];
    
    //确认密码
    UIView *affirmPwView = [[UIView alloc] initWithFrame:CGRectMake(0, newPasswordView.frame.origin.y +newPasswordView.frame.size.height+2 , ScreenWidth, 35*ScreenHeight/568)];
    [affirmPwView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:affirmPwView];
    
    UILabel *affirmPwLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35*ScreenHeight/568)];
    [affirmPwLab setBackgroundColor:[UIColor whiteColor]];
    [affirmPwLab setText:@"    当前密码"];
    [affirmPwLab setTextAlignment:NSTextAlignmentLeft];
    [affirmPwLab setFont:[UIFont systemFontOfSize:13.0f]];
    [affirmPwView addSubview:affirmPwLab];
    
    affirmPwTextF = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, ScreenWidth-120,oldPwLab.frame.size.height)];
    [affirmPwTextF setDelegate:self];
    [affirmPwTextF setSecureTextEntry:YES];
    [affirmPwTextF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [affirmPwTextF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [affirmPwTextF setReturnKeyType:UIReturnKeyDone];
    [affirmPwTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [affirmPwTextF setKeyboardType:UIKeyboardTypeDefault];
//    [affirmPwTextF setPlaceholder:@"重新输入新密码"];
    [affirmPwTextF setTextColor:[UIColor blackColor]];
    [affirmPwTextF setTextAlignment:NSTextAlignmentLeft];
    [affirmPwView addSubview:affirmPwTextF];
    
    //确认修改按钮
    UIButton *affirmChangeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200*ScreenHeight/568, ScreenWidth, 35*ScreenHeight/568)];
    [affirmChangeBtn setBackgroundColor:[UIColor whiteColor]];
    [affirmChangeBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [affirmChangeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    affirmChangeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [affirmChangeBtn addTarget:self action:@selector(affirmChangePassWord:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:affirmChangeBtn];
}


//“确认修改”
- (void)affirmChangePassWord:(id)sender
{
    NSLog(@"确认修改密码……………………");
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [oldPwTextF resignFirstResponder];
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
