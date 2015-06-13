//
//  ADCustomView.m
//  FrameWorkTest
//
//  Created by hndf on 14-5-20.
//  Copyright (c) 2014年 MFJ. All rights reserved.
//
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define LoadImage(imageName, imageType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:imageType]]

#import "ADCustomView.h"
#import "ADDataBean.h"

@implementation ADCustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [adScrollView setBackgroundColor:[UIColor clearColor]];
        [adScrollView setShowsHorizontalScrollIndicator:NO];
        [adScrollView setShowsVerticalScrollIndicator:NO];
        [adScrollView setPagingEnabled:YES];
        [adScrollView setDelegate:self];
        [self addSubview:adScrollView];
        
        adCustomInfoDic = [[NSMutableDictionary alloc] init];
        
        pageBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
        [pageBgView setBackgroundColor:COLOR(169.0f, 169.0f, 169.0f, 0.8f)];
        [self addSubview:pageBgView];
        
        adPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/3*2, self.frame.size.height-20, self.frame.size.width/3, 20)];
        [adPageControl setCurrentPage:0];
        [adPageControl setBackgroundColor:[UIColor clearColor]];
        [adPageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:adPageControl];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(timerOutSlot) userInfo:nil repeats:YES];
        [self stopTimerAnimation];
        
        self.type = 3; 
        
    }
    return self;
}

/* refresh Data for Ad View */
- (void)refreshImage:(NSArray *)infoArray placeHolderImage:(NSString *) placeHolderStr
{
    itemArray = [[NSArray alloc] initWithArray:infoArray];
    switch (self.type) {
        case left_Circle:
            [self setScrollLeftCircle:placeHolderStr];
            break;
        case all_Circle:
            [self setScrollAllCircle:placeHolderStr];
            break;
        default:
            [self setScrollNoCircle:placeHolderStr];
            break;
    }
    [adScrollView setContentSize:CGSizeMake(self.frame.size.width*imageInfoCount,
                                            self.frame.size.height)];
    [adPageControl setNumberOfPages:[itemArray count]];
    
}

/* set Left Circle Display Model */
- (void) setScrollLeftCircle:(NSString *) placeHolderImage
{
    [self setScrollNoCircle:placeHolderImage];
    ADDataBean *bean = [itemArray objectAtIndex:0];
    [adScrollView addSubview:[self createScrollItem:[itemArray count] imageStr:bean.ad_image imageId:bean.ad_id.intValue placeholder:placeHolderImage]];
    imageInfoCount = [itemArray count] + 1;
    
}

/* set All Circle Display Model*/
- (void) setScrollAllCircle:(NSString *) placeHolderImage
{
    [adCustomInfoDic removeAllObjects];
    ADDataBean *firstBean = [itemArray lastObject];
    [adScrollView addSubview:[self createScrollItem:0 imageStr:firstBean.ad_image imageId:firstBean.ad_id.intValue placeholder:placeHolderImage]];
    [adCustomInfoDic setValue:firstBean.ad_info forKey:[NSString stringWithFormat:@"%d",firstBean.ad_id.intValue]];
    
    ADDataBean *bean = nil;
    for (int i = 0; i < [itemArray count]; i++) {
        bean = [itemArray objectAtIndex:i];
        [adScrollView addSubview:[self createScrollItem:(i+1) imageStr:bean.ad_image imageId:bean.ad_id.intValue placeholder:placeHolderImage]];
        [adCustomInfoDic setValue:bean.ad_info forKey:[NSString stringWithFormat:@"%d",bean.ad_id.intValue]];
    }
    
    ADDataBean *lasetBean = [itemArray objectAtIndex:0];
    [adScrollView addSubview:[self createScrollItem:[itemArray count]+1 imageStr:lasetBean.ad_image imageId:lasetBean.ad_id.intValue placeholder:placeHolderImage]];
    [adCustomInfoDic setValue:lasetBean.ad_info forKey:[NSString stringWithFormat:@"%d",lasetBean.ad_id.intValue]];
    imageInfoCount = [itemArray count]+2;
    
}

/* set PageBgView Color*/
- (void)setPageBackgroundViewColor:(UIColor *)bgColor {
    [pageBgView setBackgroundColor:bgColor];
}

/* set adPageController Color*/
- (void)setPageControllerColor:(UIColor *)currentIndicatorColor
                IndicatorColor:(UIColor *)backgroundindicatorColor
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [adPageControl setCurrentPageIndicatorTintColor:currentIndicatorColor];
        [adPageControl setPageIndicatorTintColor:backgroundindicatorColor];
    }

}

/* set adPaageController Point*/
- (void)setPageControllerAlignment:(NSInteger)AlignmentFlag {
    switch (AlignmentFlag) {
        case 0:
            [adPageControl setFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width/3, 20)];
            break;
        case 1:
            [adPageControl setFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
            break;
        case 2:
            [adPageControl setFrame:CGRectMake(self.frame.size.width/3*2, self.frame.size.height-20, self.frame.size.width/3, 20)];
            break;
    }
}

