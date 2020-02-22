//
//  HUZHomeBannerView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHomeBannerView.h"
#import "HUZBannerModel.h"

@implementation HUZHomeBannerView

- (void)initView{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero
                                                            delegate:self
                                                    placeholderImage:ImageNamed(@"iv_banner_default")];

    _cycleScrollView.backgroundColor = [UIColor clearColor];
//    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    _cycleScrollView.autoScrollTimeInterval = 5; // 自动滚动时间间隔
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter; // 翻页 中间
    _cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor]; // 图片对应的标题的 背景色。（因为没有设标题）
    [self addSubview:_cycleScrollView];

    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(345),AutoDistance(142)));
    }];
    ViewRadius(_cycleScrollView, AutoDistance(8));
}

- (void)setBanners:(NSArray *)banners{
    _banners = banners;
    NSArray *imageUrls = [banners jk_map:^id(HUZBannerDataModel * object) {
        return object.imgUrl;
    }];
    _cycleScrollView.imageURLStringsGroup = imageUrls;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{}

@end
