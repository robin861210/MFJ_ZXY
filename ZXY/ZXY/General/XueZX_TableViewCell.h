//
//  XueZX_TableViewCell.h
//  ZXY
//
//  Created by acewill on 15/6/28.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface XueZX_TableViewCell : UITableViewCell
{
    //学装修-知识库
    UIImageView *imageView;
    UILabel *ZSK_titleLab, *hotReadLab;
    UILabel *ZSK_timeLab;
    UILabel *readCountLab;
    UIView *ZSK_lineV;
    
    //学装修-装修日记
    UIImageView *userHeadImgV;
    UILabel *titleLab, *addressLab, *statusLab;
    
    UIImageView *startImgView, *commentImgView, *lookImgView;
    UILabel *numLab, *commentNumLab, *lookNumLab;
    
    UIImageView *effectImgV_1, *effectImgV_2, *effectImgV_3;
    UILabel *timeLab,*infoLab;
    UIView *lineV;
    NSMutableArray *effectImgArray;
    
}
- (void)setZSK_CellDisplay:(BOOL) cellHidden;
- (void)setZXRJ_CellDisplay:(BOOL) cellHidden;

//学装修-知识库
- (void)create_ZSK_TableCell;
@property (nonatomic, assign)BOOL RecommendFlag;
- (void)setCellImageView:(NSString *)imgUrlStr;
- (void)setCellTitleInfo:(NSString *)titleInfoStr;
- (void)setCellHotReadType:(BOOL)hotReadType;
- (void)setCellTimeInfo:(NSString *)timeInfoStr;
- (void)setCellReadCount:(NSString *)readCountStr;

//学装修-装修日记
- (void)create_ZXRJ_TableCell;


@end
