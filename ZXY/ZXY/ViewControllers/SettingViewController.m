//
//  SettingViewController.m
//  ZXY
//
//  Created by soldier on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    roomListArr = @[@"http://img.qqbody.com/uploads/allimg/201503/2015031310511.jpg",@"http://img.qqbody.com/uploads/allimg/201503/2015031310511.jpg",@"http://img.qqbody.com/uploads/allimg/201503/2015031310511.jpg"];
    
    [self setCustomView];
}

- (void)setCustomView
{
    for (int i = 0 ; i<[roomListArr count]; i++) {
        UIButton *roomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i%2 == 0) {
            [roomBtn setFrame:CGRectMake(7*ScreenWidth/320+(i+1)%2 *(150+7) *ScreenWidth/320, 7*ScreenHeight/568 +i/2*(167+7) *ScreenHeight/568, 150*ScreenWidth/320, 167*ScreenHeight/568)];
        }else{
            [roomBtn setFrame:CGRectMake(7*ScreenWidth/320+(i+1)%2 *(150+7) *ScreenWidth/320, 95*ScreenHeight/568 +i/2*(167+7) *ScreenHeight/568, 150*ScreenWidth/320, 167*ScreenHeight/568)];
        }
        
        [roomBtn setBackgroundColor:[UIColor whiteColor]];
        [roomBtn setTag:i];
        [roomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [roomBtn addTarget:self action:@selector(clickRoomListBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgScrollView addSubview:roomBtn];
        
        //图片
        UIImageView *roomImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, roomBtn.frame.size.width, 120*ScreenHeight/568)];
//        [roomImgV setImageWithURL:[NSURL URLWithString:[[roomListArr objectAtIndex:i] objectForKey:@"LogoUrl"]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
        [roomImgV setImageWithURL:[NSURL URLWithString:[roomListArr objectAtIndex:i]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
        [roomImgV setBackgroundColor:[UIColor clearColor]];
        [roomImgV setTag:i+20000];
        [roomBtn addSubview:roomImgV];
        
//        //title
//        UILabel *roomTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, roomImgV.frame.size.height, roomBtn.frame.size.width, 22*ScreenHeight/568)];
//        [roomTitleLab setText:[[roomListArr objectAtIndex:i] objectForKey:@"MRoomName"]];
//        [roomTitleLab setTextAlignment:NSTextAlignmentLeft];
//        [roomTitleLab setTextColor:[UIColor grayColor]];
//        [roomTitleLab setFont:[UIFont systemFontOfSize:10.0f]];
//        [roomBtn addSubview:roomTitleLab];
        
//        //面积
//        UILabel *roomAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(roomBtn.frame.size.width - 45*ScreenWidth/320 , roomTitleLab.frame.size.height + roomTitleLab.frame.origin.y, 40*ScreenWidth/320, 20*ScreenHeight/568)];
//        roomAreaLabel.layer.borderColor = [UIColorFromHex(0x60d3c4) CGColor];
//        roomAreaLabel.layer.borderWidth = 0.8f;
//        roomAreaLabel.layer.cornerRadius = 4.0f;
//        [roomAreaLabel setText:[NSString stringWithFormat:@"%@㎡",[[roomListArr objectAtIndex:i] objectForKey:@"Area"]]];
//        [roomAreaLabel setTextAlignment:NSTextAlignmentCenter];
//        [roomAreaLabel setTextColor:[UIColor grayColor]];
//        [roomAreaLabel setFont:[UIFont systemFontOfSize:12.0f]];
//        [roomBtn addSubview:roomAreaLabel];
        
    }

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
