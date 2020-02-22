#import "UIView+HUZFrame.h"

@implementation UIView (HUZFrame)
- (void)setHuz_x:(CGFloat)huz_x {
    CGRect frame = self.frame;
    frame.origin.x = huz_x;
    self.frame = frame;
}

- (CGFloat)huz_x {
    return self.frame.origin.x;
}

- (void)setHuz_y:(CGFloat)huz_y {
    CGRect frame = self.frame;
    frame.origin.y = huz_y;
    self.frame = frame;
}

- (CGFloat)huz_y {
    return self.frame.origin.y;
}

- (void)setHuz_width:(CGFloat)huz_width {
    CGRect frame = self.frame;
    frame.size.width = huz_width;
    self.frame = frame;
}

- (CGFloat)huz_width {
    return self.frame.size.width;
}

- (void)setHuz_height:(CGFloat)huz_height {
    CGRect frame = self.frame;
    frame.size.height = huz_height;
    self.frame = frame;
}

- (CGFloat)huz_height {
    return self.frame.size.height;
}

- (void)setHuz_centerX:(CGFloat)huz_centerX {
    CGPoint center = self.center;
    center.x = huz_centerX;
    self.center = center;
}

- (CGFloat)huz_centerX {
     return self.center.x;
}

- (void)setHuz_centerY:(CGFloat)huz_centerY {
    CGPoint center = self.center;
    center.y = huz_centerY;
    self.center = center;
}

- (CGFloat)huz_centerY {
    return self.center.y;
}

- (void)setHuz_top:(CGFloat)huz_top {
    CGRect frame = self.frame;
    frame.origin.y = huz_top;
    self.frame = frame;
}

- (CGFloat)huz_top {
    return self.frame.origin.y;
}

- (void)setHuz_left:(CGFloat)huz_left {
    CGRect frame = self.frame;
    frame.origin.x = huz_left;
    self.frame = frame;
}

- (CGFloat)huz_left {
    return self.frame.origin.x;
}

- (void)setHuz_buttom:(CGFloat)huz_buttom {
    self.huz_y = huz_buttom - self.huz_height;
}

- (CGFloat)huz_buttom {
    return CGRectGetMaxY(self.frame);
}

- (void)setHuz_right:(CGFloat)huz_right {
    self.huz_x = huz_right - self.huz_width;
}

- (CGFloat)huz_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setHuz_size:(CGSize)huz_size {
    CGRect frame = self.frame;
    frame.size = huz_size;
    self.frame = frame;
}

- (CGSize)huz_size {
    return self.frame.size;
}

- (void)setHuz_orign:(CGPoint)huz_orign {
    CGRect frame = self.frame;
    frame.origin = huz_orign;
    self.frame = frame;
}

- (CGPoint)huz_orign {
     return self.frame.origin;
}

- (UIViewController *)YQViewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
