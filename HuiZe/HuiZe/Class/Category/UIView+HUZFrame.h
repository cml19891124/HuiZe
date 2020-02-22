#import <UIKit/UIKit.h>

@interface UIView (HUZFrame)

@property (nonatomic, assign) CGFloat huz_x;
@property (nonatomic, assign) CGFloat huz_y;
@property (nonatomic, assign) CGFloat huz_width;
@property (nonatomic, assign) CGFloat huz_height;

@property (nonatomic, assign) CGFloat huz_centerX;
@property (nonatomic, assign) CGFloat huz_centerY;

@property (nonatomic, assign) CGFloat huz_top;
@property (nonatomic, assign) CGFloat huz_left;
@property (nonatomic, assign) CGFloat huz_buttom;
@property (nonatomic, assign) CGFloat huz_right;

@property (nonatomic, assign) CGSize huz_size;
@property (nonatomic, assign) CGPoint huz_orign;

@property (nonatomic, readonly) UIViewController *YQViewController;
@end
