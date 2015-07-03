//
//  TabBarView.m
//  ZXYY
//
//  Created by soldier on 15/3/31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "TabBarView.h"

@implementation TabBarView
@synthesize numLab = _numLab;

- (id)initWithFrame:(CGRect)frame tabBarInfo:(NSArray *) tabBarInfo normalImageArr:(NSArray *) normalImageArr selectImageArr:(NSArray *) selectImageArr;
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        [lineV setBackgroundColor:[UIColor grayColor]];
        [self addSubview:lineV];
        
        self.numLab = [[UILabel alloc] init];
        
        normalImgArr = [[NSArray alloc] initWithArray:normalImageArr];
        selectImgArr = [[NSArray alloc] initWithArray:selectImageArr];
        
        tabBarCount = [tabBarInfo count];
        float tabBarWidth = ScreenWidth/tabBarCount;
        float tabBarHieght = self.frame.size.height;
        
        tabBarBtDic = [[NSMutableDictionary alloc] init];
        normalSelectTag = 10;
        
        for (int i = 0; i<tabBarCount; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(tabBarWidth *i, 0, tabBarWidth, tabBarHieght)];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTag:i+10];
            [btn addTarget:self action:@selector(selectTabBarItem:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((tabBarWidth-(30*ScreenWidth/320))/2, 3, 30*ScreenWidth/320, 30*ScreenHeight/568)];
            [imageView setImage:LoadImage([normalImageArr objectAtIndex:i], @"png")];
            [imageView setTag:i+20];
            [btn addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32*ScreenHeight/568, tabBarWidth, 14*ScreenHeight/568)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setText:[tabBarInfo objectAtIndex:i]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor grayColor]];
            [label setFont:[UIFont boldSystemFontOfSize:12.0f]];
            [label setTag:30+i];
            [btn addSubview:label];
            
            if (btn.tag == normalSelectTag) {
                [imageView setImage:LoadImage([selectImageArr objectAtIndex:i], @"png")];
                [label setTextColor:UIColorFromHex(0x60d3c4)];
            }else {
                [imageView setImage:LoadImage([normalImageArr objectAtIndex:i], @"png")];
                [label setTextColor:[UIColor grayColor]];
            }
            
            [tabBarBtDic setValue:btn forKey:[NSString stringWithFormat:@"%lud",i+normalSelectTag]];
            [self addSubview:btn];

        }
    }
    return self;
}

- (void)selectTabBarItem:(id)sender
{
    UIButton *tmpBt = (UIButton *)sender;
    int index = (int)tmpBt.tag;
    NSString *selectIndex = [NSString stringWithFormat:@"%d",index];
    
    for (int j = 0; j<tabBarCount; j++) {
        UIImageView *imageV = (UIImageView *)[self viewWithTag:20 +j];
        [imageV setImage:LoadImage([normalImgArr objectAtIndex:j], @"png")];
        UILabel *label = (UILabel *)[self viewWithTag:30+j];
        [label setTextColor:[UIColor grayColor]];
    }

    UIImageView *imageV = (UIImageView *)[self viewWithTag:index +10 ];
    [imageV setImage:LoadImage([selectImgArr objectAtIndex:index-10], @"png")];
    UILabel *label = (UILabel *)[self viewWithTag:index+20];
    [label setTextColor:UIColorFromHex(0x60d3c4)];
    
    if ([self.delegate respondsToSelector:@selector(selectTabBarItem:)]) {
        [self.delegate selectTabBarItem:selectIndex];
    }
    
}

//设置个数
- (void)setNumOfChatView:(NSString *)num
{
    UIButton *chatViewBtn = (UIButton *)[self viewWithTag:12];
    [self.numLab setFrame:CGRectMake(chatViewBtn.bounds.origin.x+chatViewBtn.frame.size.width - 20, 2, 15, 15)];
    [self.numLab setBackgroundColor:[UIColor redColor]];
    self.numLab.layer.cornerRadius = 7.5f;
    self.numLab.layer.masksToBounds = YES;
    [self.numLab setText:num];
    [self.numLab setTextColor:[UIColor whiteColor]];
    [self.numLab setTextAlignment:NSTextAlignmentCenter];
    [self.numLab setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [chatViewBtn addSubview:self.numLab];
    
}

@end
