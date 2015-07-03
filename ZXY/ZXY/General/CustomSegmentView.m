//
//  CustomSegmentView.m
//  ZXY
//
//  Created by acewill on 15/6/23.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "CustomSegmentView.h"

@implementation CustomSegmentView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        firstBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)];
        [firstBt setBackgroundColor:[UIColor clearColor]];
        [firstBt setTag:33];
        [firstBt addTarget:self action:@selector(functionBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:firstBt];
        
        secondBt = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2   , 0, self.frame.size.width/2, self.frame.size.height)];
        [secondBt setBackgroundColor:[UIColor clearColor]];
        [secondBt setTag:35];
        [secondBt addTarget:self action:@selector(functionBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:secondBt];
        
        selectTag = 33;
    }
    return self;
}

- (void)setSegmentReset {
    [self functionBtClicked:firstBt];
}

- (IBAction)functionBtClicked:(id)sender {
    UIButton *tmpBt = (UIButton *)sender;
    
    if (tmpBt.tag != selectTag) {
        switch (tmpBt.tag) {
            case 33:
                [firstBt setBackgroundImage:LoadImage(firstSel, @"png") forState:UIControlStateNormal];
                [secondBt setBackgroundImage:LoadImage(secondNor, @"png") forState:UIControlStateNormal];
                break;
            case 35:
                [firstBt setBackgroundImage:LoadImage(firstNor, @"png") forState:UIControlStateNormal];
                [secondBt setBackgroundImage:LoadImage(secondSel, @"png") forState:UIControlStateNormal];
                
                break;
            default:
                break;
        }
        selectTag = (int)tmpBt.tag;
        if ([_delegate respondsToSelector:@selector(segmentSelectItem:SegmentType:)]) {
            [_delegate segmentSelectItem:selectTag SegmentType:customType];
        }
    }
}

- (void)setSegmentSelectImgStrArray:(NSArray *)selectStrArray
                 NormailImgStrArray:(NSArray *)normailStrArray
                        SegmentType:(int)segmentType
{
    firstSel = [selectStrArray objectAtIndex:0];
    secondSel = [selectStrArray objectAtIndex:1];
    
    firstNor = [normailStrArray objectAtIndex:0];
    secondNor = [normailStrArray objectAtIndex:1];
    
    [firstBt setBackgroundImage:LoadImage(firstSel, @"png") forState:UIControlStateNormal];
    [secondBt setBackgroundImage:LoadImage(secondNor, @"png") forState:UIControlStateNormal];
    
    selectTag = 33;
    customType = segmentType;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
