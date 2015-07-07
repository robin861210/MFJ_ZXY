//
//  DiaryTableViewCell.m
//  ZXY
//
//  Created by soldier on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "DiaryTableViewCell.h"

@implementation DiaryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10*ScreenWidth/320, 10*ScreenWidth/320, 45*ScreenWidth/320, 45*ScreenWidth/320)];
        headImgV.layer.borderColor = [UIColorFromHex(0xbfbebe) CGColor];
        headImgV.layer.borderWidth = 0.5f;
        headImgV.layer.masksToBounds = YES;
        headImgV.layer.cornerRadius = headImgV.frame.size.width/2;
        [headImgV setImage:LoadImage(@"head", @"jpg")];
//        [headImgV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:LoadImage(@"", @"png")];
        [self addSubview:headImgV];
        
        //装修状态
        zxStateLab = [[UILabel alloc] initWithFrame:CGRectMake(12*ScreenWidth/320, 65*ScreenWidth/320, 40*ScreenWidth/320, 13*ScreenHeight/568)];
        zxStateLab.layer.borderColor = [UIColorFromHex(0x35c083) CGColor];
        zxStateLab.layer.borderWidth = 0.5f;
        zxStateLab.layer.masksToBounds = YES;
        zxStateLab.layer.cornerRadius = 2.0f;
        [zxStateLab setText:@"装修完"];
        [zxStateLab setTextAlignment:NSTextAlignmentCenter];
        [zxStateLab setTextColor:UIColorFromHex(0x35c083)];
        [zxStateLab setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:zxStateLab];
        
        //日记名称
        zxTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 10*ScreenHeight/568, 0, 20*ScreenHeight/568)];
//        [zxTitleLab setText:@"装修易在线工地"];
        [zxTitleLab setTextColor:[UIColor blackColor]];
        [zxTitleLab setTextAlignment:NSTextAlignmentLeft];
        CGSize maxSize = CGSizeMake(320, 20);
        UIFont *contentFont = [UIFont systemFontOfSize:15.0f];
        NSString *zxTitleStr = @"装修易在线工地";
        CGSize contentSize = [zxTitleStr sizeWithFont:contentFont constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        [zxTitleLab setFont:contentFont];
        [zxTitleLab setFrame:CGRectMake(65*ScreenWidth/320, 10, contentSize.width, 20)];
        [zxTitleLab setText:zxTitleStr];
        [self addSubview:zxTitleLab];
        
        //日记篇数
        zxNumLab = [[UILabel alloc] initWithFrame:CGRectMake(zxTitleLab.frame.size.width + zxTitleLab.frame.origin.x, zxTitleLab.frame.origin.y, 40*ScreenWidth/320, 20*ScreenHeight/568)];
        [zxNumLab setText:@"（24篇）"];
        [zxNumLab setTextColor:UIColorFromHex(0x999999)];
        [zxNumLab setTextAlignment:NSTextAlignmentLeft];
        [zxNumLab setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:zxNumLab];
        
        //收藏数量
        zxCollectionLab = [[UILabel alloc] initWithFrame:CGRectMake(240*ScreenWidth/320, 10*ScreenHeight/568, 25*ScreenWidth/320, 20*ScreenHeight/568)];
        [zxCollectionLab setText:@"321"];
        [zxCollectionLab setTextColor:UIColorFromHex(0x999999)];
        [zxCollectionLab setTextAlignment:NSTextAlignmentLeft];
        [zxCollectionLab setFont:[UIFont systemFontOfSize:8.0f]];
        [self addSubview:zxCollectionLab];
        
        //信息数量
        messageNumLab = [[UILabel alloc] initWithFrame:CGRectMake(265*ScreenWidth/320, 10*ScreenHeight/568, 25*ScreenWidth/320, 20*ScreenHeight/568)];
        [messageNumLab setText:@"9281"];
        [messageNumLab setTextColor:UIColorFromHex(0x999999)];
        [messageNumLab setTextAlignment:NSTextAlignmentLeft];
        [messageNumLab setFont:[UIFont systemFontOfSize:8.0f]];
        [self addSubview:messageNumLab];
        
        //查看次数
        seenNumLab = [[UILabel alloc] initWithFrame:CGRectMake(290*ScreenWidth/320, 10*ScreenHeight/568, 25*ScreenWidth/320, 20*ScreenHeight/568)];
        [seenNumLab setText:@"5"];
        [seenNumLab setTextColor:UIColorFromHex(0x999999)];
        [seenNumLab setTextAlignment:NSTextAlignmentLeft];
        [seenNumLab setFont:[UIFont systemFontOfSize:8.0f]];
        [self addSubview:seenNumLab];
        
        //工程信息
        decInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 30*ScreenHeight/568, 255*ScreenWidth/320, 20*ScreenHeight/568)];
        [decInfoLab setText:@"万科嘉园 120㎡ 10万-15万 全包"];
        [decInfoLab setTextColor:UIColorFromHex(0x999999)];
        [decInfoLab setTextAlignment:NSTextAlignmentLeft];
        [decInfoLab setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:decInfoLab];
        
