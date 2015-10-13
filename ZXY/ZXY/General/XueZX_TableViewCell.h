//
//  XueZX_TableViewCell.h
//  ZXY
//
//  Created by acewill on 15/6/28.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface XueZX_TableViewCell : UITableViewCell<UIScrollViewDelegate>
{
    //学装修-知识库
    UIImageView *imageView;
    UILabel *ZSK_titleLab, *hotReadLab;
    UILabel *ZSK_timeLab, *ZSK_tagLab;
    UILabel *readCountLab;
    UIView *ZSK_lineV;
    
    //学装修-装修日记
    UIImageView *headImgV;
    UIImageView *zxCollImgView, *seenNumImgView;
    UILabel *zxStateLab, *zxTitleLab, *zxNumLab,
            *zxCollectionLab, *seenNumLab, *decInfoLab,
            *diaryContentLab, *diaryTimeLab;
    
    UIScrollView *imgScrollView;
    
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
- (void)setCellTagInfo:(NSString *)tagInfoStr;
- (void)setCellReadCount:(NSString *)readCountStr;

//学装修-装修日记
@property (nonatomic, assign) float cellHeight;
- (void)create_ZXRJ_TableCell;
- (void)updateDiaryCellInfoData:(NSDictionary *)infoData;


@end
