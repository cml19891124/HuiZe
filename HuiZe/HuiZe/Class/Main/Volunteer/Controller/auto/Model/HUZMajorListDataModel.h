//
//  HUZMajorListDataModel.h
//  HuiZe
//
//  Created by caominglei on 2019/5/23.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZMajorDataListModel;
NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorListDataModel : HUZModel

@property (strong, nonatomic) NSArray *data;

@end


@interface HUZMajorDataListModel : HUZModel

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *majorAllId;

@property (nonatomic, copy) NSString *isSelected;
@end
NS_ASSUME_NONNULL_END
