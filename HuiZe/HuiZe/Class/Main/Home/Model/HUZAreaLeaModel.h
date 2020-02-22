//
//  HUZAreaLeaModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZAreaLeaDataListRegionModel : NSObject

@property (nonatomic,strong) NSString *areaName;  /// 地区名称

@end

@interface HUZAreaLeaDataListLeaModel : NSObject

@property (nonatomic,strong) NSString *proportion;  /// 占比

@end

@interface HUZAreaLeaDataListModel : NSObject

@property (nonatomic,strong) HUZAreaLeaDataListLeaModel *leaTowardsEntity;
@property (nonatomic,strong) HUZAreaLeaDataListRegionModel *regionEntity;

@end

@interface HUZAreaLeaDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZAreaLeaDataListModel *> *list;

@end

@interface HUZAreaLeaModel : HUZModel

@property (nonatomic,strong) HUZAreaLeaDataModel *data;

@end

NS_ASSUME_NONNULL_END
