//
//  ComplaintViewController.h
//  ZXY
//
//  Created by soldier on 15/6/14.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintViewController : UIViewController <UITextFieldDelegate>
{
    NSArray *titleArray;                      //标题数组
    
    UIView *bgView;
    UIView *photoView;

    UITextField  *addressTextF,              //工程地址
                    *unameTextF,                //用户姓名
                    *telphoneTextF,             //联系电话
                    *contentTextF;              //投诉/建议内容
    

}

@end
