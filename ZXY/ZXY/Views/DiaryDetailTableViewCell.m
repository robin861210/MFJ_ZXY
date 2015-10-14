//
//  DiaryDetailTableViewCell.m
//  ZXY
//
//  Created by soldier on 15/9/29.
//  Copyright © 2015年 MFJ_zxy. All rights reserved.
//

#import "DiaryDetailTableViewCell.h"

@implementation DiaryDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //日记名称
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5*ScreenHeight/568, 0, 20*ScreenHeight/568)];
        [titleLabel setBackgroundColor:UIColorFromHex(0x3dbf86)];
        [titleLabel setText:@"装修开工"];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:titleLabel];
        
        //日记日期
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.size.width + 5, 5*ScreenHeight/568, 100*ScreenWidth/320, 20*ScreenHeight/568)];
        [dateLabel setTextAlignment:NSTextAlignmentLeft];
        [dateLabel setText:@"2015-09-09"];
        [dateLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [self addSubview:dateLabel];
        
        //装修日记、图片
        imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30*ScreenHeight/568, ScreenWidth, 75*ScreenHeight/568)];
        [imgScrollView setBackgroundColor:[UIColor clearColor]];
        [imgScrollView setShowsHorizontalScrollIndicator:NO];
        [imgScrollView setShowsVerticalScrollIndicator:NO];
        [imgScrollView setDelegate:self];
        [self addSubview:imgScrollView];
        
        //日记内容
        diaryContentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 110*ScreenHeight/568, ScreenWidth, 100*ScreenHeight/568)];
        [diaryContentLab setText:@"最近在看壁纸，本来初衷是想要地中海的，结果看来看去快变成田园小碎花了，看中的两款都是花的，一个电视墙一个卧室，次卧就刷钱率鹿角漆。昨天看到一款壁布，也挺不错的。店主说好打理，不过我感觉毛蓉蓉的估计会招灰。"];
        [diaryContentLab setTextColor:UIColorFromHex(0x999999)];
        [diaryContentLab setTextAlignment:NSTextAlignmentLeft];
        [diaryContentLab setNumberOfLines:0];
        [diaryContentLab setLineBreakMode:NSLineBreakByCharWrapping];
        [diaryContentLab setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:diaryContentLab];
        
        //装修状态
        zxStateLab = [[UILabel alloc] initWithFrame:CGRectMake(12*ScreenWidth/320, 210*ScreenHeight/568, 40*ScreenWidth/320, 13*ScreenHeight/568)];
        zxStateLab.layer.borderColor = [UIColorFromHex(0x35c083) CGColor];
        zxStateLab.layer.borderWidth = 0.5f;
        zxStateLab.layer.masksToBounds = YES;
        zxStateLab.layer.cornerRadius = 7.0f;
        [zxStateLab setText:@"装修完"];
        [zxStateLab setTextAlignment:NSTextAlignmentCenter];
        [zxStateLab setTextColor:UIColorFromHex(0x35c083)];
        [zxStateLab setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:zxStateLab];
        
        goodAndMessView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-100, 210*ScreenHeight/568, 100, 13*ScreenHeight/568)];
//        [goodAndMessView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:goodAndMessView];
        
        UIImageView *goodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 10, 10)];
        [goodImgView setImage:LoadImage(@"zxy_good@2x", @"png")];
        [goodAndMessView addSubview:goodImgView];
        
        zxCollectionNum = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 20, 10)];
        [zxCollectionNum setTextAlignment:NSTextAlignmentCenter];
        [zxCollectionNum setFont:[UIFont systemFontOfSize:10.0f]];
        [goodAndMessView addSubview:zxCollectionNum];
        
        UIImageView *messgaeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 10, 10)];
        [messgaeImgView setImage:LoadImage(@"zxy_message@2x", @"png")];
        [goodAndMessView addSubview:messgaeImgView];
        
        zxCommentsNum = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 20, 10)];
        [zxCommentsNum setTextAlignment:NSTextAlignmentCenter];
        [zxCommentsNum setFont:[UIFont systemFontOfSize:10.0f]];
        [goodAndMessView addSubview:zxCommentsNum];
    }
    return self;
}

