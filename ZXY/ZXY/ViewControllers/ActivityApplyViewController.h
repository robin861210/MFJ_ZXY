//
//  ActivityApplyViewController.h
//  ZXY
//
//  Created by soldier on 15/6/21.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityApplyViewController : UIViewController <UITextFieldDelegate>
{
    UITextField  *nameTextF,                        //姓名
                    *phoneTextF,                       //电话
                    *addressTextF;                     //地址
}

@end
