//
//  ActivityDetailViewController.h
//  ZXY
//
//  Created by soldier on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MJWebCache.h"


@interface ActivityDetailViewController : UIViewController <UIWebViewDelegate,UIActionSheetDelegate>
{
    UIImageView *imgV;
    UILabel *titleLab,
    *shopLab,
    *timeLab,
    *phoneLab,
    *peopleLab,
    *limitNumLab;
    UIButton *funBt;
    NSString *activeID;
    NSString *phoneStr; //电话
    
    UIWebView *detailWebV;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
}

- (void)updateACDetailInfo:(NSArray *)infoArray ac_DetailType:(int)ac_Type;

@property (nonatomic, strong)UIImage *shareLogoImg;
@property (nonatomic, strong)NSString *shareActID;
@property (nonatomic, strong)NSString *shareText;
@property (nonatomic, strong)NSString *shareUrl;

@end
