//
//  BDXQ_TableViewCell.h
//  ZXYY
//
//  Created by hndf on 15-3-31.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface ZSK_TableViewCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *titleLab, *hotReadLab;
    UILabel *timeLab;
    UILabel *readCountLab;
}
@property (nonatomic, assign)BOOL RecommendFlag;

- (void)setCellImageView:(NSString *)imgUrlStr;

- (void)setCellTitleInfo:(NSString *)titleInfoStr;

- (void)setCellHotReadType:(BOOL)hotReadType;

- (void)setCellTimeInfo:(NSString *)timeInfoStr;

- (void)setCellReadCount:(NSString *)readCountStr;

@end
