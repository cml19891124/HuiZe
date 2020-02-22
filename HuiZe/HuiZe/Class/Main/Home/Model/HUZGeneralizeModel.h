//
//  HUZGeneralizeModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGeneralizeDataRegionModel : NSObject

@property (nonatomic,strong) NSString *regionId;
@property (nonatomic,strong) NSString *areaName;  /// 地区
@end

@interface HUZGeneralizeDataIndustyModel : NSObject

@property (nonatomic,strong) NSString *industryId;
@property (nonatomic,strong) NSString *industryName;  /// 行业

@end

@interface HUZGeneralizeDataModel : NSObject

@property (nonatomic,strong) HUZGeneralizeDataIndustyModel *industryEntity;
@property (nonatomic,strong) HUZGeneralizeDataRegionModel *regionEntity;

@end

@interface HUZGeneralizeModel : HUZModel

@property (nonatomic,strong) HUZGeneralizeDataModel *data;

@end

NS_ASSUME_NONNULL_END
