//
//  HUZFillVolunteerController.h
//  HuiZe
//
//  Created by tbb on 2019/10/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUZTableViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HUZFillVolunteerController : HUZTableViewController
@property (nonatomic, strong) NSDictionary *volunteerDict;
@property (nonatomic, copy) NSString * volunteerId;
@property (nonatomic, copy) NSString * volunteerNmae;
@end

NS_ASSUME_NONNULL_END


