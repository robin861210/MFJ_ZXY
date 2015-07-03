//
//  ParallaxHeaderView.h
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"

@protocol ParallaxHeaderViewDelegate <NSObject>

- (void)selectHeaderView:(NSString *)headerTag;

@end

@interface ParallaxHeaderView : UIView
@property (nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (nonatomic) UIImage *headerImage;
@property (nonatomic) NSMutableArray *imgArray;

+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
+ (id)parallaxHeaderViewWithCGSize:(CGSize)headerSize ImageArray:(NSMutableArray *)imgStrArray;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;

@end
