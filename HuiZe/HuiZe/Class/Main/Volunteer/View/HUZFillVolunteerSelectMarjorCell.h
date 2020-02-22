//
//  HUZFillVolunteerSelectMarjorCell.h
//  HuiZe
//
//  Created by tbb on 2019/11/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HUZUniInfoGeneralizeMajorModel;
@interface HUZFillVolunteerSelectMarjorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *minScoreLb;
@property (weak, nonatomic) IBOutlet UILabel *minRankingLb;
@property (weak, nonatomic) IBOutlet UILabel *admissionNumLb;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) HUZUniInfoGeneralizeMajorModel * majorModel;
@end

NS_ASSUME_NONNULL_END
