//
//  HomeViewTableViewCell.m
//  ZXY
//
//  Created by acewill on 15/7/5.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "HomeViewTableViewCell.h"

@implementation HomeViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        lineV = [[UIView alloc] init];
        [lineV setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        [self addSubview:lineV];
        
        iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 45, 45)];
        [iconImgV setBackgroundColor:[UIColor clearColor]];
        [self addSubview:iconImgV];
        
        [self createHome_ZSK_Cell];
        [self createHome_ZXRJ_Cell];
        [self createHome_XGT_Cell];
        [self createHome_TXSJ_Cell];
        [self createHome_KZX_Cell];
        [self createHome_JDSJ_Cell];
        [self createHome_JDBG_Cell];
        
    }
    return self;
}

- (void)setAllCellHidden {
    [zskView setHidden:YES];
    [zxrjView setHidden:YES];
    [xgtView setHidden:YES];
    [txsjView setHidden:YES];
    [kzxView setHidden:YES];
    [jdsjView setHidden:YES];
    [jdbgView setHidden:YES];
}

//创建知识库Cell
- (void)createHome_ZSK_Cell {
    zskView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-60, 200)];
    //知识库标题
    zsk_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, zskView.frame.size.width, 20)];
    [zsk_titleLab setFont:[UIFont boldSystemFontOfSize:15]];
    //知识库内容
    zsk_InfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, zskView.frame.size.width, 170)];
    [zsk_InfoLab setFont:[UIFont systemFontOfSize:13.0f]];
    [zsk_InfoLab setTextColor:[UIColor grayColor]];
    [zsk_InfoLab setLineBreakMode:NSLineBreakByWordWrapping];
    [zsk_InfoLab setNumberOfLines:0];
    //添加到页面
    [zskView addSubview:zsk_titleLab];
    [zskView addSubview:zsk_InfoLab];
    [self addSubview:zskView];
}
//主页当中的 知识库 单元格
- (void)setHome_ZSK_Cell:(NSMutableDictionary *)zskCellDic
{
    [self setAllCellHidden];
    [zskView setHidden:NO];
    
    [iconImgV setImage:LoadImage(@"home_ZSKcell@2x", @"png")];
    [lineV setFrame:CGRectMake(25, 0, 2, 200)];
    //知识库标题
    [zsk_titleLab setText:[NSString stringWithFormat:@"%@",[zskCellDic objectForKey:@"NodeTitle"]]];
    //知识库内容
    [zsk_InfoLab setText:[NSString stringWithFormat:@"%@",[zskCellDic objectForKey:@"NodeText"]]];
}



//创建提醒数据
- (void)createHome_TXSJ_Cell {
    txsjView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-60, 100)];
    [self addSubview:txsjView];
    //提醒标题
    txsj_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, txsjView.frame.size.width-80, 20)];
    [txsj_titleLab setFont:[UIFont boldSystemFontOfSize:15]];
    [txsjView addSubview:txsj_titleLab];
    //提醒内容
    txsj_InfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, txsjView.frame.size.width, 70)];
    [txsj_InfoLab setFont:[UIFont systemFontOfSize:13.0f]];
    [txsj_InfoLab setTextColor:[UIColor grayColor]];
    [txsj_InfoLab setLineBreakMode:NSLineBreakByWordWrapping];
    [txsj_InfoLab setNumberOfLines:0];
    [txsjView addSubview:txsj_InfoLab];

}
//主页当中的 提醒数据 单元格
- (void)setHome_TXSJ_Cell:(NSMutableDictionary *)txsjCellDic
{
    [self setAllCellHidden];
    [txsjView setHidden:NO];
    
    [iconImgV setImage:LoadImage(@"home_TXSJcell@2x", @"png")];
    [lineV setFrame:CGRectMake(25, 0, 2, 100)];
    //提醒标题
    [txsj_titleLab setText:[NSString stringWithFormat:@"%@",[txsjCellDic objectForKey:@"NodeTitle"]]];
    //提醒内容
    [txsj_InfoLab setText:[NSString stringWithFormat:@"%@",[txsjCellDic objectForKey:@"NodeText"]]];
}



