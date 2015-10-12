//
//  DiaryCommentsViewController.h
//  ZXY
//
//  Created by soldier on 15/9/29.
//  Copyright © 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryCommentCell.h"
#import "UIImageView+MJWebCache.h"

@interface DiaryCommentsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *diaryCommentTableV;
    UIView *tableHeadView;
    NSMutableArray *diaryCommentsArray;

    UIView *commentsInputView ;       //评论输入
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
}

@property (nonatomic, strong) NSMutableDictionary *diaryDetailDic;

@end
