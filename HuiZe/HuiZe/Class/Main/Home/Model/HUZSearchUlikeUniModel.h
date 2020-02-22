//
//  HUZSearchUlikeUniModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchUlikeUniDataListUniModel : NSObject

@property (nonatomic,strong) NSString *schoolName; /// 大学名称
@property (nonatomic,strong) NSString *logoUrl;  /// 大学logo
@property (nonatomic,strong) NSString *provinceName; /// 城市
@property (nonatomic, copy) NSString * uniCity;
@end

@interface HUZSearchUlikeUniDataListModel : NSObject

@property (nonatomic,strong) NSString *year;   /// 年份
@property (nonatomic,strong) NSString *schoolId;  /// 学校id
@property (nonatomic,strong) NSString *admissionNum;  /// 录取人数
@property (nonatomic,strong) NSString *minRanking;  /// 最低排名
@property (nonatomic,strong) NSString *minScore;     /// 最低分
@property (nonatomic,strong) NSString *probability;  /// 概率
@property (nonatomic,strong) HUZSearchUlikeUniDataListUniModel *universityEntity;
@end

@interface HUZSearchUlikeUniDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZSearchUlikeUniDataListModel *> *list;

@end

@interface HUZSearchUlikeUniModel : HUZModel

@property (nonatomic,strong) HUZSearchUlikeUniDataModel *data;

@end

NS_ASSUME_NONNULL_END

