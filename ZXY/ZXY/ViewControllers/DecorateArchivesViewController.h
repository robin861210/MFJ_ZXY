//
//  DecorateArchivesViewController.h
//  ZXY
//
//  Created by soldier on 15/6/15.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DecorateArchivesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *archiviesTableView;
    NSArray *archivTitleArray;          //标题
    
    NetworkInterface *interface;
    MRProgressOverlayView *progressView;
}

@property (nonatomic, assign)int selectType;
@property (nonatomic, strong)NSString *selectTitle;


@end
