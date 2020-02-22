//
//  HUZModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

@implementation HUZModel

- (BOOL)isSuccess{
    if (self.code == 1 || [self.msg containsString:@"token"]) { // token 过期
        [UIView animateWithDuration:1.5f animations:^{
            UIViewController *huzVC = (UIViewController*)[UIViewController currentViewController];
            [MBProgressHUD showError:TOKENERROR  toView:huzVC.view];
        } completion:^(BOOL finished) {
            [HUZTools gotologin];
        }];
        return NO;
    }
    return self.code == 0;
}

@end
