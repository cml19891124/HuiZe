//
//  HUZUniInfoCommonTextCell.h
//  HuiZe
//
//  Created by tbb on 2019/9/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniInfoCommonTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConst;

@end

NS_ASSUME_NONNULL_END
