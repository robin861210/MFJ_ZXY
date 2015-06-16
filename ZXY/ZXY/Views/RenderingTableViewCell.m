//
//  RenderingTableViewCell.m
//  ZXYY
//
//  Created by hndf on 15/5/6.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "RenderingTableViewCell.h"

@implementation RenderingTableViewCell
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        imgBt0 = [[UIButton alloc] initWithFrame:CGRectMake(5*ScreenWidth/320, 20*ScreenHeight/568, 100*ScreenWidth/320, 80*ScreenHeight/568)];
        [imgBt0 setBackgroundColor:[UIColor clearColor]];
        imgBt0.layer.borderColor = [[UIColor grayColor] CGColor];
        imgBt0.layer.borderWidth = 0.3f;
        imgBt0.layer.masksToBounds = YES;
        imgBt0.layer.cornerRadius = 8.0f;
        [imgBt0 addTarget:self action:@selector(imgBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imgBt0];
        
        imgBt1 = [[UIButton alloc] initWithFrame:CGRectMake(110*ScreenWidth/320, 20*ScreenHeight/568, 100*ScreenWidth/320, 80*ScreenHeight/568)];
        [imgBt1 setBackgroundColor:[UIColor clearColor]];
        imgBt1.layer.borderWidth = 0.3f;
        imgBt1.layer.masksToBounds = YES;
        imgBt1.layer.cornerRadius = 8.0f;
        [imgBt1 addTarget:self action:@selector(imgBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imgBt1];
        
        imgBt2 = [[UIButton alloc] initWithFrame:CGRectMake(215*ScreenWidth/320, 20*ScreenHeight/568, 100*ScreenWidth/320, 80*ScreenHeight/568)];
        [imgBt2 setBackgroundColor:[UIColor clearColor]];
        imgBt2.layer.borderWidth = 0.3f;
        imgBt2.layer.masksToBounds = YES;
        imgBt2.layer.cornerRadius = 8.0f;
        [imgBt2 addTarget:self action:@selector(imgBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imgBt2];
        
        imgBtArray = [[NSMutableArray alloc] init];
        [imgBtArray addObject:imgBt0];
        [imgBtArray addObject:imgBt1];
        [imgBtArray addObject:imgBt2];
        indexNum = 0;
        
    }
    
    return self;
}

- (void)setImageUrlInfo:(NSArray *)imageUrlArray CellIndex:(NSInteger) cellIndex {
    
    for (int i= 0; i < imageUrlArray.count; i++) {
        [(UIButton *)[imgBtArray objectAtIndex:i] sd_setBackgroundImageWithURL:[NSURL URLWithString:[[imageUrlArray objectAtIndex:i] objectForKey:@"PicUrl"]] forState:UIControlStateNormal placeholderImage:LoadImage(@"placeholder@2x", @"jpg")];
        
        [(UIButton *)[imgBtArray objectAtIndex:i] setTag:(cellIndex * 3+i)];
    }
}

- (IBAction)imgBtClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(selectRenderingCellButtonTag:)]) {
        [_delegate selectRenderingCellButtonTag:[(UIButton *)sender tag]];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
