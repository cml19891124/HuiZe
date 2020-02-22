

#import <UIKit/UIKit.h>

@interface UIImage (LWImage)

/** 压缩图片，把图片压缩到给定的大小范围内 */
- (UIImage *)imageByScalingAndCroppingForLength:(NSInteger)length;

- (NSData *)resetMaxSize:(NSInteger)maxSize;

@end
