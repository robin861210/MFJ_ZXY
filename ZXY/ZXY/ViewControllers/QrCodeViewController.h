//
//  QrCodeViewController.h
//  ZXYY
//
//  Created by 华诺东方 on 15/4/1.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@protocol QrCodeViewControllerDelegate <NSObject>

- (void)getQrCodeInfoStr:(NSString *)qrCodeStr;

@end

@interface QrCodeViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

@property (nonatomic, strong)id<QrCodeViewControllerDelegate>delegate;


@end
