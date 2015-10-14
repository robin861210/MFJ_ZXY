//
//  DiaryDetailTableViewCell.h
//  ZXY
//
//  Created by soldier on 15/9/29.
//  Copyright © 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MJWebCache.h"

@interface DiaryDetailTableViewCell : UITableViewCell <UIScrollViewDelegate>
{
    UILabel *titleLabel,            //日记标题
            *dateLabel,              //日记日期
            *diaryContentLab,       //日记内容
            *zxStateLab,            //装修状态
            *zxCollectionNum,       //收藏数量
            *zxCommentsNum;      //评论数量

    UIButton *collectionBtn,        //收藏按钮
                *commentsBtn;       //评论按钮
    
    UIScrollView *imgScrollView;    //图片
    UIView *goodAndMessView;

}

@property (nonatomic, strong) UILabel *diaryContentLab;      //日记内容
@property (nonatomic, assign) float cellHeight;
@property (nonatomic ,strong) UILabel *zxStateLab;            //装修状态


- (void)updateDiaryDetailCellInfoData:(NSDictionary *)infoData;

@end
