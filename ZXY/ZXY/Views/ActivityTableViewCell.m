//
//  ActivityTableViewCell.m
//  ZXY
//
//  Created by soldier on 15/6/20.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "UIImageView+MJWebCache.h"

@implementation ActivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //图片
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15*ScreenHeight/568, 80, 60*ScreenHeight/568)];
        [imgView setImage:LoadImage(@"activitytest@2x", @"jpeg")];
        [self addSubview:imgView];
        
        //标题
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15*ScreenHeight/568, ScreenWidth-150, 15*ScreenHeight/568)];
        [titleLabel setText:@"林凤装饰 5.1回馈新老用户 洁具全场6折起"];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [self addSubview:titleLabel];
        
        //标签
        UIImageView *tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [tagImgView setImage:LoadImage(@"", @"")];
        [self addSubview:tagImgView];
        
        //评星
        CWStarRateView *starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(100, 30*ScreenHeight/568, 100, 15*ScreenHeight/568) numberOfStars:5];
        starRateView.scorePercent = 0.0f;
        starRateView.allowIncompleteStar = NO;
        starRateView.hasAnimation = YES;
        starRateView.changeStartPercent = YES;
        starRateView.delegate = self;
        [self addSubview:starRateView];

        //报名
        applyLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 30*ScreenHeight/568, 100, 15*ScreenHeight/568)];
        [applyLabel setText:@"已有多少人报名"];
        [applyLabel setTextColor:[UIColor lightGrayColor]];
        [applyLabel setTextAlignment:NSTextAlignmentLeft];
        [applyLabel setFont:[UIFont systemFontOfSize:8.0f]];
        [self addSubview:applyLabel];
        
        //活动时间
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 45*ScreenHeight/568, 200, 15*ScreenHeight/568)];
        [timeLabel setText:@"活动时间：2015-04-20至2015-05-20"];
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        [timeLabel setTextColor:[UIColor lightGrayColor]];
        [timeLabel setFont:[UIFont systemFontOfSize:8.0f]];
        [self addSubview:timeLabel];
        
        //地址 图标
        UIImageView *addImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 60*ScreenHeight/568, 15*ScreenHeight/568, 15*ScreenHeight/568)];
        [addImgView setImage:LoadImage(@"", @"png")];
        [self addSubview:addImgView];
        
        //地址
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 60*ScreenHeight/568, 200, 15*ScreenHeight/568)];
        [addressLabel setText:@"辽宁 沈阳 林凤装饰"];
        [addressLabel setTextAlignment:NSTextAlignmentLeft];
        [addressLabel setTextColor:[UIColor lightGrayColor]];
        [addressLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:addressLabel];
        
        //分隔线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80*ScreenHeight/568, ScreenWidth, 1.0f)];
        [lineView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:lineView];
        
    }
    return self;
}

- (void)updateActiveCellData:(NSDictionary *)infoDic {
    
    [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[infoDic objectForKey:@"Urls"],[infoDic objectForKey:@"Logos"]]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
    [titleLabel setText:[NSString stringWithFormat:@"%@",[infoDic objectForKey:@"ActName"]]];
//    [shopLab setText:[NSString stringWithFormat:@"%@",[infoDic objectForKey:@"Contact"]]];
    
    NSString *start = [NSString stringWithFormat:@"%@",[[[infoDic objectForKey:@"StartTime"] componentsSeparatedByString:@" "] objectAtIndex:0]];
    NSString *end = [NSString stringWithFormat:@"%@",[[[infoDic objectForKey:@"EndTime"] componentsSeparatedByString:@" "] objectAtIndex:0]];
    
    [timeLabel setText:[NSString stringWithFormat:@"活动时间:      %@到%@截止",start,end]];
    [addressLabel setText:[NSString stringWithFormat:@"活动地址:      %@",[infoDic objectForKey:@"Organizer"]]];
    [applyLabel setText:[NSString stringWithFormat:@"参与人数:      %@",[infoDic objectForKey:@"JoinMan"]]];
    
    activeID = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"ActID"]];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
