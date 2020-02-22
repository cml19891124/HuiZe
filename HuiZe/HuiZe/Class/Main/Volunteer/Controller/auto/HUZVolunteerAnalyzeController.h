//
//  HUZVolunteerAnalyzeController.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

#import "HUZIntelligenceFormDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteerAnalyzeController : HUZTableViewController

@property (strong, nonatomic) HUZIntelligenceFormDataModel * formModel;
@property (nonatomic, copy) NSString * volunteerId;

@property (nonatomic, assign) NSInteger reasonable;
@end

NS_ASSUME_NONNULL_END
