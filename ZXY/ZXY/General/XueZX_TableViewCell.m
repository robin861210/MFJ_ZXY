//
//  XueZX_TableViewCell.m
//  ZXY
//
//  Created by acewill on 15/6/28.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "XueZX_TableViewCell.h"

@implementation XueZX_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self create_ZSK_TableCell];
        [self create_ZXRJ_TableCell];
        [self setZSK_CellDisplay:YES];
        [self setZXRJ_CellDisplay:YES];
    }
    return self;
}

#pragma mark -
#pragma mark 学装修-知识库
- (void)create_ZSK_TableCell {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:imageView];
    
    ZSK_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, ScreenWidth-90, 36)];
    [ZSK_titleLab setLineBreakMode:NSLineBreakByWordWrapping];
    [ZSK_titleLab setNumberOfLines:2];
    [ZSK_titleLab setBackgroundColor:[UIColor clearColor]];
    [ZSK_titleLab setFont:[UIFont systemFontOfSize:13.0f]];
    [ZSK_titleLab setTextColor:[UIColor grayColor]];
    [self addSubview:ZSK_titleLab];
    
    hotReadLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-90, 5, 90, 20)];
    [hotReadLab setBackgroundColor:[UIColor clearColor]];
    [hotReadLab setFont:[UIFont systemFontOfSize:15.0f]];
    [hotReadLab setTextColor:[UIColor redColor]];
    [hotReadLab setText:@"最热"];
    [hotReadLab setHidden:YES];
    [self addSubview:hotReadLab];
    
    ZSK_timeLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 36, ScreenWidth, 20)];
    [ZSK_timeLab setBackgroundColor:[UIColor clearColor]];
    [ZSK_timeLab setFont:[UIFont systemFontOfSize:13.0f]];
    [ZSK_timeLab setTextColor:[UIColor grayColor]];
    [self addSubview:ZSK_timeLab];
    
    ZSK_tagLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 60, ScreenWidth, 15)];
    [ZSK_tagLab setBackgroundColor:[UIColor clearColor]];
    [ZSK_tagLab setFont:[UIFont systemFontOfSize:13.0f]];
    [ZSK_tagLab setTextColor:[UIColor grayColor]];
    [self addSubview:ZSK_tagLab];
    
    readCountLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-110, 40, 100, 20)];
    [readCountLab setBackgroundColor:[UIColor clearColor]];
    [readCountLab setTextColor:[UIColor grayColor]];
    [readCountLab setTextAlignment:NSTextAlignmentRight];
    [readCountLab setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:readCountLab];
    
    ZSK_lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, self.frame.size.width, 0.5)];
    [ZSK_lineV setBackgroundColor:[UIColor grayColor]];
    [self addSubview:ZSK_lineV];
}

- (void)setCellImageView:(NSString *)imgUrlStr {
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
}

- (void)setCellTitleInfo:(NSString *)titleInfoStr {
    [ZSK_titleLab setText:titleInfoStr];
}

- (void)setCellHotReadType:(BOOL)hotReadType {
//    [hotReadLab setHidden:hotReadType];
    [hotReadLab setHidden:YES];
}

- (void)setCellTimeInfo:(NSString *)timeInfoStr {
    [ZSK_timeLab setText:timeInfoStr];
}

- (void)setCellTagInfo:(NSString *)tagInfoStr {
    [ZSK_tagLab setText:tagInfoStr];
}

- (void)setCellReadCount:(NSString *)readCountStr {
    [readCountLab setText:[NSString stringWithFormat:@"阅读数: %@",readCountStr]];
}

- (void)setZSK_CellDisplay:(BOOL) cellHidden {
    [imageView setHidden:cellHidden];
    [ZSK_titleLab setHidden:cellHidden];
    [hotReadLab setHidden:cellHidden];
    [ZSK_timeLab setHidden:cellHidden];
    [ZSK_tagLab setHidden:cellHidden];
    [readCountLab setHidden:cellHidden];
    [ZSK_lineV setHidden:cellHidden];
}