//创建效果图
- (void)createHome_XGT_Cell {
    xgtView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-60, 310)];
    [self addSubview:xgtView];
    //效果图标题
    xgt_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 60, 20)];
    [xgt_titleLab setFont:[UIFont boldSystemFontOfSize:15]];
    [xgtView addSubview:xgt_titleLab];
    //已上传
    xgt_stateLab = [[UILabel alloc] initWithFrame:CGRectMake(65, 12, 60, 16)];
    [xgt_stateLab setBackgroundColor:[UIColor clearColor]];
    [xgt_stateLab setFont:[UIFont systemFontOfSize:12.0f]];
    [xgt_stateLab setTextAlignment:NSTextAlignmentCenter];
    [xgt_stateLab.layer setCornerRadius:8.0f];
    [xgt_stateLab.layer setBorderWidth:2.0f];
    [xgt_stateLab.layer setBorderColor:[UIColor greenColor].CGColor];
    [xgt_stateLab setTextColor:[UIColor greenColor]];
    [xgtView addSubview:xgt_stateLab];
    //上传时间
    xgt_uploadTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(xgtView.frame.size.width-150, 15, 150, 15)];
    [xgt_uploadTimeLab setFont:[UIFont systemFontOfSize:11.0f]];
    [xgt_uploadTimeLab setTextAlignment:NSTextAlignmentRight];
    [xgtView addSubview:xgt_uploadTimeLab];
    
}
//主页当中的 效果图 单元格
- (void)setHome_XGT_Cell:(NSMutableDictionary *)xgtCellDic
{
    [self setAllCellHidden];
    [xgtView setHidden:NO];
    
    [iconImgV setImage:LoadImage(@"home_XGTcell@2x", @"png")];
    [lineV setFrame:CGRectMake(25, 0, 2, 310)];
    //效果图标题
    [xgt_titleLab setText:[NSString stringWithFormat:@"%@",[xgtCellDic objectForKey:@"NodeTitle"]]];
    //已上传
    [xgt_stateLab setText:@"已上传"];
    //上传时间
    [xgt_uploadTimeLab setText:[NSString stringWithFormat:@"上传时间:%@",[xgtCellDic objectForKey:@"NodeTime"]]];
    //图片显示
    NSString *picUrl = [xgtCellDic objectForKey:@"NodePicPath"];
    NSString *picStr = [xgtCellDic objectForKey:@"NodePic"];
    NSArray *picStrArray = [picStr componentsSeparatedByString:@"|"];
    
    for (int i = 0; i < [picStrArray count]; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(90*(i/3), 38+90*(i%3), 85, 85)];
        [imgV setBackgroundColor:[UIColor clearColor]];
        [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picUrl,[picStrArray objectAtIndex:i]]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
        [xgtView addSubview:imgV];
    }
}



//创建装修日记
- (void)createHome_ZXRJ_Cell {
    zxrjView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-60, 260)];
    [self addSubview:zxrjView];
    //装修日记标题
    zxrj_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, zxrjView.frame.size.width-80, 20)];
    [zxrj_titleLab setFont:[UIFont boldSystemFontOfSize:15]];
    [zxrjView addSubview:zxrj_titleLab];
    //装修日记内容
    zxrj_InfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, zxrjView.frame.size.width, 50)];
    [zxrj_InfoLab setFont:[UIFont systemFontOfSize:13.0f]];
    [zxrj_InfoLab setTextColor:[UIColor grayColor]];
    [zxrj_InfoLab setLineBreakMode:NSLineBreakByWordWrapping];
    [zxrj_InfoLab setNumberOfLines:0];
    [zxrjView addSubview:zxrj_InfoLab];
    //装修日记配图
    zxrj_ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 85, zxrjView.frame.size.width, 170)];
    [zxrj_ImgView setBackgroundColor:[UIColor clearColor]];
    [zxrjView addSubview:zxrj_ImgView];
    
}
//主页当中的 装修日记 单元格
- (void)setHome_ZXRJ_Cell:(NSMutableDictionary *)zxrjCellDic
{
    [self setAllCellHidden];
    [zxrjView setHidden:NO];
    
    [iconImgV setImage:LoadImage(@"home_ZXRJcell@2x", @"png")];
    [lineV setFrame:CGRectMake(25, 0, 2, 260)];
    //装修日记标题
    [zxrj_titleLab setText:[NSString stringWithFormat:@"%@",[zxrjCellDic objectForKey:@"NodeTitle"]]];
    //装修日记内容
    [zxrj_InfoLab setText:[NSString stringWithFormat:@"%@",[zxrjCellDic objectForKey:@"NodeText"]]];
    //装修日记配图
    [zxrj_ImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[zxrjCellDic objectForKey:@"NodePicPath"],[zxrjCellDic objectForKey:@"NodePic"]]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
}



