//
//  HUZFillVolunteerUniversityMajorCell.h
//  HuiZe
//
//  Created by tbb on 2019/10/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HUZUniInfoGeneralizeMajorModel;
@interface HUZFillVolunteerUniversityMajorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (nonatomic, strong) HUZUniInfoGeneralizeMajorModel * majorModel;
@end

NS_ASSUME_NONNULL_END
