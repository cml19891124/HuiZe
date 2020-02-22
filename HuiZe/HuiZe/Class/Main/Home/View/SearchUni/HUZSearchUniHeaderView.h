//
//  HUZSearchUniHeaderView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZHomeBannerView.h"
#import "HUZSearchUniFunctionView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HUZSearchUniOrMajorType){
    HUZSearchUni = 1,   /// 查大学
    HUZSearchMajor,     /// 查专业
};

#define BannerH AutoDistance(170)

@interface HUZSearchUniHeaderView : HUZView

@property (nonatomic,strong) HUZHomeBannerView *bannerView;
@property (nonatomic,strong) HUZSearchUniFunctionView *ivAllUni;
@property (nonatomic,strong) HUZSearchUniFunctionView *ivProvinceUni;
@property (nonatomic,strong) HUZSearchUniFunctionView *ivUniList;
@property (nonatomic,strong) HUZSearchUniFunctionView *ivUniPK;

@property (nonatomic,assign) HUZSearchUniOrMajorType type;

@end

NS_ASSUME_NONNULL_END