//创建看装修
- (void)createHome_KZX_Cell {
    kzxView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-60, 260)];
    [self addSubview:kzxView];
    //看装修标题
    kzx_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kzxView.frame.size.width-80, 20)];
    [kzx_titleLab setFont:[UIFont boldSystemFontOfSize:15]];
    [kzxView addSubview:kzx_titleLab];
    //看装修内容
    kzx_InfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kzxView.frame.size.width, 50)];
    [kzx_InfoLab setFont:[UIFont systemFontOfSize:13.0f]];
    [kzx_InfoLab setTextColor:[UIColor grayColor]];
    [kzx_InfoLab setLineBreakMode:NSLineBreakByWordWrapping];
    [kzx_InfoLab setNumberOfLines:0];
    [kzxView addSubview:kzx_InfoLab];
    //看装修配图
    kzx_ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 85, kzxView.frame.size.width, 170)];
    [kzx_ImgView setBackgroundColor:[UIColor clearColor]];
    [kzxView addSubview:kzx_ImgView];
}
//主页当中的 看装修 单元格
- (void)setHome_KZX_Cell:(NSMutableDictionary *)kzsCellDic
{
    [self setAllCellHidden];
    [kzxView setHidden:NO];
    
    [iconImgV setImage:LoadImage(@"home_KZXcell@2x", @"png")];
    [lineV setFrame:CGRectMake(25, 0, 2, 260)];
    //看装修标题
    [kzx_titleLab setText:[NSString stringWithFormat:@"%@",[kzsCellDic objectForKey:@"NodeTitle"]]];
    //看装修内容
    [kzx_InfoLab setText:[NSString stringWithFormat:@"%@",[kzsCellDic objectForKey:@"NodeText"]]];
    //看装修配图
    [kzx_ImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[kzsCellDic objectForKey:@"NodePicPath"],[kzsCellDic objectForKey:@"NodePic"]]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
}


//创建进度数据
- (void)createHome_JDSJ_Cell {
    jdsjView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-60, 200)];
    [self addSubview:jdsjView];
    //进度数据标题
    jdsj_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
    [jdsj_titleLab setFont:[UIFont boldSystemFontOfSize:15]];
    [jdsjView addSubview:jdsj_titleLab];
    //状态信息
    jdsj_stateLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, 60, 16)];
    [jdsj_stateLab setBackgroundColor:[UIColor clearColor]];
    [jdsj_stateLab setFont:[UIFont systemFontOfSize:12.0f]];
    [jdsj_stateLab setTextAlignment:NSTextAlignmentCenter];
    [jdsj_stateLab.layer setCornerRadius:8.0f];
    [jdsj_stateLab.layer setBorderWidth:2.0f];
    [jdsj_stateLab.layer setBorderColor:[UIColor greenColor].CGColor];
    [jdsj_stateLab setTextColor:[UIColor greenColor]];
    [jdsjView addSubview:jdsj_stateLab];
    //上传时间
    jdsj_uploadTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(jdsjView.frame.size.width-150, 15, 150, 15)];
    [jdsj_uploadTimeLab setFont:[UIFont systemFontOfSize:11.0f]];
    [jdsj_uploadTimeLab setTextAlignment:NSTextAlignmentRight];
    [jdsj_uploadTimeLab setTextColor:[UIColor grayColor]];
    [jdsjView addSubview:jdsj_uploadTimeLab];
    //阶段数据内容
    jdsj_InfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, jdsjView.frame.size.width, 50)];
    [jdsj_InfoLab setFont:[UIFont systemFontOfSize:13.0f]];
    [jdsj_InfoLab setTextColor:[UIColor grayColor]];
    [jdsj_InfoLab setLineBreakMode:NSLineBreakByWordWrapping];
    [jdsj_InfoLab setNumberOfLines:0];
    [jdsjView addSubview:jdsj_InfoLab];
    
}

//首页装修进度数据单元格
- (void)setHome_JDSJ_Cell:(NSMutableDictionary *)jdsjCellDic
{
    [self setAllCellHidden];
    [jdsjView setHidden:NO];
    NSString *imageStr = [self setCellIcon:[[jdsjCellDic objectForKey:@"FlowOrder"] intValue]];
    [iconImgV setImage:LoadImage(imageStr, @"png")];
    [lineV setFrame:CGRectMake(25, 0, 2, 200)];
    //进度数据标题
    [jdsj_titleLab setText:[NSString stringWithFormat:@"%@",[jdsjCellDic objectForKey:@"NodeTitle"]]];
    //状态信息
    [jdsj_stateLab setText:@"施工中"];
    //上传时间
    [jdsj_uploadTimeLab setText:[NSString stringWithFormat:@"上传时间:%@", [jdsjCellDic objectForKey:@"NodeTime"]]];
    //阶段数据内容
    [jdsj_InfoLab setText:[NSString stringWithFormat:@"%@", [jdsjCellDic objectForKey:@"NodeText"]]];
    //图片显示
    NSString *picUrl = [jdsjCellDic objectForKey:@"NodePicPath"];
    NSString *picStr = [jdsjCellDic objectForKey:@"NodePic"];
    NSArray *picStrArray = [picStr componentsSeparatedByString:@"|"];
    
    for (int i = 0; i < [picStrArray count]; i++) {
        if (i < 3) {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((jdsjView.frame.size.width/3)*i, 85, jdsjView.frame.size.width/3-10, jdsjView.frame.size.width/3-10)];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picUrl,[picStrArray objectAtIndex:i]]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
            [jdsjView addSubview:imgV];
        }
    }
}


