//
//  UIImage+Thumb.h
//  Agencies
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Thumb)

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

/**
 截图
 
 @param aimView 需要截图的View
 @return 返回的图片
 */
+ (UIImage *)actionForScreenShotWith:(UIView *)aimView;


+ (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize;


//将图片缩放到指定的CGSize大小
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;
//从图片中按指定的位置大小截取图片的一部分
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;



//获取纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//根据透明度获取黑色图片
+ (UIImage *)getBlackImageWihtAlpha:(CGFloat)alpha;

//根据透明度获取白色图片
+ (UIImage *)getImageWithAlpha:(CGFloat)alpha;

//url生成二维码
+ (UIImage *)generateCode:(NSString *)url;

- (UIImage *)yq_imageWithColor:(UIColor *)color;
@end
