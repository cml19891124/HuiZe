//
//  HUZUniSelectController.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

#import "HUZSchoolListDataModel.h"

#import "HUZPacketVolModel.h"

typedef void(^AllSchoolInfoBlock)(NSDictionary * _Nullable postDic,HUZPacketVolListModel * _Nullable model);

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectBlock)(HUZSchoolModel *model);
@interface HUZUniSelectController : HUZTableViewController
@property(nonatomic,copy) SelectBlock selectBlock;

@property (nonatomic, copy) NSString *batch;

@property (nonatomic, copy) AllSchoolInfoBlock allBlock;
@end

NS_ASSUME_NONNULL_END
