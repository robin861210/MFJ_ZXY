//
//  SmartOfferViewController.h
//  ZXY
//
//  Created by soldier on 15/7/4.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartOfferViewController : UIViewController
{
    UILabel   *halfPriceLabel,          //半包报价
                *allPriceLabel;            //全包报价
    float viewHeight;
}

@property (nonatomic ,strong) NSArray *smartOfferArr;

@end
