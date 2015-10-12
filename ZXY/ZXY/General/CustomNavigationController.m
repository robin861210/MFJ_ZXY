//
//  CustomNavigationController.m
//
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[UINavigationBar appearance] setBackgroundImage:LoadImage(@"topnav_bg_new@2x", @"png") forBarMetrics:UIBarMetricsDefault];
    
//    [[UINavigationBar appearance] setBackgroundImage:LoadImage(@"topnav_bg_old@2x", @"png") forBarMetrics:UIBarMetricsDefault];

}

- (UIBarButtonItem *) createBackButton
{
    UIImage* image = [UIImage imageNamed:@"nav_back@2x.png"];
    UIImage* imagef = [UIImage imageNamed:@"nav_backed@2x.png"];
    
    CGRect backframe = CGRectMake(0, 0, 15, 20);
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton setBackgroundImage:imagef forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;

}

- (void)popSelf {
    [self popViewControllerAnimated:YES];
    
    [self.navigationBar setBackgroundImage:LoadImage(@"topnav_bg_new@2x", @"png") forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setBackgroundImage:LoadImage(@"topnav_bg_old@2x", @"png") forBarMetrics:UIBarMetricsDefault];
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem == nil
        && [self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem = [self createBackButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