- (void)updateDiaryDetailCellInfoData:(NSDictionary *)infoData
{
    //日记名称
    CGSize maxSize = CGSizeMake(ScreenWidth, 20*ScreenHeight/568);
    UIFont *contentFont = [UIFont systemFontOfSize:13.0f];
    NSString *zxTitleStr = [infoData objectForKey:@"DecLabel"];
    CGSize contentSize = [zxTitleStr sizeWithFont:contentFont constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    [titleLabel setFont:contentFont];
    [titleLabel setFrame:CGRectMake(0, 5*ScreenHeight/568, contentSize.width+10, 20*ScreenHeight/568)];
    [titleLabel setText:zxTitleStr];
    
    //日记时间
    [dateLabel setText:[infoData objectForKey:@"CreateDate"]];
    [dateLabel setFrame:CGRectMake(titleLabel.frame.size.width + 5, 5*ScreenHeight/568, 100*ScreenWidth/320, 20*ScreenHeight/568)];

    NSArray *ADpicStrArray = [[infoData objectForKey:@"IconNames"] componentsSeparatedByString:@"|"];
    
    [self setPicture:ADpicStrArray];
    
    //日记内容
    [diaryContentLab setText:[infoData objectForKey:@"DecDiary"]];
    CGSize boundSize = CGSizeMake(ScreenWidth-10, CGFLOAT_MAX);
    //    diaryTableCell.userInteractionEnabled = NO;
    diaryContentLab.numberOfLines = 0;
    CGSize requiredSize = [diaryContentLab.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:boundSize lineBreakMode:NSLineBreakByWordWrapping];
    
    [diaryContentLab setFrame:CGRectMake(5, self.cellHeight,ScreenWidth-10 ,requiredSize.height)];
    self.cellHeight += requiredSize.height;
    
    //装修状态
    switch ([[infoData objectForKey:@"Stage"] integerValue]) {
        case 1:
            [zxStateLab setText:@"水电施工"];
            break;
        case 2:
            [zxStateLab setText:@"木工施工"];
            break;
        case 3:
            [zxStateLab setText:@"油工施工"];
            break;
        case 4:
            [zxStateLab setText:@"成品安装"];
            break;
        case 5:
            [zxStateLab setText:@"工程竣工"];
            break;
            
        default:
            break;
    }
//    [zxStateLab setText:[infoData objectForKey:@"Stage"]];
    [zxStateLab setFrame:CGRectMake(12*ScreenWidth/320, self.cellHeight, 40*ScreenWidth/320, 13*ScreenHeight/568)];
    [zxCollectionNum setText:[NSString stringWithFormat:@"%@",[infoData objectForKey:@"CollCount"]]];
    [zxCommentsNum setText:[NSString stringWithFormat:@"%@",[infoData objectForKey:@"MessageCount"]]];
    [goodAndMessView setFrame:CGRectMake(ScreenWidth-100, self.cellHeight, 100, 13*ScreenHeight/568)];
    self.cellHeight += 20*ScreenHeight/568;
    
}

- (void)setPicture:(NSArray *)imgNameArr
{
    for (UIView *view in [imgScrollView subviews]) {
        [view removeFromSuperview];
    }
    NSLog(@"%.2f",self.cellHeight);
    if (imgNameArr.count == 0) {
        [imgScrollView setHidden:YES];
        self.cellHeight = 30*ScreenHeight/568;
    }else
    {
        [imgScrollView setHidden:NO];
        self.cellHeight = 105*ScreenHeight/568;
    }
    
    for (int i = 0; i<[imgNameArr count]; i++) {
//        UIImageView *pictureImgV = [[UIImageView alloc] initWithFrame:CGRectMake(i*79*ScreenWidth/320+4*ScreenWidth/320, 0, 75*ScreenHeight/568, 75*ScreenHeight/568)];
        UIImageView *pictureImgV = [[UIImageView alloc] initWithFrame:CGRectMake(i*105*ScreenWidth/320+5*ScreenWidth/320, 0, 100*ScreenHeight/568, 75*ScreenHeight/568)];
        [pictureImgV sd_setImageWithURL:[NSURL URLWithString:[imgNameArr objectAtIndex:i]] placeholderImage:LoadImage(@"zxDiary@2x", @"jpg")];
        [imgScrollView addSubview:pictureImgV];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
