//
//  HUZFocusMajorModel.h
//  HuiZe
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZFocusMajorDataListDetailModel : NSObject

@property (nonatomic,strong) NSString *minScore; /// 录取最低分 ,
@property (nonatomic,strong) NSString *minRanking; // 最低排名
@property (nonatomic,strong) NSString *maxScore; //  最高分
@property (nonatomic,strong) NSString *admissionNum; // 录取人数
@property (nonatomic,strong) NSString *average; //  平均分
@property (nonatomic,strong) NSString *batch; // 批次 ,
@property (nonatomic,strong) NSString *category; // 专业名称
@property (nonatomic,strong) NSString *grade; // 文理科：0文教，1理科
@property (nonatomic,strong) NSString *majorAllEntity; //
@property (nonatomic,strong) NSString *majorAllId; // 专业id ,
@property (nonatomic,strong) NSString *recruitAddress; //
@property (nonatomic,strong) NSString *schoolId; // 大学id
@property (nonatomic,strong) NSString *schoolName; // 大学名称
@property (nonatomic,strong) NSString *year; // 年份

@end

@interface HUZFocusMajorDataListModel : NSObject
@property (nonatomic, copy) NSString * oneCategory;
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * twoCategory;

@property (nonatomic,strong) NSString *schoolId;   /// 学校id
@property (nonatomic,strong) NSString *userId; /// 用户ID
@property (nonatomic,strong) NSString *logoUrl;    /// 学校logo
@property (nonatomic,strong) NSString *majorAllEntity; ///
@property (nonatomic,strong) NSString *majorAllId; ///
@property (nonatomic,strong) NSString *type; ///
@property (nonatomic,strong) NSString *followId; /// 关注ID
@property (nonatomic,strong) HUZFocusMajorDataListDetailModel *universityEntity;

@end

@interface HUZFocusMajorDataModel : HUZListModel
@property (nonatomic,strong) NSArray<HUZFocusMajorDataListModel *> *list;

@end

@interface HUZFocusMajorModel : HUZModel
@property (nonatomic,strong) HUZFocusMajorDataModel *data;

@end

NS_ASSUME_NONNULL_END
