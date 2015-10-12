//
//  DiaryCommentCell.m
//  ashdaksjh
//
//  Created by soldier on 15/10/9.
//  Copyright © 2015年 AA. All rights reserved.
//

#import "DiaryCommentCell.h"

@implementation DiaryCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
        [headImgView.layer setMasksToBounds:YES];
        [headImgView.layer setCornerRadius:15.0f];
        [self addSubview:headImgView];
        
        //用户名称
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50*ScreenWidth/320, 15, 200, 15)];
        [userNameLabel setTextColor:UIColorFromHex(0xb7b8b9)];
        [userNameLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:userNameLabel];
        
        //时间
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 20, 40, 15)];
        [dateLabel setTextAlignment:NSTextAlignmentRight];
        [dateLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [self addSubview:dateLabel];
        
        //评论详情
        commentsContentLabel = [[UILabel alloc] init];
        [commentsContentLabel setFont:[UIFont systemFontOfSize:11.0f]];
        commentsContentLabel.numberOfLines = 0;
        [self addSubview:commentsContentLabel];
    }
    return self;
}

- (void)updateDiaryCommentCellInfo:(NSDictionary *)diaryCommentDic
{
    [headImgView sd_setImageWithURL:[NSURL URLWithString:[diaryCommentDic objectForKey:@"CommanderHeadIcon"]] placeholderImage:LoadImage(@"head", @"jpg")];
    
    [userNameLabel setText:[diaryCommentDic objectForKey:@"CommanderName"]];
    
    [dateLabel setText:[diaryCommentDic objectForKey:@"CommanderDate"]];
    
    [commentsContentLabel setText:[diaryCommentDic objectForKey:@"CommanderContext"]];
    CGSize boundSize = CGSizeMake(250*ScreenWidth/320, CGFLOAT_MAX);
    CGSize requiredSize = [commentsContentLabel.text boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} context:nil].size;
    [commentsContentLabel setFrame:CGRectMake(50*ScreenWidth/320, 40, 250*ScreenWidth/320, requiredSize.height)];
    
    self.cellHeight = requiredSize.height + 50;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
