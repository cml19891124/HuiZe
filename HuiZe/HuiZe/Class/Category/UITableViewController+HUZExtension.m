//
//  UITableViewController+HUZExtension.m
//  HuiZe
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "UITableViewController+HUZExtension.h"

@implementation UITableViewController (HUZExtension)

- (void)presentSheet:(NSString *)title {
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    progressHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    progressHud.bezelView.backgroundColor = ColorS(COLOR_414141);
    progressHud.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    [self.view addSubview:progressHud];
    
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
    [MBProgressHUD showSuccess:title toView:self.view];
}

- (void)presentErrorSheet:(NSString *)title {
    [MBProgressHUD showError:title toView:self.view];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        [self removeOverFlowActivityView];
}

- (void)displayOverFlowActivityView {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    progressHud.bezelView.backgroundColor = ColorS(COLOR_414141);
    progressHud.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    [self.view addSubview:progressHud];
    [self.view bringSubviewToFront:progressHud];
    progressHud.mode = MBProgressHUDModeIndeterminate;
    //_progressHud.delegate = self;
    //_HUD.labelText = cString;
    [progressHud showAnimated:YES];
    [progressHud setTag:9955];
    
}

- (void)removeOverFlowActivityView {
    [[self.view viewWithTag:9955]removeFromSuperview];
}

//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
@end
