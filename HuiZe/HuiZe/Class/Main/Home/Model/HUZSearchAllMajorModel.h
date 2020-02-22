//
//  HUZSearchAllMajorModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/13.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchAllMajorDataListModel : NSObject

@property (nonatomic,strong) NSString *majorAllId;  /// 专业id
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *category;  /// 专业名称
@property (nonatomic,strong) NSString *undergraduate; /// 0本科 1专科

@end

@interface HUZSearchAllMajorDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZSearchMajorDataListModel *> *list;

@end

@interface HUZSearchAllMajorModel : HUZModel

@property (nonatomic,strong) HUZSearchAllMajorDataModel *data;

@end

NS_ASSUME_NONNULL_END
