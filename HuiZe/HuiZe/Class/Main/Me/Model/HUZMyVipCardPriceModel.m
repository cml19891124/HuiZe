//
//  HUZMyVipCardPriceModel.m
//  HuiZe
//
//  Created by tbb on 2019/9/3.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMyVipCardPriceModel.h"

@implementation HUZMyVipCardPriceModel
-(NSString *)title {
    if (!_title) {
        switch (self.upgradeType) {
            case 1:
                _title = @"升级到铂金卡";
                break;
            case 2:
                _title = @"志愿卡";
                break;
            case 3:
                _title = @"升级到专家一对一";
                break;
            default:
                break;
        }
    }
    return _title;
}

-(NSString *)bigIcon {
    if (!_bigIcon) {
        switch (self.upgradeType) {
            case 1:
                _bigIcon = @"vip_grade_info_1_icon";
                break;
            case 2:
                _bigIcon = @"vip_grade_info_2_icon";
                break;
            case 3:
                _bigIcon = @"vip_grade_info_3_icon";
                break;
            default:
                break;
        }
    }
    return _bigIcon;
}

-(NSString *)headerIcon {
    if (!_headerIcon) {
        switch (self.upgradeType) {
            case 1:
                _headerIcon = @"iv_vip1";
                break;
            case 2:
                _headerIcon = @"iv_vip2";
                break;
            case 3:
                _headerIcon = @"iv_vip3";
                break;
            default:
                break;
        }
    }
    return _headerIcon;
}
@end
