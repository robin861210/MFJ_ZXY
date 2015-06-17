//
//  ModifyPWViewController.h
//  ZXY
//
//  Created by soldier on 15/6/13.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPWViewController : UIViewController <UITextFieldDelegate>
{
    UITextField  *oldPwTextF,
                    *newPwTextF,
                    *affirmPwTextF;
}

@end
