//
//  CustomSegmentView.h
//  ZXY
//
//  Created by acewill on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSegmentViewDelegate <NSObject>

- (void)segmentSelectItem:(int) selectTag SegmentType:(int)segmentType;

@end

@interface CustomSegmentView : UIView
{
    UIButton *firstBt, *secondBt;
    NSString *firstSel, *firstNor;
    NSString *secondSel, *secondNor;
    int selectTag;
    int customType;
}

- (void)setSegmentReset;

- (void)setSegmentSelectImgStrArray:(NSArray *)selectStrArray
                 NormailImgStrArray:(NSArray *)normailStrArray
                        SegmentType:(int)segmentType;

@property (nonatomic ,strong)id<CustomSegmentViewDelegate>delegate;

@end
