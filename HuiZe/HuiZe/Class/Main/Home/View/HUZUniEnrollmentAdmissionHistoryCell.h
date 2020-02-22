//
//  HUZUniEnrollmentAdmissionHistoryCell.h
//  HuiZe
//
//  Created by tbb on 2019/11/19.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HUZUniEnrollmentAdmissionHistoryModel;
@interface HUZUniEnrollmentAdmissionHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *batchLb;
@property (weak, nonatomic) IBOutlet UILabel *maxLb;
@property (weak, nonatomic) IBOutlet UILabel *minLb;
@property (weak, nonatomic) IBOutlet UILabel *plaNumLb;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, strong) HUZUniEnrollmentAdmissionHistoryModel * historyModel;

@end

NS_ASSUME_NONNULL_END
