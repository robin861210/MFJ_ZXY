//
//  KanZXTableViewCell.m
//  ZXY
//
//  Created by acewill on 15/6/26.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "KanZXTableViewCell.h"

@implementation KanZXTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        cellHeight = (ScreenHeight-50-64*ScreenHeight/568)/2;
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, cellHeight-20)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bgView];
        
        [self create_KanZX_360AllS];
        [self create_KanZX_JingXuanCell];
        [self setKanZX_360AllSDisplay:YES];
        [self setKanZX_JingXuanDisplayHidden:YES];
        
    }
    return self;
}

- (void)setKanZX_JingXuanDisplayHidden:(BOOL) displayHidden {
    [EffectImgView setHidden:displayHidden];
    [perImgView setHidden:displayHidden];
    [nameLab setHidden:displayHidden];
    [roomTypeLab setHidden:displayHidden];
    [startImgView setHidden:displayHidden];
    [readNumLab setHidden:displayHidden];
}

- (void)create_KanZX_JingXuanCell
{
    EffectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, cellHeight-90)];
    [EffectImgView setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:EffectImgView];
    
    perImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-70, cellHeight-85, 55, 55)];
    [perImgView setBackgroundColor:[UIColor clearColor]];
    [perImgView.layer setMasksToBounds:YES];
    [perImgView.layer setCornerRadius:55/2];
    [bgView addSubview:perImgView];
    
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, cellHeight-85, 200, 20)];
    [nameLab setBackgroundColor:[UIColor clearColor]];
    [nameLab setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [bgView addSubview:nameLab];
    
    roomTypeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, cellHeight-62, 200, 20)];
    [roomTypeLab setBackgroundColor:[UIColor clearColor]];
    [roomTypeLab setFont:[UIFont systemFontOfSize:15.0f]];
    [roomTypeLab setTextColor:[UIColor grayColor]];
    [bgView addSubview:roomTypeLab];
    
//    startImgView = [[UIImageView alloc] initWithFrame:CGRectMake(7, cellHeight-40, 20, 20)];
//    [startImgView setBackgroundColor:[UIColor clearColor]];
//    [startImgView setImage:LoadImage(@"kanZX_start@2x", @"png")];
//    [bgView addSubview:startImgView];
    
    readNumLab = [[UILabel alloc] initWithFrame:CGRectMake(10, cellHeight-40, 150, 20)];
    [readNumLab setBackgroundColor:[UIColor clearColor]];
    [readNumLab setFont:[UIFont systemFontOfSize:13.0f]];
    [readNumLab setTextColor:[UIColor grayColor]];
    [bgView addSubview:readNumLab];

}

