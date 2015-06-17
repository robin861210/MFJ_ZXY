//
//  RenderingViewController.m
//  ZXYY
//
//  Created by soldier on updataArray/4/5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "RenderingViewController.h"

@interface RenderingViewController ()

@end

@implementation RenderingViewController
@synthesize myCollectionView = _myCollectionView;

- (void)viewDidLoad {                                                                                                                             
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    renderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    [renderTableView setBackgroundColor:[UIColor clearColor]];
    [renderTableView setDelegate:self];
    [renderTableView setDataSource:self];
    [renderTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [renderTableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:renderTableView];
    
    currentImgV = [[UIImageView alloc] init];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableDic count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"RenderingCell";
    RenderingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[RenderingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.delegate = self;
    }
    
    [cell setImageUrlInfo:[tableDic objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]] CellIndex:indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)selectRenderingCellButtonTag:(NSInteger)btTag {
    NSLog(@"~~~  cellButotnTag :%d ~~~",(int)btTag);
    
    NSMutableArray *describes = [[NSMutableArray alloc] init];
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:[renderingInfoArr count]];
    for (int i = 0; i < [renderingInfoArr count]; i++) {
        // 替换为中等尺寸图片
        
        NSString * getImageStrUrl =  [[renderingInfoArr objectAtIndex:i] objectForKey:@"PicUrl"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
//        UIImageView * imageView = (UIImageView *)[self.view viewWithTag:];
        [currentImgV setImageURLStr:[[renderingInfoArr objectAtIndex:btTag] objectForKey:@"PicUrl"] placeholder:LoadImage(@"placeholder@2x", @"jpg")];
        photo.srcImageView = currentImgV;
        [photos addObject:photo];
        
        //图片描述
        [describes addObject:[[renderingInfoArr objectAtIndex:i] objectForKey:@"PicDesc"]];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    [browser setTitle:@"查看照片"];
    browser.canShare = NO;
    browser.currentPhotoIndex = btTag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    browser.describeArray = describes;
    browser.canApply = NO;
    [self.navigationController pushViewController:browser animated:YES];
    //    [browser show];

}
//相册展示页面
- (void)updateRenderingViewControllerInfo:(NSArray *)updataArray
{
    
    renderingInfoArr = [[NSMutableArray alloc] initWithArray:updataArray];
    
    tableDic = [[NSMutableDictionary alloc] init];
    for (int i= 0; i < (updataArray.count+1)/3; i++) {
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        [tableDic setValue:tmpArray forKey:[NSString stringWithFormat:@"%d",i]];
    }

    int j = 0; int k = 0;
    for (int i= 0; i < updataArray.count; i++) {
        NSLog(@"~~~ j %d",i/3);
        if (i/3 == j) {
            [[tableDic objectForKey:[NSString stringWithFormat:@"%d",j]] addObject:[updataArray objectAtIndex:i]];
            k+=1;
        }
        if (k == 3) {
            j+=1;
            k = 0;
        }
    }
    [renderTableView reloadData];
    
    /*
    renderingInfoArr = [[NSMutableArray alloc] initWithArray:updataArray];;
//    for (int i = 0; i<[renderingInfoArr count]; i++) {
//        UIImageView *renderingImgV = [[UIImageView alloc] init];
//        [renderingImgV setFrame:CGRectMake(5*ScreenWidth/320+i%3*(105* ScreenWidth/320),5*ScreenHeight/568+ i/3*(105*ScreenHeight/568),100* ScreenWidth/320, 100*ScreenHeight/568)];
//        renderingImgV.userInteractionEnabled = YES;
//        [renderingImgV setTag:(100000+i)];
//        
//        [renderingImgV sd_setImageWithURL:[NSURL URLWithString:[[renderingInfoArr objectAtIndex:i] objectForKey:@"PicUrl"]] placeholderImage: [UIImage imageNamed:@"placeholder@2x.jpg"] ];
//        [renderingImgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(browseRenderingBtn:)] ];
//        [self.view addSubview:renderingImgV];
//        
//    }
    */
}

//- (void)browseRenderingBtn:(UITapGestureRecognizer *)imageTap
- (void)browseRenderingBtn:(NSInteger )imageTap
{
    NSMutableArray *describes = [[NSMutableArray alloc] init];
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [renderingInfoArr count] ];
    for (int i = 0; i < [renderingInfoArr count]; i++) {
        // 替换为中等尺寸图片
        
        NSString * getImageStrUrl =  [[renderingInfoArr objectAtIndex:i] objectForKey:@"PicUrl"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
//        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:imageTap+100000];
        photo.srcImageView = imageView;
        [photos addObject:photo];
        
        //图片描述
        [describes addObject:[[renderingInfoArr objectAtIndex:i] objectForKey:@"PicDesc"]];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    [browser setTitle:@"查看照片"];
    browser.canShare = NO;
//    browser.currentPhotoIndex = (imageTap.view.tag - 100000); // 弹出相册时显示的第一张图片是？
    browser.currentPhotoIndex = imageTap; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    browser.describeArray = describes;
    browser.canApply = NO;
    [self.navigationController pushViewController:browser animated:YES];
//    [browser show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
