//
//  LoginViewController.h
//  ZXYY
//
//  Created by hndf on 15-4-1.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QrCodeViewController.h"
#import "AppDelegate.h"
#import "InviteLoginViewController.h"


@interface LoginViewController : UIViewController <QrCodeViewControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate,BMKGeoCodeSearchDelegate>
{
    UITextField *userNameTf,*passWordTf;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
    
    BMKGeoCodeSearch *_searcher;

}

- (void)dismissProgressAlert;

@end

