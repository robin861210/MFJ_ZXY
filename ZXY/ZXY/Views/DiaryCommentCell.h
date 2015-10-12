//
//  DiaryCommentCell.h
//  ashdaksjh
//
//  Created by soldier on 15/10/9.
//  Copyright © 2015年 AA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MJWebCache.h"

@interface DiaryCommentCell : UITableViewCell
{
    UIImageView *headImgView;                 //用户头像
    UILabel       *userNameLabel,               //用户名
                    *dateLabel,                     //评论日期
                    *commentsContentLabel;      //评论内容
}

@property (nonatomic, assign) float cellHeight;

- (void)updateDiaryCommentCellInfo:(NSDictionary *)diaryCommentDic;

@end
