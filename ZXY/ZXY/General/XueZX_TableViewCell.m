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
//    UIImageView *startImgView, *commentImgView, *lookImgView;
//    UILabel *numLab, *commentNumLab, *lookNumLab;
    
//    UILabel *timeLab,*infoLab;

    userHeadImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [userHeadImgV setBackgroundColor:[UIColor clearColor]];
    [userHeadImgV setImage:LoadImage(@"head", @"jpg")];
    [userHeadImgV.layer setMasksToBounds:YES];
    [userHeadImgV.layer setCornerRadius:25.0f];
    [self addSubview:userHeadImgV];
    
    statusLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 50, 30)];
    [statusLab setBackgroundColor:[UIColor clearColor]];
    [statusLab.layer setBorderWidth:3.0f];
    [statusLab.layer setBorderColor:[UIColor greenColor].CGColor];
    [statusLab.layer setCornerRadius:3.0f];
    [statusLab setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [statusLab setTextAlignment:NSTextAlignmentCenter];
    [statusLab setText:@"装修完"];
    [self addSubview:statusLab];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, ScreenWidth-185, 20)];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [titleLab setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [titleLab setText:@"装修易在线工地（3篇）"];
    [self addSubview:titleLab];
    
    addressLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, ScreenWidth-185,15)];
    [addressLab setBackgroundColor:[UIColor clearColor]];
    [addressLab setFont:[UIFont systemFontOfSize:11.0f]];
    [addressLab setTextColor:[UIColor grayColor]];
    [addressLab setText:@"万科家园 | 120m | 10~15万 | 全包"];
    [self addSubview:addressLab];
    
    effectImgV_1 = [[UIImageView alloc] init];
    effectImgV_2 = [[UIImageView alloc] init];
    effectImgV_3 = [[UIImageView alloc] init];
    effectImgArray = [[NSMutableArray alloc] initWithObjects:effectImgV_1, effectImgV_2, effectImgV_3, nil];
    for (int i = 0;  i < 3; i++) {
        UIImageView *imgView = (UIImageView *)[effectImgArray objectAtIndex:i];
        [imgView setFrame:CGRectMake(80+i*80*(ScreenWidth/320), 50, 75*(ScreenWidth/320), 75*(ScreenWidth/320))];
        [imgView setBackgroundColor:[UIColor clearColor]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img3.3lian.com/2013/v9/96/82.jpg"] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
        [self addSubview:imgView];
    }
    
    infoLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 140, ScreenWidth-98, 100)];
    [infoLab setBackgroundColor:[UIColor clearColor]];
    [infoLab setNumberOfLines:0];
    [infoLab setLineBreakMode:NSLineBreakByWordWrapping];
    [infoLab setFont:[UIFont systemFontOfSize:12.0f]];
    [infoLab setText:@"文体名。凡是不押韵、不重排偶的散体文章，概称散文。随着文学概念的演变和文学体裁的发展，散文的概念也时有变化,在默写历史时期又将小说与其他抒情、记事的文学作品统称为散文，以区别于讲求韵律的诗歌。现代散文是指小说、诗歌、戏剧等文学体裁之外的其他文学作品。"];
    [self addSubview:infoLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 240, ScreenWidth-98, 20)];
    [timeLab setBackgroundColor:[UIColor clearColor]];
    [timeLab setFont:[UIFont systemFontOfSize:11.0f]];
    [timeLab setTextColor:[UIColor grayColor]];
    [timeLab setText:@"2015-06-25 21:30:33"];
    [self addSubview:timeLab];
    
    lookImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-45, 5, 20, 20)];
    [lookImgView setBackgroundColor:[UIColor clearColor]];
    [lookImgView setImage:LoadImage(@"kanZX_look@2x", @"png")];
    [self addSubview:lookImgView];
    lookNumLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-25, 5, 25, 20)];
    [lookNumLab setBackgroundColor:[UIColor clearColor]];
    [lookNumLab setTextColor:[UIColor grayColor]];
    [lookNumLab setFont:[UIFont systemFontOfSize:10.0f]];
    [lookNumLab setText:@"9999"];
    [self addSubview:lookNumLab];
    
    commentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-85, 5, 20, 20)];
    [commentImgView setBackgroundColor:[UIColor clearColor]];
    [commentImgView setImage:LoadImage(@"kanZX_comment@2x", @"png")];
    [self addSubview:commentImgView];
    commentNumLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-67, 5, 25, 20)];
    [commentNumLab setBackgroundColor:[UIColor clearColor]];
    [commentNumLab setTextColor:[UIColor grayColor]];
    [commentNumLab setFont:[UIFont systemFontOfSize:10.0f]];
    [commentNumLab setText:@"9999"];
    [self addSubview:commentNumLab];
    
    startImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-123, 5, 20, 20)];
    [startImgView setBackgroundColor:[UIColor clearColor]];
    [startImgView setImage:LoadImage(@"kanZX_start@2x", @"png")];
    [self addSubview:startImgView];
    numLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-106, 5, 25, 20)];
    [numLab setBackgroundColor:[UIColor clearColor]];
    [numLab setTextColor:[UIColor grayColor]];
    [numLab setFont:[UIFont systemFontOfSize:10.0f]];
    [numLab setText:@"9999"];
    [self addSubview:numLab];

}

- (void)setZXRJ_CellDisplay:(BOOL) cellHidden {
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
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
