//
//  KanZXView.h
//  ZXY
//
//  Created by acewill on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KanZXTableViewCell.h"

@interface KanZXView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *kanZX_TableV;
    NSMutableArray *tableViewArray;
    
    int dataInfoType;
}

- (void)transfromKanZX_Info:(int)typeNum;

@end
