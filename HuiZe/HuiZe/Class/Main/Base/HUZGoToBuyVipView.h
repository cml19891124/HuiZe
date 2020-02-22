//
//  HUZGoToBuyVipView.h
//  HuiZe
//
//  Created by tbb on 2019/9/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZGoToBuyVipView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;
@property (weak, nonatomic) IBOutlet UIButton *goToVipBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConst;
@end

NS_ASSUME_NONNULL_END

