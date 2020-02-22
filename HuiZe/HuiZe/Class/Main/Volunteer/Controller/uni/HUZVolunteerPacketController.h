//
//  HUZVolunteerPacketController.h
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

#import "HUZPacketVolModel.h"

typedef void(^SchoolInfoBlock)(NSDictionary * _Nullable postDic,HUZPacketVolListModel * _Nullable model);

NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteerPacketController : HUZTableViewController

@property (nonatomic, copy) SchoolInfoBlock schoolBlcok;

@property (nonatomic, copy) NSString * batch;

@end

NS_ASSUME_NONNULL_END

