//
//  HUZTYPagerViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZTYPagerViewController : HUZViewController
<
TYTabPagerBarDataSource,
TYTabPagerBarDelegate,
TYPagerControllerDataSource,
TYPagerControllerDelegate
>
@property (nonatomic,strong) UIView *ivRadioBg;
@property (nonatomic, strong) TYTabPagerBar *tabBar;
@property (nonatomic, strong) TYPagerController *pagerController;
/// 数据源
@property(nonatomic,strong) NSArray *datas;

- (void)addivRadioBg;
- (void)addTabPageBar;
- (void)addPagerController;

@end

NS_ASSUME_NONNULL_END
