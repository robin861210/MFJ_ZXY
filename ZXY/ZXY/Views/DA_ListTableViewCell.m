//
//  DA_ListTableViewCell.m
//  ZXYY
//
//  Created by acewill on 15-4-5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "DA_ListTableViewCell.h"

@implementation DA_ListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 0; i < 4; i++) {
            UILabel *itemLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
            [itemLab setFont:[UIFont systemFontOfSize:10.0f]];
            [itemLab setTextAlignment:NSTextAlignmentCenter];
            [itemLab setTag:100+i];
            [self addSubview:itemLab];
        }
    }
    
    return self;
}

- (void)createBudgetInfo:(NSDictionary *) dicInfo {
    for (int i= 0; i < 4; i++) {
        [(UILabel *)[self viewWithTag:(100+i)] setFrame:CGRectMake(ScreenWidth/3*i, 10, ScreenWidth/3, 20)];
    }
    if ([[dicInfo objectForKey:@"titleInfo"] intValue]) {
        [(UILabel *)[self viewWithTag:100] setText:@"项目名称"];
        [(UILabel *)[self viewWithTag:101] setText:@"单位"];
        [(UILabel *)[self viewWithTag:102] setText:@"数量"];
        [self setBackgroundColor:UIColorFromHex(0xd2d2d2)];
    }else {
        [(UILabel *)[self viewWithTag:100] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"ItemName"]]];
        [(UILabel *)[self viewWithTag:101] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"Unit"]]];
        [(UILabel *)[self viewWithTag:102] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"Number"]]];
        [self setBackgroundColor:UIColorFromHex(0xeeeeee)];
    }
    [self addLineView];
}

- (void)createChangeInfo:(NSDictionary *) dicInfo {
    for (int i= 0; i < 4; i++) {
        [(UILabel *)[self viewWithTag:(100+i)] setFrame:CGRectMake(ScreenWidth/4*i, 10, ScreenWidth/4, 20)];
    }
    if ([[dicInfo objectForKey:@"titleInfo"] intValue]) {
        //加减项
        [(UILabel *)[self viewWithTag:100] setText:@"增减"];
        //项目名称
        [(UILabel *)[self viewWithTag:101] setText:@"项目名称"];
        [(UILabel *)[self viewWithTag:102] setText:@"单位"];
        [(UILabel *)[self viewWithTag:103] setText:@"数量"];
//        [(UILabel *)[self viewWithTag:104] setText:@"单价"];
//        [(UILabel *)[self viewWithTag:105] setText:@"合计"];
        [self setBackgroundColor:UIColorFromHex(0xd2d2d2)];
    }else {
        //加减项
        if ([[dicInfo objectForKey:@"AddFlag"] intValue] == 1)
            [(UILabel *)[self viewWithTag:100] setText:@"增项"];
        else
            [(UILabel *)[self viewWithTag:100] setText:@"减项"];
        //项目名称
        [(UILabel *)[self viewWithTag:101] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"ItemName"]]];
        [(UILabel *)[self viewWithTag:102] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"Unit"]]];
        [(UILabel *)[self viewWithTag:103] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"Number"]]];
//        [(UILabel *)[self viewWithTag:104] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"ITEMUNITPRICE"]]];
//        [(UILabel *)[self viewWithTag:105] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"ITEMTOTALPRICE"]]];
        [self setBackgroundColor:UIColorFromHex(0xeeeeee)];
    }
    [self addLineView];
}

- (void)createPaymentInfo:(NSDictionary *) dicInfo {
    for (int i= 0; i < 4; i++) {
        [(UILabel *)[self viewWithTag:(100+i)] setFrame:CGRectMake(ScreenWidth/3*i, 10, ScreenWidth/3, 20)];
    }
    if ([[dicInfo objectForKey:@"titleInfo"] intValue]) {
        [(UILabel *)[self viewWithTag:100] setText:@"类型名称"];
        [(UILabel *)[self viewWithTag:101] setText:@"付款方式"];
        [(UILabel *)[self viewWithTag:102] setText:@"金额"];
        [self setBackgroundColor:UIColorFromHex(0xd2d2d2)];
    }else {
        [(UILabel *)[self viewWithTag:100] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"PTNAME"]]];
        [(UILabel *)[self viewWithTag:101] setText:[NSString stringWithFormat:@"%@",[dicInfo objectForKey:@"PMNAME"]]];
        [(UILabel *)[self viewWithTag:102] setText:[NSString stringWithFormat:@"%d",(int)[[dicInfo objectForKey:@"AMOUNT"] intValue]/100]];
        [self setBackgroundColor:UIColorFromHex(0xeeeeee)];
    }
    [self addLineView];
}

- (void)addLineView {
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 39, ScreenWidth, 0.5)];
    [lineV setBackgroundColor:[UIColor grayColor]];
    [self addSubview:lineV];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
