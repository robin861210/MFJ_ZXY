//
//  InviteLoginViewController.h
//  ZXYY
//
//  Created by soldier on 15/4/2.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface InviteLoginViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *inviteCodeTf;
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
}


@end
