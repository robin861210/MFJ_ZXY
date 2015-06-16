//
//  CameraImage.m
//  Kingdal
//
//  Created by hndf on 14-11-25.
//  Copyright (c) 2014年 MFJ. All rights reserved.
//


#import "CameraImage.h"

static UIImage *obtainImage;
@implementation CameraImage

+ (void)setCameraImage:(UIImage *)image
{
    obtainImage = image;
}

+ (UIImage *)getCameraImage
{
    return obtainImage;
}

@end