//        //项目名称
//        zxNameLab = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 0, 0)];
//        [zxNameLab setText:@"万科嘉园"];
//        [zxNameLab setTextColor:UIColorFromHex(0x999999)];
//        [zxNameLab setTextAlignment:NSTextAlignmentLeft];
//        [zxNameLab setFont:[UIFont systemFontOfSize:10.0f]];
//        [self addSubview:zxNameLab];
//        
//        //装修面积
//        zxAreaLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        [zxAreaLab setText:@"120㎡"];
//        [zxAreaLab setTextColor:UIColorFromHex(0x999999)];
//        [zxAreaLab setTextAlignment:NSTextAlignmentLeft];
//        [zxAreaLab setFont:[UIFont systemFontOfSize:10.0f]];
//        [self addSubview:zxAreaLab];
//        
//        //装修价格
//        zxPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        [zxPriceLab setText:@"10万-15万"];
//        [zxPriceLab setTextColor:UIColorFromHex(0x999999)];
//        [zxPriceLab setTextAlignment:NSTextAlignmentLeft];
//        [zxPriceLab setFont:[UIFont systemFontOfSize:10.0f]];
//        [self addSubview:zxPriceLab];
//        
//        //装修类型（全包、半包）
//        zxStyleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        [zxStyleLab setText:@"全包"];
//        [zxStyleLab setTextColor:UIColorFromHex(0x999999)];
//        [zxStyleLab setTextAlignment:NSTextAlignmentLeft];
//        [zxStyleLab setFont:[UIFont systemFontOfSize:10.0f]];
//        [self addSubview:zxStyleLab];
        
        //装修日记、图片
        for (int i = 0; i<3; i++) {
            UIImageView *pictureImgV = [[UIImageView alloc] initWithFrame:CGRectMake((65 + 80*i)*ScreenWidth/320, 50*ScreenHeight/568, 75*ScreenHeight/568, 75*ScreenHeight/568)];
//            [pictureImgV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:LoadImage(@"", @"png")];
            [pictureImgV setImage:LoadImage(@"zxDiary@2x", @"png")];
            [self addSubview:pictureImgV];
        }

        //日记内容
        diaryContentLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 130*ScreenHeight/568, 255*ScreenWidth/320, 55*ScreenHeight/568)];
        [diaryContentLab setText:@"最近在看壁纸，本来初衷是想要地中海的，结果看来看去快变成田园小碎花了，看中的两款都是花的，一个电视墙一个卧室，次卧就刷钱率鹿角漆。昨天看到一款壁布，也挺不错的。店主说好打理，不过我感觉毛蓉蓉的估计会招灰。"];
        [diaryContentLab setTextColor:UIColorFromHex(0x999999)];
        [diaryContentLab setTextAlignment:NSTextAlignmentLeft];
        [diaryContentLab setNumberOfLines:0];
        [diaryContentLab setLineBreakMode:NSLineBreakByCharWrapping];
        [diaryContentLab setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:diaryContentLab];

        //日记时间
        diaryTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 185*ScreenHeight/568, 255*ScreenWidth/320, 20*ScreenHeight/568)];
        [diaryTimeLab setText:@"2015-05-14 17:31"];
        [diaryTimeLab setTextColor:UIColorFromHex(0x999999)];
        [diaryTimeLab setTextAlignment:NSTextAlignmentLeft];
        [diaryTimeLab setFont:[UIFont systemFontOfSize:8.0f]];
        [self addSubview:diaryTimeLab];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 205*ScreenHeight/568, ScreenWidth, 1.0f)];
        [lineView setBackgroundColor:UIColorFromHex(0xbfbebe)];
        [self addSubview:lineView];
    }
    return self;
}

- (void)updateDiaryCellInfoData:(NSDictionary *)infoData
{
    //头像
    [headImgV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:LoadImage(@"head", @"jpg")];
    //装修状态
    [zxStateLab setText:@""];
    //日记名称
    [zxTitleLab setText:@""];
    //日记篇数
    [zxNumLab setText:@""];
    //收藏数量
    [zxCollectionLab setText:@""];
    //信息数量
    [messageNumLab setText:@""];
    //查看次数
    [seenNumLab setText:@""];
    //装修工程信息
    [decInfoLab setText:@""];
    //日记内容
    [diaryContentLab setText:@""];
    //日记时间
    [diaryTimeLab setText:@""];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
