//
//  KanZXView.m
//  ZXY
//
//  Created by acewill on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "KanZXView.h"

@implementation KanZXView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:RGBACOLOR(234, 235, 237, 1)];
        tableViewArray = [[NSMutableArray alloc] init];
        
        kanZX_TableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        [kanZX_TableV setBackgroundColor:[UIColor clearColor]];
        [kanZX_TableV setDelegate:self];
        [kanZX_TableV setDataSource:self];
        [kanZX_TableV setSeparatorColor:[UIColor clearColor]];
        [self addSubview:kanZX_TableV];
        
        dataInfoType = 33;
        
        NSLog(@"打印这个界面中，中间显示部分的高度：%f",self.frame.size.height);
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"kan_ZX";
    KanZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[KanZXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if (dataInfoType == 33) {
        [cell setKanZX_360AllSDisplay:YES];
        [cell setKanZX_JingXuanDisplayHidden:NO];
    }else {
        [cell setKanZX_JingXuanDisplayHidden:YES];
        [cell setKanZX_360AllSDisplay:NO];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择了，第几个单元格");
}

- (void)transfromKanZX_Info:(int)typeNum
{
    if (typeNum == 33) {
        dataInfoType = 33; //看装修中的精选
        [kanZX_TableV reloadData];
    }
    if (typeNum == 35) {
        dataInfoType = 35; //看装修中的360
        [kanZX_TableV reloadData];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
