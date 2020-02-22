//
//  HUZFocusSchoolModel.h
//  HuiZe
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZFocusSchoolDataListDetailModel : NSObject

@property (nonatomic,strong) NSString *deliveryScore; /// 投档最低分
@property (nonatomic,strong) NSString *minRanking;   /// 最多投档位次

@end

@interface HUZFocusSchoolDataListModel : NSObject

@property (nonatomic,strong) NSString *schoolId;   /// 学校id
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *address;    /// 城市id
@property (nonatomic,strong) NSString *logoUrl;    /// 学校logo
@property (nonatomic,strong) NSString *provinceName; /// 城市名称
@property (nonatomic,strong) NSString *majorAllEntity; ///
@property (nonatomic,strong) NSString *majorAllId; ///
@property (nonatomic,strong) NSString *type; ///
@property (nonatomic,strong) NSString *followId; /// 关注ID
@property (nonatomic,strong) HUZSearchUniDataListDetailModel *universityEntity;

@end

@interface HUZFocusSchoolDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZFocusSchoolDataListModel *> *list;

@end

@interface HUZFocusSchoolModel : HUZModel
@property (nonatomic,strong) HUZFocusSchoolDataModel *data;
@end

NS_ASSUME_NONNULL_END
