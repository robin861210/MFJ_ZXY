//
//  DiaryTableViewCell.h
//  ZXY
//
//  Created by soldier on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MJWebCache.h"

@interface DiaryTableViewCell : UITableViewCell <UIScrollViewDelegate>
{
    UIImageView *headImgV;          //头像
    UILabel   *zxStateLab,            //装修状态
                *zxTitleLab,             //日记名称
                *zxNumLab,              //日记篇数
                *zxCollectionLab,        //收藏数量
//                *messageNumLab,       //信息数量
                *seenNumLab,           //查看次数
//                *zxNameLab,            //项目名称
//                *zxAreaLab,             //装修面积
//                *zxPriceLab,             //装修价格
//                *zxStyleLab,             //装修类型（全包、半包）
                *decInfoLab,             //装修工程信息
                *diaryContentLab,       //日记内容
                *diaryTimeLab;          //日记时间
    //图片
    UIScrollView *imgScrollView;

}

@property (nonatomic, strong) UILabel *diaryContentLab;      //日记内容
@property (nonatomic, assign) float cellHeight;


- (void)updateDiaryCellInfoData:(NSDictionary *)infoData;

@end