/* set No Circle Display Model*/
- (void) setScrollNoCircle:(NSString *) placeHolderImage
{
    ADDataBean *bean = nil;
    [adCustomInfoDic removeAllObjects];
    for (int i = 0; i < [itemArray count]; i++) {
        bean = [itemArray objectAtIndex:i];
        [adScrollView addSubview:[self createScrollItem:i imageStr:bean.ad_image imageId:bean.ad_id.intValue placeholder:placeHolderImage]];
        [adCustomInfoDic setValue:bean.ad_info forKey:[NSString stringWithFormat:@"%d",bean.ad_id.intValue]];
    }
    imageInfoCount = [itemArray count];
    
}

/* Create Item for Ad View*/
- (UIButton *) createScrollItem:(NSInteger) location imageStr:(NSString *) imageStr
                        imageId:(NSInteger) imageId placeholder:(NSString *) placeholderStr
{
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*location, 0, self.frame.size.width, self.frame.size.height)];
    [bt addTarget:self action:@selector(selectItemInfo:) forControlEvents:UIControlEventTouchUpInside];
    [bt setBackgroundColor:[UIColor clearColor]];
    [bt setBackgroundImageWithURL:[NSURL URLWithString:imageStr] forState:UIControlStateNormal placeholderImage:LoadImage(placeholderStr, @"png")];
    [bt setTag:imageId];
    
    return bt;
}

// Select One Of Item Delegate
- (IBAction)selectItemInfo:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    [self stopTimerAnimation];
    if ([self.delegate respondsToSelector:@selector(selectADCustomViewItem:infoStr:)]) {
        [self.delegate selectADCustomViewItem:[NSString stringWithFormat:@"%d",(int)bt.tag ] infoStr:[adCustomInfoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)bt.tag]]];
    }
}

/* set AD page startPoint */
- (void) setADPageStartPoint:(NSInteger) startPoint
{
    [adPageControl setFrame:CGRectMake(startPoint, self.frame.size.height-20, self.frame.size.width-startPoint, 20)];
}

/* create Timer */
- (void) createScrollTimer:(float) timeInterval
{
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerOutSlot) userInfo:nil repeats:YES];
    [self startTimerAnimation];
}

/* scroll the AD View Image */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = adScrollView.contentOffset.x/self.frame.size.width;
    [self transformPointSize:currentPage];
}

/* Change the PageController */
- (IBAction)pageChanged:(id)sender
{
    NSInteger currentPage = adPageControl.currentPage;
    [adScrollView setContentOffset:CGPointMake(self.frame.size.width * currentPage, 0)];
}

/* time out dispose */
- (void) timerOutSlot
{
//    float scrollPoint = adScrollView.contentOffset.x;
//    [adScrollView setContentOffset:CGPointMake(scrollPoint+self.frame.size.width, 0) animated:YES];
//    [self transformPointSize:adScrollView.contentOffset.x / self.frame.size.width];
//    NSLog(@"--- ADCustomView timeOut ---");
    NSInteger pageCount = adScrollView.contentOffset.x/self.frame.size.width;
    [self transformPointSize:pageCount+1];
}

/* start timer */
- (void) startTimerAnimation
{
    [timer setFireDate:[NSDate  distantPast]];
}

/* stop timer*/
- (void) stopTimerAnimation
{
    [timer setFireDate:[NSDate distantFuture]];
}

// transform AD View Point
- (void) transformPointSize:(NSInteger) currentPoint
{
    switch (self.type) {
        case left_Circle:
            if (currentPoint == [itemArray count]) {
                [adScrollView setContentOffset:CGPointMake(0, 0)];
                [adPageControl setCurrentPage:0];
            }else {
                [adScrollView setContentOffset:CGPointMake(currentPoint*self.frame.size.width, 0) animated:YES];
                [adPageControl setCurrentPage:currentPoint];
            }
            break;
        case all_Circle:
            currentPoint-=1;
            if (currentPoint == [itemArray count]) {
                [adScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
                [adPageControl setCurrentPage:0];
            }else if (currentPoint == -1) {
                [adScrollView setContentOffset:CGPointMake(self.frame.size.width*[itemArray count], 0)];
                [adPageControl setCurrentPage:[itemArray count]];
            }else {
                [adScrollView setContentOffset:CGPointMake(currentPoint*self.frame.size.width, 0) animated:YES];
                [adPageControl setCurrentPage:currentPoint];
            }
            break;
        default:
            [adScrollView setContentOffset:CGPointMake(currentPoint*self.frame.size.width, 0) animated:YES];
            [adPageControl setCurrentPage:currentPoint];
            break;
    }
}

@end
