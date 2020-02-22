//
//  HUZRecommendMajorModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/11.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZRecommendMajorDataModel : NSObject
@property (nonatomic, copy) NSString * schoolNameTem;
@property (nonatomic, copy) NSString * zhuanyeNameTem;
@property (nonatomic, copy) NSString * minScore;
@property (nonatomic, copy) NSString * year;
@property (nonatomic, copy) NSString * schoolId;
@property (nonatomic,strong) NSString *Id;
@property (nonatomic,strong) NSString *category;   /// 专业名称
@property (nonatomic,strong) NSString *major;    /// 一级专业名称
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *admissionNum;  /// 录取人数
@property (nonatomic,strong) NSString *logoUrl;  /// 大学logo
@property (nonatomic,strong) NSString *majorAllId; /// 专业id


@end

@interface HUZRecommendMajorModel : HUZModel

@property (nonatomic,strong) NSArray<HUZRecommendMajorDataModel *> *data;

@end

NS_ASSUME_NONNULL_END

