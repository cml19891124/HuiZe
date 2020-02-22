//
//  HUZIntelligenceFormDataModel.h
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZIntelligenceFormModel,HUZCompletenessModel,HUZRationalityListModel,HUZOptimizationNumberModel,HUZRationalityNumber,HUZMajorModel;

NS_ASSUME_NONNULL_BEGIN

@interface HUZIntelligenceFormDataModel : HUZModel

@property (strong, nonatomic) HUZIntelligenceFormModel *data;

@end

@interface HUZIntelligenceFormModel : HUZModel

@property (strong, nonatomic) NSArray <HUZCompletenessModel *>*completenessList;

@property (strong, nonatomic) NSArray <HUZOptimizationNumberModel *>*optimizationNumber;

@property (strong, nonatomic) NSArray <HUZRationalityListModel *>*rationalityList;

@property (strong, nonatomic) NSArray <HUZRationalityNumber *>*rationalityNumber;

@property (strong, nonatomic) NSArray <HUZMajorModel *>*major;

@end


@interface HUZMajorModel : HUZModel

@property (nonatomic, copy) NSString *Reasonable;

@property (nonatomic, copy) NSString *type;

@end

@interface HUZCompletenessModel : HUZModel

@property (nonatomic, copy) NSString *Reasonable;

@property (nonatomic, copy) NSString *type;

@end

@interface HUZOptimizationNumberModel : HUZModel

@property (nonatomic, assign) NSInteger modify;

@end

@interface HUZRationalityListModel : HUZModel

@property (nonatomic, copy) NSString *Reasonable;

@property (nonatomic, copy) NSString *type;

@end

@interface HUZRationalityNumber : HUZModel

@property (nonatomic, copy) NSString *opinion;

@end

NS_ASSUME_NONNULL_END
