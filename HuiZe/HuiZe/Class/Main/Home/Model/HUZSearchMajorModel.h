//
//  HUZSearchMajorModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/13.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchMajorDataListModel : NSObject

@property (nonatomic,strong) NSString *majorId;  /// 专业id
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *category;  /// 专业名称
@property (nonatomic,strong) NSString *undergraduate; /// 0本科 1专科
@property (nonatomic, copy) NSString * majorAllId;
@property (nonatomic, copy) NSString * schoolCategory;
@property (nonatomic, copy) NSString * schoolId;
@end

@interface HUZSearchMajorDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZSearchMajorDataListModel *> *list;

@end

@interface HUZSearchMajorModel : HUZModel

@property (nonatomic,strong) HUZSearchMajorDataModel *data;

@end

NS_ASSUME_NONNULL_END
