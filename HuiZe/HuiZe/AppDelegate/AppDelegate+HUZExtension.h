#import "AppDelegate.h"
#import "IQKeyboardManager.h"

#if defined(DEBUG)||defined(_DEBUG)
#import "JPFPSStatus.h"
#endif
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (HUZExtension)

- (void)huz_initOptions;
- (void)huz_initWindow;


// 配置键盘
- (void)huz_configIQKeyboardManager;
// 开启性能检测工具
- (void)huz_configDebugModelTools;
// 适配ios11
- (void)huz_configComponents;
// 开启网络环境检测
- (void)huz_configNetEnvTools;
@end

NS_ASSUME_NONNULL_END
