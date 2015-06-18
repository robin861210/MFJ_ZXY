//
//  CalculatorViewController.m
//  ZXY
//
//  Created by soldier on 15/6/17.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
    
    chooseLabelVC = [[ChooseLabelViewController alloc] init];
    chooseLabelVC.delegate = self;
    
    [self setCalculatorCustomView];

}

- (void)setCalculatorCustomView
{
    //面积
    [self.view addSubview:[self createCalculatorBtn:CGRectMake(0, 74,ScreenWidth, 33*ScreenHeight/568) WithTitleLabText:@"面积" WithBtnTag:0 WithIsArrow:NO]];
    
    areaTextF = [[UITextField alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 74, 200*ScreenWidth/320, 33*ScreenHeight/568)];
    [areaTextF setDelegate:self];
    [areaTextF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [areaTextF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [areaTextF setReturnKeyType:UIReturnKeyDone];
    [areaTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [areaTextF setKeyboardType:UIKeyboardTypeNumberPad];
//    [areaTextF setPlaceholder:@"请输入邀请码"];
    [areaTextF setTextColor:[UIColor blackColor]];
    [areaTextF setTextAlignment:NSTextAlignmentRight];
    [areaTextF setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:areaTextF];
    
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(265*ScreenWidth/320, 74, 35*ScreenWidth/320, 33*ScreenHeight/568)];
    [unitLabel setText:@"㎡"];
    [unitLabel setTextAlignment:NSTextAlignmentRight];
    [unitLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:unitLabel];


    //户型model
    [self.view addSubview:[self createCalculatorBtn:CGRectMake(0, 74+33*ScreenHeight/568, ScreenWidth, 33*ScreenHeight/568) WithTitleLabText:@"户型" WithBtnTag:1 WithIsArrow:YES]];
    
    modelLabel = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 74+33*ScreenHeight/568, 100*ScreenWidth/320, 33*ScreenHeight/568)];
    [modelLabel setText:@"小户型"];
    [modelLabel setTextAlignment:NSTextAlignmentLeft];
    [modelLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [modelLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:modelLabel];
    
    
    //房厅卫Room hall who
    [self.view addSubview:[self createCalculatorBtn:CGRectMake(0,74+ 66*ScreenHeight/568, ScreenWidth, 33*ScreenHeight/568) WithTitleLabText:@"房厅卫" WithBtnTag:2 WithIsArrow:YES]];

    roomHallWhoLabel = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 74+ 66*ScreenHeight/568, 100*ScreenWidth/320, 33*ScreenHeight/568)];
    [roomHallWhoLabel setText:@"1房1厅1卫"];
    [roomHallWhoLabel setTextAlignment:NSTextAlignmentLeft];
    [roomHallWhoLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [roomHallWhoLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:roomHallWhoLabel];
    
    //装修档次
    [self.view addSubview:[self createCalculatorBtn:CGRectMake(0,84+ 99*ScreenHeight/568, ScreenWidth, 33*ScreenHeight/568) WithTitleLabText:@"装修档次" WithBtnTag:3 WithIsArrow:YES]];
    
    gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 84+ 99*ScreenHeight/568, 100*ScreenWidth/320, 33*ScreenHeight/568)];
    [gradeLabel setText:@"经济实惠"];
    [gradeLabel setTextAlignment:NSTextAlignmentLeft];
    [gradeLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [gradeLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:gradeLabel];
    
    //装修风格
    [self.view addSubview:[self createCalculatorBtn:CGRectMake(0,84+ 132*ScreenHeight/568, ScreenWidth, 33*ScreenHeight/568) WithTitleLabText:@"装修风格" WithBtnTag:4 WithIsArrow:YES]];
    
    styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320,84+ 132*ScreenHeight/568, 100*ScreenWidth/320, 33*ScreenHeight/568)];
    [styleLabel setText:@"简约"];
    [styleLabel setTextAlignment:NSTextAlignmentLeft];
    [styleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [styleLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:styleLabel];
    
    //所在城市
    [self.view addSubview:[self createCalculatorBtn:CGRectMake(0,94+ 165*ScreenHeight/568, ScreenWidth, 33*ScreenHeight/568) WithTitleLabText:@"所在城市" WithBtnTag:5 WithIsArrow:YES]];
    
    cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 94+ 165*ScreenHeight/568, 100*ScreenWidth/320, 33*ScreenHeight/568)];
    [cityLabel setText:@"北京"];
    [cityLabel setTextAlignment:NSTextAlignmentLeft];
    [cityLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [cityLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:cityLabel];
    
}

- (UIButton *)createCalculatorBtn:(CGRect)frame WithTitleLabText:(NSString *)titleText WithBtnTag:(NSInteger)index WithIsArrow:(BOOL)isArrow
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.borderColor = [RGBACOLOR(234, 235, 237, 1) CGColor];
    button.layer.borderWidth = 0.5f;
    [button addTarget:self action:@selector(chooseCalculatorOptions:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:index];
    
    //标题
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, 0, 60*ScreenWidth/320, frame.size.height)];
    [titleLab setText:titleText];
    [titleLab setTextAlignment:NSTextAlignmentLeft];
    [titleLab setFont:[UIFont systemFontOfSize:13.0f]];
    [button addSubview:titleLab];
    
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 30, (frame.size.height-17)/2, 17, 17)];
    [arrowImgV setImage:LoadImage(@"arrow@2x", @"png")];
    [arrowImgV setHidden:!isArrow];
    [button addSubview:arrowImgV];
    
    return button;
}

//选择计算机中各选项按钮
- (void)chooseCalculatorOptions:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:
            NSLog(@"选择面积，UITextField");
            break;
        case 1:
            NSLog(@"选择户型…………");
            [chooseLabelVC setTitle:@"选择户型"];
            break;
        case 2:
            NSLog(@"选择房厅卫…………");
            [chooseLabelVC setTitle:@"选择房厅卫"];
            break;
        case 3:
            NSLog(@"选择装修档次…………");
            [chooseLabelVC setTitle:@"选择装修档次"];
            break;
        case 4:
            NSLog(@"选择装修风格…………");
            [chooseLabelVC setTitle:@"选择装修风格"];
            break;
        case 5:
            NSLog(@"选择所在城市…………");
            [chooseLabelVC setTitle:@"选择所在城市"];

            break;
            
        default:
            break;
    }
//    chooseLabelVC.chooseType = btn.tag;
    [chooseLabelVC setChooseLabelCustomView:btn.tag];
    [self.navigationController pushViewController:chooseLabelVC animated:YES];
}

#pragma mark -
#pragma ChooseLabelVCDelegate
- (void)setLabelText:(NSString *)labelT AndType:(NSInteger)chooseType
{
    
    switch (chooseType) {
        case 1:
            NSLog(@"修改户型Label……");
            [modelLabel setText:labelT];
            break;
        case 2:
            NSLog(@"修改房厅卫Label……");
            [roomHallWhoLabel setText:labelT];
            break;
        case 3:
            NSLog(@"修改装修档次Label……");
            [gradeLabel setText:labelT];
            break;
        case 4:
            NSLog(@"修改装修风格Label……");
            [styleLabel setText:labelT];
            break;
        case 5:
            NSLog(@"修改所在城市Label……");
            [cityLabel setText:labelT];
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [areaTextF resignFirstResponder];
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
