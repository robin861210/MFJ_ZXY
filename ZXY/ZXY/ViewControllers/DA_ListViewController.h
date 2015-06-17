//
//  DA_ListViewController.h
//  ZXYY
//
//  Created by acewill on 15-4-5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, listType) {
    budget = 0,
    change = 1,
    payment = 2,
    
};

@interface DA_ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTableView;
    NSMutableArray *selectArray;
    NSMutableArray *titleArray;
}

@property (nonatomic, strong)NSMutableArray *listArray;
@property (nonatomic, assign)listType headType;

- (void)updateDA_ListViewControllerInfo:(NSArray *)updataArray;

@end
