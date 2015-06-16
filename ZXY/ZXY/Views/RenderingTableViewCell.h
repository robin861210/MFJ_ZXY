//
//  RenderingTableViewCell.h
//  ZXYY
//
//  Created by hndf on 15/5/6.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"

@protocol RenderingTableViewCellDelegate <NSObject>

- (void)selectRenderingCellButtonTag:(NSInteger) btTag;

@end

@interface RenderingTableViewCell : UITableViewCell
{
    UIButton *imgBt0, *imgBt1 ,*imgBt2;
    NSMutableArray *imgBtArray;
    NSInteger indexNum;
}

- (void)setImageUrlInfo:(NSArray *)imageUrlArray CellIndex:(NSInteger) cellIndex;

@property (nonatomic, strong)id<RenderingTableViewCellDelegate>delegate;

@end
