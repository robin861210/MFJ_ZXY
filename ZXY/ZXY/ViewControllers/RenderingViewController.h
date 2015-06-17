//
//  RenderingViewController.h
//  ZXYY
//
//  Created by soldier on 15/4/5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenderingTableViewCell.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface RenderingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,RenderingTableViewCellDelegate>
{
    UITableView *renderTableView;
    NSMutableDictionary *tableDic;
    int photoCount;
    UIImageView *currentImgV;
    
    NSMutableArray *renderingInfoArr;
}

@property (nonatomic, strong)UICollectionView *myCollectionView;
- (void)updateRenderingViewControllerInfo:(NSArray *)updataArray;

@end
