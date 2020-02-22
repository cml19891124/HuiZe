//
//  HUZHomeBannerView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZHomeBannerView : HUZView<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong) NSArray *banners;

@end

NS_ASSUME_NONNULL_END
