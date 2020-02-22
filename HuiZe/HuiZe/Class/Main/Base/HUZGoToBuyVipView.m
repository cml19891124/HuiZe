//
//  HUZGoToBuyVipView.m
//  HuiZe
//
//  Created by tbb on 2019/9/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGoToBuyVipView.h"
#import "HUZMyVipCardViewController.h"
@implementation HUZGoToBuyVipView
- (IBAction)goToVipAction:(UIButton *)sender {
    HUZMyVipCardViewController *myVipCardVC = [HUZMyVipCardViewController new];
    [self.YQViewController.navigationController pushViewController:myVipCardVC animated:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    HUZWEAK_SELF
    [self.goToVipBtn addTapAction:^(id  _Nonnull sender) {
        HUZMyVipCardViewController *vipVC = [[HUZMyVipCardViewController alloc] init];
        [weakSelf.YQViewController.navigationController pushViewController:vipVC animated:true];
    }];
}

@end

