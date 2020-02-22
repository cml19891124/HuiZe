//
//  HUZSearchUniModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/13.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchUniDataListDetailModel : NSObject

@property (nonatomic,strong) NSString *deliveryScore; /// 投档最低分
@property (nonatomic,strong) NSString *minRanking;   /// 最多投档位次

@end

@interface HUZSearchUniDataListModel : NSObject

@property (nonatomic,strong) NSString *schoolId;   /// 学校id
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *address;    /// 城市id
@property (nonatomic,strong) NSString *logoUrl;    /// 学校logo
@property (nonatomic,strong) NSString *provinceName; /// 城市名称
@property (nonatomic,strong) NSString *followId; /// 关注ID
@property (nonatomic,strong) HUZSearchUniDataListDetailModel *deliveryDetailsEntity;

@end

@interface HUZSearchUniDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZSearchUniDataListModel *> *list;

@end

@interface HUZSearchUniModel : HUZModel

@property (nonatomic,strong) HUZSearchUniDataModel *data;

@end

NS_ASSUME_NONNULL_END