#pragma mark -
#pragma mark 学装修-装修日记
- (void)create_ZXRJ_TableCell {
    //头像
    headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10*ScreenWidth/320, 10*ScreenWidth/320, 45*ScreenWidth/320, 45*ScreenWidth/320)];
    headImgV.layer.borderColor = [UIColorFromHex(0xbfbebe) CGColor];
    headImgV.layer.borderWidth = 0.5f;
    headImgV.layer.masksToBounds = YES;
    headImgV.layer.cornerRadius = headImgV.frame.size.width/2;
    [headImgV setImage:LoadImage(@"head", @"jpg")];
    [self addSubview:headImgV];
    
    //装修状态
    zxStateLab = [[UILabel alloc] initWithFrame:CGRectMake(12*ScreenWidth/320, 65*ScreenWidth/320, 40*ScreenWidth/320, 13*ScreenHeight/568)];
    zxStateLab.layer.borderColor = [UIColorFromHex(0x35c083) CGColor];
    zxStateLab.layer.borderWidth = 0.5f;
    zxStateLab.layer.masksToBounds = YES;
    zxStateLab.layer.cornerRadius = 2.0f;
//    [zxStateLab setText:@"装修完"];
    [zxStateLab setTextAlignment:NSTextAlignmentCenter];
    [zxStateLab setTextColor:UIColorFromHex(0x35c083)];
    [zxStateLab setFont:[UIFont systemFontOfSize:11.0f]];
    [self addSubview:zxStateLab];
    
    //日记名称
    zxTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 10*ScreenHeight/568, 0, 20*ScreenHeight/568)];
    //        [zxTitleLab setText:@"装修易在线工地"];
    [zxTitleLab setTextColor:[UIColor blackColor]];
    [zxTitleLab setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:zxTitleLab];
    
    //日记篇数
    zxNumLab = [[UILabel alloc] initWithFrame:CGRectMake(zxTitleLab.frame.size.width + zxTitleLab.frame.origin.x, zxTitleLab.frame.origin.y, 40*ScreenWidth/320, 20*ScreenHeight/568)];
//    [zxNumLab setText:@"（24篇）"];
    [zxNumLab setTextColor:UIColorFromHex(0x999999)];
    [zxNumLab setTextAlignment:NSTextAlignmentLeft];
    [zxNumLab setFont:[UIFont systemFontOfSize:10.0f]];
    [self addSubview:zxNumLab];
    
    //收藏数量 UIImageView
    zxCollImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240*ScreenWidth/320, 10*ScreenHeight/568, 20*ScreenHeight/568, 20*ScreenHeight/568)];
    [zxCollImgView setImage:LoadImage(@"zxy_look_collection@2x", @"png")];
    [self addSubview:zxCollImgView];
    
    //收藏数量
    zxCollectionLab = [[UILabel alloc] initWithFrame:CGRectMake(zxCollImgView.frame.origin.x + zxCollImgView.frame.size.width, 10*ScreenHeight/568, 20*ScreenWidth/320, 20*ScreenHeight/568)];
//    [zxCollectionLab setText:@"321"];
    [zxCollectionLab setTextColor:UIColorFromHex(0x999999)];
    [zxCollectionLab setTextAlignment:NSTextAlignmentLeft];
    [zxCollectionLab setFont:[UIFont systemFontOfSize:8.0f]];
    [self addSubview:zxCollectionLab];
    
    //查看次数 UIImageView
    seenNumImgView = [[UIImageView alloc] initWithFrame:CGRectMake(zxCollectionLab.frame.origin.x + zxCollectionLab.frame.size.width, 10*ScreenHeight/568, 20*ScreenHeight/568, 20*ScreenHeight/568)];
    [seenNumImgView setImage:LoadImage(@"zxy_look_see@2x", @"png")];
    [self addSubview:seenNumImgView];
    
    //查看次数
    seenNumLab = [[UILabel alloc] initWithFrame:CGRectMake(seenNumImgView.frame.origin.x + seenNumImgView.frame.size.width, 10*ScreenHeight/568, 20*ScreenWidth/320, 20*ScreenHeight/568)];
