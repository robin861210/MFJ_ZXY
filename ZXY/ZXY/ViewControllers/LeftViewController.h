//
//  LeftViewController.h
//  ZXY
//
//  Created by acewill on 15/6/12.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTableV;
    NSArray *listIconArray;
    NSArray *listNameArray;
}


@end
