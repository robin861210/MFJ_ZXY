//
//  AppDelegate.h
//  ZXY
//
//  Created by acewill on 15/6/12.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import "ApplyViewController.h"
#import "EaseMobLoginViewController.h"

#import "MainViewController.h"
#import "CustomNavigationController.h"
#import "DDMenuController.h"
#import "LeftViewController.h"

@class LoginViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
{
    BMKMapManager* _mapManager;
    
    BMKMapView* _mapView;
    BMKGeoCodeSearch *_searcher;
    BMKLocationService *_locService;
    
    
    CLLocationManager *locationManager;
    BOOL locationCoordinateFlag;
    NSString *myAddress;
    BOOL isLocation;
    
    MainViewController *mainVC;
    LoginViewController *loginVC;
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) CLLocationCoordinate2D myLocationCoordinate;
@property (nonatomic, assign) BOOL locationCoordinateFlag;
@property (nonatomic,strong)  NSString *myAddress;
@property (strong, nonatomic)DDMenuController *menuController;

- (void)enterLoginViewController;
- (void)enterHomeViewController;

@end

