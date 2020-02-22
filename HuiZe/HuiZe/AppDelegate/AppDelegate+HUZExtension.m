#import "AppDelegate+HUZExtension.h"
#import <iVersion.h>
#import "HUZLoginViewController.h"
#import "HUZNavigationController.h"

@implementation AppDelegate (HUZExtension)

- (void)huz_initOptions {
    [self huz_initVersionUpdate];
}

#pragma mark - 版本升级初始化
- (void)huz_initVersionUpdate {
    [iVersion sharedInstance].applicationBundleID = [[NSBundle mainBundle] bundleIdentifier];
}
//
- (void)huz_initWindow {
    [[UIView appearance] setExclusiveTouch:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    if (!HUZUserCenterManager.isLogin || [HUZUserCenterManager.userModel.haveUserInfo integerValue] == 0 || HUZUserCenterManager.userModel.mobile.length == 0) {
        self.window.rootViewController = [[HUZNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"HUZLoginViewController") alloc] init]];
    }
    else {
        self.window.rootViewController = [[NSClassFromString(@"HUZTabBarController") alloc] init];
    }
    [self.window makeKeyAndVisible];
}


- (void)huz_configComponents{
    
    if (@available(iOS 11.0, *)) { // 适配ios11
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    //navbar
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          ColorS(COLOR_414141),NSForegroundColorAttributeName,
                                                          FontS(FONT_17),NSFontAttributeName,
                                                          nil]];
    
    
    //tabbar
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       ColorS(COLOR_C8C8C8),NSForegroundColorAttributeName,
                                                       FontS(FONT_10),NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       ColorS(COLOR_2E86FF),NSForegroundColorAttributeName,
                                                       FontS(FONT_10),NSFontAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-140, 0) forBarMetrics:UIBarMetricsDefault];

}

- (void)huz_configIQKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.keyboardDistanceFromTextField = 60.f;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

#pragma mark - 调试(DEBUG)模式
- (void)huz_configDebugModelTools{
    /// 显示FPS
//    [[JPFPSStatus sharedInstance] open];
}

- (void)huz_configNetEnvTools {
    // 开启网络监视器；
    [HUZNetWorkTool huz_monitorNetwork];
}
@end