//    [seenNumLab setText:@"5"];
    [seenNumLab setTextColor:UIColorFromHex(0x999999)];
    [seenNumLab setTextAlignment:NSTextAlignmentLeft];
    [seenNumLab setFont:[UIFont systemFontOfSize:8.0f]];
    [self addSubview:seenNumLab];
    
    //工程信息
    decInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 30*ScreenHeight/568, 255*ScreenWidth/320, 20*ScreenHeight/568)];
//    [decInfoLab setText:@"万科嘉园 120㎡ 10万-15万 全包"];
    [decInfoLab setTextColor:UIColorFromHex(0x999999)];
    [decInfoLab setTextAlignment:NSTextAlignmentLeft];
    [decInfoLab setFont:[UIFont systemFontOfSize:10.0f]];
    [self addSubview:decInfoLab];
    
    //装修日记、图片
    imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 50*ScreenHeight/568, 255*ScreenWidth/320, 75*ScreenHeight/568)];
    [imgScrollView setBackgroundColor:[UIColor clearColor]];
    [imgScrollView setShowsHorizontalScrollIndicator:NO];
    [imgScrollView setShowsVerticalScrollIndicator:NO];
    [imgScrollView setDelegate:self];
    [self addSubview:imgScrollView];
    
    //日记内容
    diaryContentLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 130*ScreenHeight/568, 255*ScreenWidth/320, 55*ScreenHeight/568)];
//    [diaryContentLab setText:@"最近在看壁纸，本来初衷是想要地中海的，结果看来看去快变成田园小碎花了，看中的两款都是花的，一个电视墙一个卧室，次卧就刷钱率鹿角漆。昨天看到一款壁布，也挺不错的。店主说好打理，不过我感觉毛蓉蓉的估计会招灰。"];
    [diaryContentLab setTextColor:UIColorFromHex(0x999999)];
    [diaryContentLab setTextAlignment:NSTextAlignmentLeft];
    [diaryContentLab setNumberOfLines:0];
    [diaryContentLab setLineBreakMode:NSLineBreakByCharWrapping];
    [diaryContentLab setFont:[UIFont systemFontOfSize:10.0f]];
    [self addSubview:diaryContentLab];
    
    //日记时间
    diaryTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(65*ScreenWidth/320, 185*ScreenHeight/568, 255*ScreenWidth/320, 20*ScreenHeight/568)];
//    [diaryTimeLab setText:@"2015-05-14 17:31"];
    [diaryTimeLab setTextColor:UIColorFromHex(0x999999)];
    [diaryTimeLab setTextAlignment:NSTextAlignmentLeft];
    [diaryTimeLab setFont:[UIFont systemFontOfSize:8.0f]];
    [self addSubview:diaryTimeLab];
}