- (void)setKanZX_JingXuanCell:(NSMutableDictionary *)JXCellDic {
    //设置数据内容：效果图、人物头像、名称、户型名称、阅读数
    [EffectImgView sd_setImageWithURL:[NSURL URLWithString:[JXCellDic objectForKey:@"MRoomLogoUrl"]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
    [perImgView sd_setImageWithURL:[NSURL URLWithString:[JXCellDic objectForKey:@"MRoomAuthorIcon"]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
    [nameLab setText:[JXCellDic objectForKey:@"MRoomName"]];
    [roomTypeLab setText:[JXCellDic objectForKey:@"MRoomStyle"]];
    [readNumLab setText:[JXCellDic objectForKey:@"MRoomArea"]];
}

- (void)setKanZX_360AllSDisplay:(BOOL) displayHidden {
    [all_EffectImgView setHidden:displayHidden];
    [all_IconImgView setHidden:displayHidden];
    [all_StartImgView setHidden:displayHidden];
    [all_commentImgView setHidden:displayHidden];
    [all_LookImgView setHidden:displayHidden];
    
    [all_readNumLab setHidden:displayHidden];
    [all_commentNumLab setHidden:displayHidden];
    [all_LookNumLab setHidden:displayHidden];
    [all_roomTitleLab setHidden:displayHidden];
    [all_360Lab setHidden:displayHidden];
    
}

- (void)create_KanZX_360AllS
{
    all_IconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 20, 35, 35)];
    [all_IconImgView setBackgroundColor:[UIColor clearColor]];
    [all_IconImgView setImage:LoadImage(@"360@2x", @"png")];
    [bgView addSubview:all_IconImgView];
    all_360Lab = [[UILabel alloc] initWithFrame:CGRectMake(35, 25, 60, 25)];
    [all_360Lab setBackgroundColor:[UIColor clearColor]];
    [all_360Lab setTextColor:RGBACOLOR(102, 205, 170, 1)];
    [all_360Lab setFont:[UIFont systemFontOfSize:13.0f]];
    [all_360Lab setText:@"360全景"];
    [bgView addSubview:all_360Lab];
    
    all_LookImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/3*2, cellHeight-48, 25, 25)];
    [all_LookImgView setBackgroundColor:[UIColor clearColor]];
    [all_LookImgView setImage:LoadImage(@"kanZX_look@2x", @"png")];
    [bgView addSubview:all_LookImgView];
    all_LookNumLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/3*2+25, cellHeight-48, 35, 25)];
    [all_LookNumLab setBackgroundColor:[UIColor clearColor]];
    [all_LookNumLab setTextColor:[UIColor grayColor]];
    [all_LookNumLab setFont:[UIFont systemFontOfSize:12.0f]];
    [bgView addSubview:all_LookNumLab];
    
    all_commentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/3, cellHeight-48, 25, 25)];
    [all_commentImgView setBackgroundColor:[UIColor clearColor]];
    [all_commentImgView setImage:LoadImage(@"kanZX_comment@2x", @"png")];
    [bgView addSubview:all_commentImgView];
    all_commentNumLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/3+25, cellHeight-48, 35, 25)];
    [all_commentNumLab setBackgroundColor:[UIColor clearColor]];
    [all_commentNumLab setTextColor:[UIColor grayColor]];
    [all_commentNumLab setFont:[UIFont systemFontOfSize:12.0f]];
    [bgView addSubview:all_commentNumLab];
    
    all_StartImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, cellHeight-48, 25, 25)];
    [all_StartImgView setBackgroundColor:[UIColor clearColor]];
    [all_StartImgView setImage:LoadImage(@"kanZX_start@2x", @"png")];
    [bgView addSubview:all_StartImgView];
    all_readNumLab = [[UILabel alloc] initWithFrame:CGRectMake(30, cellHeight-48, 35, 25)];
    [all_readNumLab setBackgroundColor:[UIColor clearColor]];
    [all_readNumLab setTextColor:[UIColor grayColor]];
    [all_readNumLab setFont:[UIFont systemFontOfSize:12.0f]];
    [bgView addSubview:all_readNumLab];
    
    all_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 180, 20)];
    [all_titleLab setBackgroundColor:[UIColor clearColor]];
    [all_titleLab setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [bgView addSubview:all_titleLab];
    
    all_EffectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, cellHeight-100)];
    [all_EffectImgView setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:all_EffectImgView];
    
    all_roomTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-200, 5, 200, 30)];
    [all_roomTitleLab setBackgroundColor:[UIColor clearColor]];
    [all_roomTitleLab setFont:[UIFont systemFontOfSize:13.0f]];
    [all_roomTitleLab setTextAlignment:NSTextAlignmentRight];
    [bgView addSubview:all_roomTitleLab];
    
}

- (void)setKanZX_360Alls:(NSMutableDictionary *)allsCellDic
{
    //设置数据内容：标题、点赞数、评论数、阅读数、效果图、房间信息
    [all_titleLab setText:[allsCellDic objectForKey:@"PanoName"]];
    [all_readNumLab setText:[allsCellDic objectForKey:@"PanoCollectionCount"]];
    [all_commentNumLab setText:[allsCellDic objectForKey:@"PanoMessAgeCount"]];
    [all_LookNumLab setText:[allsCellDic objectForKey:@"PanoReadCount"]];
    [all_EffectImgView sd_setImageWithURL:[NSURL URLWithString:[allsCellDic objectForKey:@"PanoLogoUrl"]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
    [all_roomTitleLab setText:[allsCellDic objectForKey:@"PanoLabel"]];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
