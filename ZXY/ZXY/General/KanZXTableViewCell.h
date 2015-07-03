//
//  KanZXTableViewCell.h
//  ZXY
//
//  Created by acewill on 15/6/26.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface KanZXTableViewCell : UITableViewCell
{
    UIView *bgView;
    //看装修精选部分的效果
    UIImageView *EffectImgView, *perImgView, *startImgView;
    UILabel *nameLab, *roomTypeLab, *readNumLab;
    
    //360全景
    UIImageView *all_EffectImgView, *all_IconImgView;
    UIImageView *all_StartImgView, *all_commentImgView, *all_LookImgView;
    UILabel *all_readNumLab, *all_commentNumLab, *all_LookNumLab;
    UILabel *all_titleLab, *all_roomTitleLab, *all_360Lab;
    
    float cellHeight;
}

- (void)setKanZX_JingXuanDisplayHidden:(BOOL) displayHidden;
- (void)setKanZX_360AllSDisplay:(BOOL) displayHidden;

@end
