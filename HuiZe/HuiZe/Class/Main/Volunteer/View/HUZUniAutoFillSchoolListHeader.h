//
//  HUZUniAutoFillSchoolListHeader.h
//  HuiZe
//
//  Created by tbb on 2019/11/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HUZUniAutoFillSchoolListModel;
@interface HUZUniAutoFillSchoolListHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *indexLb;
@property (weak, nonatomic) IBOutlet UIImageView *logoIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *cityLb;

@property (nonatomic, strong) HUZUniAutoFillSchoolListModel * schoolModel;

@end

NS_ASSUME_NONNULL_END
