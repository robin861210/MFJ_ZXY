//
//  MJPhotoBrowser.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

//#import <QuartzCore/QuartzCore.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "SDWebImageManager+MJ.h"
#import "MJPhotoView.h"
#import "MJPhotoToolbar.h"

#define kPadding 0
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)

@interface MJPhotoBrowser () <MJPhotoViewDelegate, MJPhotoToolbarDelegate>
{
    // 滚动的view
	UIScrollView *_photoScrollView;
    // 所有的图片view
	NSMutableSet *_visiblePhotoViews;
    NSMutableSet *_reusablePhotoViews;
    // 工具条
    MJPhotoToolbar * _toolbar;
    
    // 描述信息label
    UILabel * _describeLabel;
}
@end

@implementation MJPhotoBrowser


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 1.创建UIScrollView
    [self createScrollView];
    
    // 2.创建工具条
    [self createToolbar];
    
    // 3.创建描述（ylb）
    [self createDescribeLabel];
    
    if (_currentPhotoIndex == 0) {
        [self showPhotos];
    }
    
    //添加右导航按钮  （分享）
    [self addRightNavigationItem];
    
    //申请按钮
    [self setSubmitApplicationBtn];
}

// 添加右导航，分享按钮
- (void)addRightNavigationItem
{
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [shareBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [shareBtn setBackgroundImage:LoadImage(@"shareBt@2x", @"png") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    if (self.canShare) {
        [shareBtn setHidden:NO];
    }else
    {
        [shareBtn setHidden:YES];
    }
    
}

- (void)setSubmitApplicationBtn
{
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setFrame:CGRectMake(0, ScreenHeight -64 - 50, ScreenWidth, 50)];
    //设置“申请免费设计”颜色
//    [submitBtn setBackgroundColor:UIColorFromHex(0x33000000)];
    [submitBtn setBackgroundColor:RGBACOLOR(0.0, 0.0, 0.0, 0.22)];
    [submitBtn addTarget:self action:@selector(submitApplication:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    //申请按钮是否显示
    if (self.canApply) {
        [submitBtn setHidden:NO];
    }else
    {
        [submitBtn setHidden:YES];
    }
    
    UIImageView *subImgV = [[UIImageView alloc] initWithFrame:CGRectMake(100*ScreenWidth/320, 15, 20, 20)];
    [subImgV setImage:LoadImage(@"applyDesign@2x", @"png")];
    [submitBtn addSubview:subImgV];
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(subImgV.frame.origin.x + subImgV.frame.size.width, 15, ScreenWidth-115*ScreenWidth/320, 20)];
    [subLabel setText:@"申请免费设计"];
    [subLabel setTextAlignment:NSTextAlignmentLeft];
    [subLabel setTextColor:[UIColor whiteColor]];
    [subLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [submitBtn addSubview:subLabel];
    
}

//提交申请
- (void)submitApplication:(id)sender
{
    NSLog(@"提交申请，样板间id:%@",self.mRoomId);
    NSLog(@"%@",self.mRoomDic);
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];

    if (_currentPhotoIndex == 0) {
        [self showPhotos];
    }
}

#pragma mark - 私有方法
#pragma mark 创建工具条
- (void)createToolbar
{
    CGFloat barHeight = 30;
    
    CGFloat barY;
    if (self.canApply) {
        barY = ScreenHeight -64 - barHeight- 50;
    }else
    {
        barY = ScreenHeight -64 - barHeight;
    }
    
    _toolbar = [[MJPhotoToolbar alloc] init];
    _toolbar.Delegate = self;
    _toolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
//    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _toolbar.photos = _photos;
    [self.view addSubview:_toolbar];
    
    [self updateTollbarState];
}

-(void)DeleteThisImage:(NSInteger)ThisImageIndex
{
    
    
    NSLog(@"ThisImageIndex---%d", ThisImageIndex );
    NSLog(@"_currentPhotoIndex---%d", _currentPhotoIndex );
    
    if ( ThisImageIndex == 0 ) {
        _currentPhotoIndex = 1;
    }else if ( ThisImageIndex == _currentPhotoIndex ) {
        _currentPhotoIndex = _currentPhotoIndex - 1;
    }else{
        _currentPhotoIndex = _currentPhotoIndex - 1;
    }
    
    [_photos removeObjectAtIndex: ThisImageIndex];
    
    [self setCurrentPhotoIndex: _currentPhotoIndex ];
    
}

#pragma mark - 私有方法
#pragma mark 创建描述信息Label(ylb)
- (void)createDescribeLabel
{
    CGFloat barHeight = 100;
    
    CGFloat barY;
    if (self.canApply) {
        barY = ScreenHeight -64 - barHeight- 50 -30;
    }else
    {
        barY = ScreenHeight -64 - barHeight -30;
    }

    _describeLabel = [[UILabel alloc] init];
    [_describeLabel setBackgroundColor:[UIColor clearColor]];
    _describeLabel.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
    [_describeLabel setTextColor:[UIColor whiteColor]];
    [_describeLabel setTextAlignment:NSTextAlignmentLeft];
    [_describeLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.view addSubview:_describeLabel];
    
    [self updataDescribeLabelInfo];
}


#pragma mark 创建UIScrollView
- (void)createScrollView
{
//    CGRect frame = self.view.bounds;
    CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
	_photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
//	_photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_photoScrollView.pagingEnabled = YES;
	_photoScrollView.delegate = self;
	_photoScrollView.showsHorizontalScrollIndicator = NO;
	_photoScrollView.showsVerticalScrollIndicator = NO;
	_photoScrollView.backgroundColor = [UIColor clearColor];
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
	[self.view addSubview:_photoScrollView];
    _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
}

- (void)setPhotos:(NSMutableArray *)photos
{
    _photos = photos;
    
    if (photos.count > 1) {
        _visiblePhotoViews = [NSMutableSet set];
        _reusablePhotoViews = [NSMutableSet set];
    }
    
    for (int i = 0; i<_photos.count; i++) {
        MJPhoto *photo = _photos[i];
        photo.index = i;
        photo.firstShow = i == _currentPhotoIndex;
    }
}

#pragma mark 设置选中的图片
- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    for (int i = 0; i<_photos.count; i++) {
        MJPhoto *photo = _photos[i];
        photo.firstShow = i == currentPhotoIndex;
    }
    
    if ([self isViewLoaded]) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
        NSLog(@"%f",_currentPhotoIndex * _photoScrollView.frame.size.width);
        
        // 显示所有的相片
        [self showPhotos];
    }
}

