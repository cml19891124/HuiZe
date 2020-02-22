//
//  UIImage+LWImage.m
//  LiwaiU
//
//  Created by fengwenjie on 16/7/14.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

#import "UIImage+LWImage.h"
//#import "LWResourcePath.h"

@implementation UIImage (LWImage)

- (UIImage *)imageByScalingAndCroppingForLength:(NSInteger)length
{
    CGFloat scale = self.scale;
    CGFloat w = sqrtf(length * scale);
    CGSize targetSize = CGSizeMake(w, w / scale);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    [self drawInRect:CGRectMake(0, 0, w, w / scale)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%u", UIImageJPEGRepresentation(newImage, 1.0).length);
//    UIImageWriteToSavedPhotosAlbum(newImage, self, nil, nil);
    return newImage;
}

- (NSData *)resetMaxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(self.size.width, self.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(self.size.width / tempWidth, self.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(self.size.width / tempHeight, self.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:imageData], self, nil, nil);
        return finallImageData;
    }
//    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:imageData], self, nil, nil);
    return imageData;
}

@end
