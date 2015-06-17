//
//  DA_ListTableViewCell.h
//  ZXYY
//
//  Created by acewill on 15-4-5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, listCellType) {
    cellBudget = 0,
    cellChange = 1,
    cellPayment = 2,
};

@interface DA_ListTableViewCell : UITableViewCell

@property (nonatomic, assign)listCellType cellType;

- (void)createBudgetInfo:(NSDictionary *) dicInfo;

- (void)createChangeInfo:(NSDictionary *) dicInfo;

- (void)createPaymentInfo:(NSDictionary *) dicInfo;

@end
