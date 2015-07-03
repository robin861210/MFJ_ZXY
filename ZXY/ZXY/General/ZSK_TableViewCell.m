//
//  BDXQ_TableViewCell.m
//  ZXYY
//
//  Created by hndf on 15-3-31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "ZSK_TableViewCell.h"

@implementation ZSK_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createTableCell];
    }
    return self;
}

- (void)createTableCell {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:imageView];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, self.frame.size.width-90, 20)];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [titleLab setFont:[UIFont systemFontOfSize:15.0f]];
    [self addSubview:titleLab];
    
    hotReadLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-90, 5, 90, 20)];
    [hotReadLab setBackgroundColor:[UIColor clearColor]];
    [hotReadLab setFont:[UIFont systemFontOfSize:15.0f]];
    [hotReadLab setTextColor:[UIColor redColor]];
    [hotReadLab setText:@"最热"];
    [hotReadLab setHidden:YES];
    [self addSubview:hotReadLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, self.frame.size.width, 20)];
    [timeLab setBackgroundColor:[UIColor clearColor]];
    [timeLab setFont:[UIFont systemFontOfSize:13.0f]];
    [self addSubview:timeLab];
    
    readCountLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-110, 40, 100, 20)];
    [readCountLab setBackgroundColor:[UIColor clearColor]];
    [readCountLab setTextColor:[UIColor grayColor]];
    [readCountLab setTextAlignment:NSTextAlignmentRight];
    [readCountLab setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:readCountLab];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, self.frame.size.width, 0.5)];
    [lineV setBackgroundColor:[UIColor grayColor]];
    [self addSubview:lineV];
}

- (void)setCellImageView:(NSString *)imgUrlStr {
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
}

- (void)setCellTitleInfo:(NSString *)titleInfoStr {
    [titleLab setText:titleInfoStr];
}

- (void)setCellHotReadType:(BOOL)hotReadType {
    [hotReadLab setHidden:hotReadType];
}

- (void)setCellTimeInfo:(NSString *)timeInfoStr {
    [timeLab setText:timeInfoStr];
}

- (void)setCellReadCount:(NSString *)readCountStr {
    [readCountLab setText:[NSString stringWithFormat:@"阅读数: %@",readCountStr]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