//这是装修日记的数据
- (void)updateDiaryCellInfoData:(NSDictionary *)infoData
{
    //头像
    [headImgV sd_setImageWithURL:[NSURL URLWithString:[infoData objectForKey:@"UserHeadIcon"]] placeholderImage:LoadImage(@"head", @"jpg")];
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
    //日记名称
    CGSize maxSize = CGSizeMake(ScreenWidth, 20*ScreenHeight/568);
    UIFont *contentFont = [UIFont systemFontOfSize:15.0f];
    NSString *zxTitleStr = [infoData objectForKey:@"DecCommunity"];
    CGSize contentSize = [zxTitleStr sizeWithFont:contentFont constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    [zxTitleLab setFont:contentFont];
    [zxTitleLab setFrame:CGRectMake(65*ScreenWidth/320, 10*ScreenHeight/568, contentSize.width, 20*ScreenHeight/568)];
    [zxTitleLab setText:zxTitleStr];
    //日记篇数
    [zxNumLab setText:@"(5篇)"];
    [zxNumLab setFrame:CGRectMake(zxTitleLab.frame.size.width + zxTitleLab.frame.origin.x+5, zxTitleLab.frame.origin.y, 40*ScreenWidth/320, 20*ScreenHeight/568)];
    //收藏数量
    [zxCollectionLab setText:[NSString stringWithFormat:@"%@",[infoData objectForKey:@"CollCount"]]];
    //信息数量
    //    [messageNumLab setText:[NSString stringWithFormat:@"%@",[infoData objectForKey:@"ShareCount"]]];
    //查看次数
    [seenNumLab setText:[NSString stringWithFormat:@"%@",[infoData objectForKey:@"ShareCount"]]];
    //装修工程信息
    [decInfoLab setText:[NSString stringWithFormat:@"%@ | %@㎡ | %@ | %@",[infoData objectForKey:@"DecCommunity"],[infoData objectForKey:@"DecArea"],[infoData objectForKey:@"DecPrice"],[infoData objectForKey:@"DecLabel"]]];
    
    NSArray *ADpicStrArray = [[infoData objectForKey:@"PICPATH"] componentsSeparatedByString:@"|"];
    
    [self setPicture:ADpicStrArray];
    
    //日记内容
    [diaryContentLab setText:[infoData objectForKey:@"DecDiary"]];
    CGSize boundSize = CGSizeMake(255*ScreenWidth/320, CGFLOAT_MAX);
    diaryContentLab.numberOfLines = 0;
    //    CGSize requiredSize = [diaryContentLab.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:boundSize lineBreakMode:NSLineBreakByWordWrapping];
    CGSize requiredSize = [diaryContentLab.text boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]} context:nil].size;
    [diaryContentLab setFrame:CGRectMake(65*ScreenWidth/320, self.cellHeight, 255*ScreenWidth/320, requiredSize.height)];
    self.cellHeight += requiredSize.height;
    
    //日记时间
    [diaryTimeLab setText:[infoData objectForKey:@"DecDiaryDateTime"]];
    [diaryTimeLab setFrame:CGRectMake(65*ScreenWidth/320, self.cellHeight, 255*ScreenWidth/320, 20*ScreenHeight/568)];
    
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
        self.cellHeight = 55*ScreenHeight/568;
    }else
    {
        [imgScrollView setHidden:NO];
        self.cellHeight = 125*ScreenHeight/568;
    }
    
    for (int i = 0; i<[imgNameArr count]; i++) {
        UIImageView *pictureImgV = [[UIImageView alloc] initWithFrame:CGRectMake(i *80*ScreenWidth/320, 0, 75*ScreenHeight/568, 75*ScreenHeight/568)];
        [pictureImgV sd_setImageWithURL:[NSURL URLWithString:[imgNameArr objectAtIndex:i]] placeholderImage:LoadImage(@"zxDiary@2x", @"jpg")];
        [imgScrollView addSubview:pictureImgV];
    }
}


- (void)setZXRJ_CellDisplay:(BOOL) cellHidden {
    [headImgV setHidden:cellHidden];
    [zxCollImgView setHidden:cellHidden];
    [seenNumImgView setHidden:cellHidden];
    [zxStateLab setHidden:cellHidden];
    [zxTitleLab setHidden:cellHidden];
    [zxNumLab setHidden:cellHidden];
    [zxCollectionLab setHidden:cellHidden];
    [seenNumLab setHidden:cellHidden];
    [decInfoLab setHidden:cellHidden];
    [diaryContentLab setHidden:cellHidden];
    [diaryTimeLab setHidden:cellHidden];
    [imgScrollView setHidden:cellHidden];
    /*
    [userHeadImgV setHidden:cellHidden];
    [titleLab setHidden:cellHidden];
    [addressLab setHidden:cellHidden];
    [statusLab setHidden:cellHidden];
    [startImgView setHidden:cellHidden];
    [commentImgView setHidden:cellHidden];
    [lookImgView setHidden:cellHidden];
    [numLab setHidden:cellHidden];
    [commentNumLab setHidden:cellHidden];
    [lookNumLab setHidden:cellHidden];
    [effectImgV_1 setHidden:cellHidden];
    [effectImgV_2 setHidden:cellHidden];
    [effectImgV_3 setHidden:cellHidden];
    [timeLab setHidden:cellHidden];
    [infoLab setHidden:cellHidden];
     */
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
