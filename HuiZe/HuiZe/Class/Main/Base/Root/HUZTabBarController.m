#import "HUZTabBarController.h"
#import "HUZNavigationController.h"
#import "HUZHomeController.h"
#import "HUZVolunteerController.h"
#import "HUZFriendController.h"
#import "HUZMeController.h"

@interface HUZTabBarController (){
    HUZNavigationController *navHomeController;
    HUZNavigationController *navVolunteerController;
    HUZNavigationController *navFriendController;
    HUZNavigationController *navMeController;
}

@end

@implementation HUZTabBarController

#pragma mark - 系统
- (void)dealloc {
    [self unRegisterNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInit];
    [self configNavControllers];
}

#pragma mark - 通知
- (void)setupInit {
    [self registerNotification];
}

- (void)registerNotification {
}

- (void)unRegisterNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configNavControllers{
    navHomeController = [[HUZNavigationController alloc] initWithRootViewController:[[HUZHomeController alloc] init]];
    navVolunteerController = [[HUZNavigationController alloc] initWithRootViewController:[[HUZVolunteerController alloc] init]];
    navFriendController = [[HUZNavigationController alloc] initWithRootViewController:[[HUZFriendController alloc] init]];
    navMeController = [[HUZNavigationController alloc] initWithRootViewController:[[HUZMeController alloc] init]];
    
    
    [self setNav:navHomeController title:@"主页" imageString:@"tab_home_normal" selectedImageString:@"tab_home_checked"];
    [self setNav:navVolunteerController title:@"填志愿" imageString:@"tab_volunteer_normal" selectedImageString:@"tab_volunteer_checked"];
    [self setNav:navFriendController title:@"朋友圈" imageString:@"tab_friend_normal" selectedImageString:@"tab_friend_checked"];
    [self setNav:navMeController title:@"我的" imageString:@"tab_me_normal" selectedImageString:@"tab_me_checked"];

    
    self.viewControllers = [NSArray arrayWithObjects:navHomeController,navVolunteerController,navFriendController,navMeController, nil];
}


- (void)setNav:(HUZNavigationController *)nav title:(NSString *)title imageString:(NSString *)imageString selectedImageString:(NSString *)selectedImageString{
    [nav.tabBarItem setTitle:title];
    [nav.tabBarItem setImage:[[UIImage imageNamed:imageString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImageString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

@end