//创建阶段性进度报告
- (void)createHome_JDBG_Cell {
    jdbgView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-60, 200)];
    [self addSubview:jdbgView];
    //进度数据标题
    jdbg_titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
    [jdbg_titleLab setFont:[UIFont boldSystemFontOfSize:15]];
    [jdbgView addSubview:jdbg_titleLab];
    //状态信息
    jdbg_stateLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, 60, 16)];
    [jdbg_stateLab setBackgroundColor:[UIColor clearColor]];
    [jdbg_stateLab setFont:[UIFont systemFontOfSize:12.0f]];
    [jdbg_stateLab setTextAlignment:NSTextAlignmentCenter];
    [jdbg_stateLab.layer setCornerRadius:8.0f];
    [jdbg_stateLab.layer setBorderWidth:2.0f];
    [jdbg_stateLab.layer setBorderColor:[UIColor greenColor].CGColor];
    [jdbg_stateLab setTextColor:[UIColor greenColor]];
    [jdbgView addSubview:jdbg_stateLab];
    //上传时间
    jdbg_uploadTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(jdbgView.frame.size.width-150, 15, 150, 15)];
    [jdbg_uploadTimeLab setFont:[UIFont systemFontOfSize:11.0f]];
    [jdbg_uploadTimeLab setTextAlignment:NSTextAlignmentRight];
    [jdbg_uploadTimeLab setTextColor:[UIColor grayColor]];
    [jdbgView addSubview:jdbg_uploadTimeLab];
    //阶段数据内容
    jdbg_InfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, jdbgView.frame.size.width, 50)];
    [jdbg_InfoLab setFont:[UIFont systemFontOfSize:13.0f]];
    [jdbg_InfoLab setTextColor:[UIColor grayColor]];
    [jdbg_InfoLab setLineBreakMode:NSLineBreakByWordWrapping];
    [jdbg_InfoLab setNumberOfLines:0];
    [jdbgView addSubview:jdbg_InfoLab];
}
//首页阶段性进度报告单元格
- (void)setHome_JDBG_Cell:(NSMutableDictionary *)jdbgCellDic
{
    [self setAllCellHidden];
    [jdbgView setHidden:NO];
    
    NSString *imageStr = [self setCellIcon:[[jdbgCellDic objectForKey:@"FlowOrder"] intValue]];
    [iconImgV setImage:LoadImage(imageStr, @"png")];
    [lineV setFrame:CGRectMake(25, 0, 2, 200)];
    //阶段报告标题
    [jdbg_titleLab setText:[NSString stringWithFormat:@"%@",[jdbgCellDic objectForKey:@"NodeTitle"]]];
    //阶段状态信息
    [jdbg_stateLab setText:@"施工中"];
    //上传时间
    [jdbg_uploadTimeLab setText:[NSString stringWithFormat:@"上传时间:%@",[jdbgCellDic objectForKey:@"NodeTime"]]];
    //阶段数据内容
    [jdbg_InfoLab setText:[NSString stringWithFormat:@"%@",[jdbgCellDic objectForKey:@"NodeText"]]];
    //图片显示
    NSString *picUrl = [jdbgCellDic objectForKey:@"NodePicPath"];
    NSString *picStr = [jdbgCellDic objectForKey:@"NodePic"];
    NSArray *picStrArray = [picStr componentsSeparatedByString:@"|"];
    
    for (int i = 0; i < [picStrArray count]; i++) {
        if (i < 3) {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((jdsjView.frame.size.width/3)*i, 85, jdsjView.frame.size.width/3-10, jdsjView.frame.size.width/3-10)];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",picUrl,[picStrArray objectAtIndex:i]]] placeholderImage:LoadImage(@"placeholder@2x", @"png")];
            [jdbgView addSubview:imgV];
        }
    }
}

- (NSString *)setCellIcon:(int)cellTag {
    NSLog(@"~~~~~~~~~~~~~~~ cellTag:%d ~~~~~~~~~~~~~~~~",cellTag);
    NSString *imgStr = @"";
    switch (cellTag) {
        case 22:
            imgStr = @"home_ZTJGcell@2x";
            break;
        case 21:
            imgStr = @"home_CPAZcell@2x";
            break;
        case 11:
            imgStr = @"home_DGcell@2x";
            break;
        case 12:
            imgStr = @"home_WGcell@2x";
            break;
        case 13:
            imgStr = @"home_MGcell@2x";
            break;
        case 14:
            imgStr = @"home_YGcell@2x";
            break;
        default:
            imgStr = @"home_ZTJGcell@2x";
            break;
    }
    
    return imgStr;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
