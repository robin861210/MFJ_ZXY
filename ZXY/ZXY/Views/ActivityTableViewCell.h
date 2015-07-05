//
//  ActivityTableViewCell.h
//  ZXY
//
//  Created by soldier on 15/6/20.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@interface ActivityTableViewCell : UITableViewCell <CWStarRateViewDelegate>
{
    UIImageView *imgView;         //活动图片
    UILabel   *titleLabel,           //活动标题
                *timeLabel,           //活动时间
                *applyLabel,          //报名人数
                *addressLabel;       //活动地址
    NSString *activeID;             //活动id
    
}

- (void)updateActiveCellData:(NSDictionary *)infoDic;

@end