#pragma mark - MJPhotoView代理
- (void)photoViewSingleTap:(MJPhotoView *)photoView
{
    // 移除工具条
    [_toolbar removeFromSuperview];
    
    if ( [_delegate respondsToSelector:@selector(CellPhotoImageReload)] ) {
        [_delegate CellPhotoImageReload];
    }
}

- (void)photoViewDidEndZoom:(MJPhotoView *)photoView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)photoViewImageFinishLoad:(MJPhotoView *)photoView
{
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark 显示照片
- (void)showPhotos
{
    // 只有一张图片
    if (_photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        return;
    }
    
    CGRect visibleBounds = _photoScrollView.bounds;
	int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
	int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= _photos.count) firstIndex = _photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= _photos.count) lastIndex = _photos.count - 1;
	
	// 回收不再显示的ImageView
    NSInteger photoViewIndex;
	for (MJPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
		if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
			[_reusablePhotoViews addObject:photoView];
			[photoView removeFromSuperview];
		}
	}
    
	[_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
	
	for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
		if (![self isShowingPhotoViewAtIndex:index]) {
			[self showPhotoViewAtIndex:index];
		}
	}
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(int)index
{
    MJPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[MJPhotoView alloc] init];
        photoView.photoViewDelegate = self;
    }
    
    // 调整当期页的frame
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    MJPhoto *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
    
    [self loadImageNearIndex:index];
}

#pragma mark 加载index附近的图片
- (void)loadImageNearIndex:(int)index
{
    if (index > 0) {
        MJPhoto *photo = _photos[index - 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
    
    if (index < _photos.count - 1) {
        MJPhoto *photo = _photos[index + 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
}

#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
	for (MJPhotoView *photoView in _visiblePhotoViews) {
		if (kPhotoViewIndex(photoView) == index) {
           return YES;
        }
    }
	return  NO;
}

#pragma mark 循环利用某个view
- (MJPhotoView *)dequeueReusablePhotoView
{
    MJPhotoView *photoView = [_reusablePhotoViews anyObject];
	if (photoView) {
		[_reusablePhotoViews removeObject:photoView];
	}
	return photoView;
}

#pragma mark 更新toolbar状态
- (void)updateTollbarState
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark 更新描述信息 (ylb)

- (void)updataDescribeLabelInfo
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
    [_describeLabel setText:[self.describeArray objectAtIndex:_currentPhotoIndex]];
//    [self.describeArray objectAtIndex:_currentPhotoIndex];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self showPhotos];
    [self updateTollbarState];
    [self updataDescribeLabelInfo];
}

//分享
- (void)shareBtn:(id)sender
{
    NSLog(@"~~~~~~~~  分享   ~~~~~~~~");
    
}

- (UIImage *)loadWebImage:(NSString *)imageUrlPath
{
    UIImage* image=nil;
    NSURL* url = [NSURL URLWithString:[imageUrlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//网络图片url
    NSData* data = [NSData dataWithContentsOfURL:url];//获取网咯图片数据
    if(data!=nil)
    {
        image = [[UIImage alloc] initWithData:data];//根据图片数据流构造image
    }
    return image;
}


@end