#import "HUZNavigationController.h"

@interface HUZNavigationController ()<UINavigationControllerDelegate>
{
    NSArray *hiddenNavBarClassArray;
}

@end

@implementation HUZNavigationController

#pragma mark - 系统

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    /// 返回键
    UIImage *backButtonImage = [[UIImage imageNamed:NAV_BACK_BLACK] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
    
    self.delegate = self;
    
    [self.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    
    hiddenNavBarClassArray = [[NSArray alloc] initWithObjects:
                              NSClassFromString(@"HUZMeController"),
                              NSClassFromString(@"HUZLoginViewController"),
                              NSClassFromString(@"HUZPsdLoginViewController"),
                              NSClassFromString(@"HUZBindPhoneViewController"),
                              NSClassFromString(@"HUZModifyPhoneViewController"),
                              NSClassFromString(@"HUZForgetPsdViewController"),
                              NSClassFromString(@"HUZWriteInfoViewController"),
                              //NSClassFromString(@"HUZVolunteerController"),
                              NSClassFromString(@"HUZVolFillResultController"),
//                              NSClassFromString(@"HUZFriendController"),
                              NSClassFromString(@"HUZVolunteerAnalyzeController"),
                              NSClassFromString(@"HUZMyGkInfoViewController"),
                            //NSClassFromString(@"HUZAgreementViewController"),
                              nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    Class vcClass = [viewController class];
    if ([hiddenNavBarClassArray containsObject:vcClass]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }
    else
    {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end
