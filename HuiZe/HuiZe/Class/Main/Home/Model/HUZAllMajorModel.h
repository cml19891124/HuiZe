//
//  HUZAllMajorModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/13.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZAllMajorDataThirdModel : NSObject

@property (nonatomic,strong) NSString *majorAllId;  /// 专业id
@property (nonatomic,strong) NSString *category;    /// 专业名称

@end

@interface HUZAllMajorDataSecondModel : NSObject

@property (nonatomic,strong) NSString *majorAllId;  /// 专业id
@property (nonatomic,strong) NSString *category;    /// 专业名称
@property (nonatomic,strong) NSArray<HUZAllMajorDataThirdModel *> *majorAllEntityList;  /// 三级列表

@end

@interface HUZAllMajorDataFirstModel : NSObject

@property (nonatomic,strong) NSString *majorAllId;  /// 专业id
@property (nonatomic,strong) NSString *category;    /// 专业名称
@property (nonatomic,strong) NSArray<HUZAllMajorDataSecondModel *> *majorAllEntityList;  /// 二级列表

@end

@interface HUZAllMajorModel : HUZModel

@property (nonatomic,strong) NSArray<HUZAllMajorDataFirstModel *> *data;  /// 一级列表

@end

NS_ASSUME_NONNULL_END
