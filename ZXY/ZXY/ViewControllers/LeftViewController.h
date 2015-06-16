//
//  LeftViewController.h
//  ZXY
//
//  Created by acewill on 15/6/12.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    UITableView *listTableV;
    NSArray *listIconArray;
    NSArray *listNameArray;
    UIImageView *headImgV;      //头像
    
    AVCaptureSession * _AVSession;//调用闪光灯的时候创建的类
    UIImageView *bgImgView;
    UIImage *_cameraImage;
    BOOL functionFlag;

    NSString *headUrl;          //上传图片的地址
    
    MRProgressOverlayView *progressView;
    NetworkInterface *interface;
}

@property(nonatomic,retain)AVCaptureSession *AVSession;

@end
