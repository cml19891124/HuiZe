//
//  UIImage+HUZExtension.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HUZExtension)

/**
 *  限制图片的大小不超过多少KB
 *
 *  @param image       所要限制的图片
 *  @param limitLength 限制图片的大小（单位为KB）
 *
 *  @return NSData
 */
+ (NSData *)imageWithImage:(UIImage *)image limitCompactionImageLength:(NSUInteger)limitLength;

/**
 *  自动缩放到指定大小
 *
 *  @param image 图片
 *  @param asize 指定的图片大小
 *
 *  @return UIImage
 */
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;
/**
 *  保持原来的长宽比，生成一个缩略图
 *
 *  @param image 图片
 *  @param asize 指定的图片大小
 *
 *  @return UIImage
 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;


+ (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize;
//将图片缩放到指定的CGSize大小
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;
//从图片中按指定的位置大小截取图片的一部分
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;


//获取纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)dr_b_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
