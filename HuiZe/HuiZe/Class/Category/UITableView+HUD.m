//
//  UITableView+HUD.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/15.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "UITableView+HUD.h"

@implementation UITableView (HUD)

- (void)presentSheet:(NSString *)title {
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self];
    progressHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    progressHud.bezelView.backgroundColor = ColorS(COLOR_414141);
    progressHud.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    [self addSubview:progressHud];
    
    progressHud.mode = MBProgressHUDModeText;
    progressHud.label.text = title;
    progressHud.label.numberOfLines = 0;
    [progressHud.label sizeToFit];
    [progressHud showAnimated:YES];
    
    [self performBlock:^{
        [progressHud hideAnimated:YES];
        [progressHud removeFromSuperview];
    } afterDelay:1.5];
}


- (void)presentSuccessSheet:(NSString *)title {
    [MBProgressHUD showSuccess:title toView:self];
}

- (void)presentErrorSheet:(NSString *)title {
    [MBProgressHUD showError:title toView:self];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self removeOverFlowActivityView];
//}

- (void)displayOverFlowActivityView {
    
    [MBProgressHUD hideHUDForView:self animated:YES];
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self];
    progressHud.bezelView.backgroundColor = ColorS(COLOR_414141);
    progressHud.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    [self addSubview:progressHud];
    [self bringSubviewToFront:progressHud];
    progressHud.mode = MBProgressHUDModeIndeterminate;
    //_progressHud.delegate = self;
    //_HUD.labelText = cString;
    [progressHud showAnimated:YES];
    [progressHud setTag:9955];
    
}

- (void)removeOverFlowActivityView {
    [[self viewWithTag:9955]removeFromSuperview];
}

//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
