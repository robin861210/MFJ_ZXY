//
//  HomeViewTableViewCell.h
//  ZXY
//
//  Created by acewill on 15/7/5.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface HomeViewTableViewCell : UITableViewCell
{
    UIView *lineV;
    UIImageView *iconImgV;
    float cellHeight;
    
    //知识库
    UIView *zskView;
    UILabel *zsk_titleLab;
    UILabel *zsk_InfoLab;
    //提醒数据
    UIView *txsjView;
    UILabel *txsj_titleLab;
    UILabel *txsj_InfoLab;
    //效果图
    UIView *xgtView;
    UILabel *xgt_titleLab;
    UILabel *xgt_stateLab;
    UILabel *xgt_uploadTimeLab;
    //装修日记
    UIView *zxrjView;
    UILabel *zxrj_titleLab;
    UILabel *zxrj_InfoLab;
    UIImageView *zxrj_ImgView;
    //看装修
    UIView *kzxView;
    UILabel *kzx_titleLab;
    UILabel *kzx_InfoLab;
    UIImageView *kzx_ImgView;
    //进度数据
    UIView *jdsjView;
    UILabel *jdsj_titleLab;
    UILabel *jdsj_stateLab;
    UILabel *jdsj_uploadTimeLab;
    UILabel *jdsj_InfoLab;
    UIImageView *jdsj_ImgView0, *jdsj_ImgView1, *jdsj_ImgView2;
    //阶段性报告
    UIView *jdbgView;
    UILabel *jdbg_titleLab;
    UILabel *jdbg_stateLab;
    UILabel *jdbg_uploadTimeLab;
    UILabel *jdbg_InfoLab;
    
    
}
//清理数据界面
- (void)clearInfoViewData;
//首页知识库单元格
- (void)setHome_ZSK_Cell:(NSMutableDictionary *)zskCellDic;
//首页提醒单元格
- (void)setHome_TXSJ_Cell:(NSMutableDictionary *)txsjCellDic;
//首页效果图单元格
- (void)setHome_XGT_Cell:(NSMutableDictionary *)xgtCellDic;
//首页装修日记单元格
- (void)setHome_ZXRJ_Cell:(NSMutableDictionary *)zxrjCellDic;
//首页看装修单元格
- (void)setHome_KZX_Cell:(NSMutableDictionary *)kzxCellDic;
//首页装修进度数据单元格
- (void)setHome_JDSJ_Cell:(NSMutableDictionary *)jdsjCellDic;
//首页阶段性进度报告单元格
- (void)setHome_JDBG_Cell:(NSMutableDictionary *)jdbgCellDic;

@end
