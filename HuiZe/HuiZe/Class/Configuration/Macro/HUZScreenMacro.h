#ifndef HUZScreenMacro_h
#define HUZScreenMacro_h

// App
#define HUZSYSTEM_VERSION [[UIDevice currentDevice].systemVersion doubleValue]
#define HUZAPP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define HUZAPP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define HUZAPP_LANGUAGE [[NSLocale preferredLanguages] objectAtIndex:0]

// 设备类型
#define HUZIPHONE4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define HUZIPHONESE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define HUZIPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define HUZIPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define HUZIPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define HUZIPHONE_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define HUZIPHONE_XSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define HUZIPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

// 全面屏
#define HUZISFULLSCREEN (HUZIPHONE_X || HUZIPHONE_XS || HUZIPHONE_XSMAX || HUZIPHONE_XR)
#define HUZISNORMALFONT (HUZIPHONE4S || HUZIPHONESE || HUZIPHONE6)

#define HUZSTATUS_BAR_HEIGHT (HUZISFULLSCREEN ? 44.f : 20.f)
#define HUZNAVIGATION_BAR_HEIGHT 44.f
#define HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT (HUZISFULLSCREEN ? 88.f : 64.f)
#define HUZTAB_BAR_HEIGHT (HUZISFULLSCREEN ? (49.f + 34.f) : 49.f)
#define HUZTAB_BAR_SAFE_BOTTOM_MARGIN (HUZISFULLSCREEN ? 34.f : 0.f)

// 屏幕尺寸
#define HUZSCREEN_BOUNDS [UIScreen mainScreen].bounds
#define HUZSCREEN_SIZE [UIScreen mainScreen].bounds.size
#define HUZSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define HUZSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 适配比
#define HUZWIDTH(value) ((value) * HUZSCREEN_WIDTH / 375.0f) // 6为标准适配
#define HUZHEIGHT(value) ((value) * HUZSCREEN_HEIGHT / 667.0f)
#define HUZFONT(value) (HUZISNORMALFONT ? value : (value + 2))

#define KWidth_scale       [[UIScreen mainScreen] bounds].size.width/375.0
//因为iphoneX宽度与iphone8一样,但高度却比iphone8高
#define KHeight_scale      (KMainScreenHeigth == 812.0 ? 667.0/667.0 : KMainScreenHeigth/667.0)

/// 自定义常用宏

// 是否为空对象
#define DRObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])
// 字符串为空
#define DRStringIsEmpty(__string) ((__string.length == 0) || DRObjectIsNil(__string))
// 字符串不为空
#define DRStringIsNotEmpty(__string)  (!DRStringIsEmpty(__string))
// 数组为空
#define DRArrayIsEmpty(__array) ((DRObjectIsNil(__array)) || (__array.count==0))

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//设置字体大小
#define FontS(s)           [UIFont systemFontOfSize:FontSize(s)]
//设置字体大小 字重
#define BoldFontS(s)    [UIFont boldSystemFontOfSize:FontSize(s)]
//设置字体颜色
#define ColorS(s)          [UIColor jk_colorWithHexString:s]
//设置图片
#define ImageNamed(name)   [UIImage imageNamed:name]

//适配距离
#define AutoDistance(s)  KWidth_scale * s

//适配字体
static inline CGFloat FontSize(CGFloat fontSize){
//    return fontSize;
        return  KWidth_scale * fontSize;
}

/// 背景主题色
#define COLOR_BG_F6F6F6  @"#F6F6F6"             //浅灰色
#define COLOR_BG_E9E9E9  @"#E9E9E9"
#define COLOR_BG_2E86FF  @"#2E86FF"             //蓝色
#define COLOR_BG_000000  @"#000000"
#define COLOR_BG_D8D8D8  @"#D8D8D8"
#define COLOR_BG_F19147  @"#F19147"
#define COLOR_BG_979797  @"#979797"
#define COLOR_BG_163A6B  @"#163A6B"
#define COLOR_BG_284976  @"#284976"
#define COLOR_BG_1ACD38 @"#1ACD38"
#define COLOR_BG_FF2E4A @"#FF2E4A"
#define COLOR_BG_F8C301 @"#F8C301"
#define COLOR_BG_40424E @"#40424E"
#define COLOR_BG_WHITE   [UIColor whiteColor]


/// 字体色
#define COLOR_848484  @"#848484"
#define COLOR_414141  @"#414141"
#define COLOR_000000  @"#000000"
#define COLOR_525252  @"#525252"
#define COLOR_ffffff  @"#ffffff"
#define COLOR_989898  @"#989898"
#define COLOR_2E86FF  @"#2E86FF"
#define COLOR_FF0000  @"#FF0000"
#define COLOR_C8C8C8  @"#C8C8C8"
#define COLOR_F19147  @"#F19147"
#define COLOR_CFCFCF  @"#CFCFCF"
#define COLOR_9DA7B2  @"#9DA7B2"

/// 字体
#define FONT_10   10.0f
#define FONT_12   12.0f
#define FONT_14   14.0f
#define FONT_15   15.0f
#define FONT_17   17.0f
#define FONT_18   18.0f
#define FONT_20   20.0f
#define FONT_22   22.0f
#define FONT_24   24.0f


#define NAV_BACK_BLACK  @"nav_back_black"  /// 黑色返回键
#define NAV_BACK_WHITE  @"nav_back_white"  /// 白色返回键
#define DEFAULT_IMAGE   @"iv_default"      /// 无图片占图
#define EMPTYDATA_IMAGE @"iv_empty_holder" /// 空数据占图
#define NETERROR_IMAGE  @"iv_neterror_holder" /// 网络异常占图

#define NETERROR  @"检测到未有网络连接~\n请刷新该页面"
#define TOKENERROR  @"token失效，请重新登录"
#define EMPTYDATA @"等待添加新内容"

/// 用户中心
#define HUZUserCenterManager  [HUZUserCenter shareUserCenter]
/// 静态数据
#define HUZDataBaseManager [HUZDataBase shareDataBase]

#endif /* HUZScreenMacro_h */
