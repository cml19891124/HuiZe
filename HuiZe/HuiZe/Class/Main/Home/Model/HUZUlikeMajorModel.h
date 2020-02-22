//
//  HUZUlikeMajorModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/13.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUlikeMajorDataListModel : NSObject

@property (nonatomic,strong) NSString *Id;
@property (nonatomic,strong) NSString *maxScore;  /// 最高分
@property (nonatomic,strong) NSString *average;
@property (nonatomic,strong) NSString *minScore;  /// 最低分
@property (nonatomic,strong) NSString *minRanking;   /// 最低排名
@property (nonatomic,strong) NSString *admissionNum; /// 录取人数
@property (nonatomic, copy) NSString * planNum;
@property (nonatomic,strong) NSString *schoolName;  /// 学校名称
@property (nonatomic,strong) NSString *category;  /// 专业名称
@property (nonatomic, copy) NSString * majorAllId;

@property (nonatomic, copy) NSString * zhuanyeNameTem;
@property (nonatomic, copy) NSString * schoolNameTem;

@property (nonatomic, copy) NSString * year;
@property (nonatomic, copy) NSString * schoolId;

@end

@interface HUZUlikeMajorDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZUlikeMajorDataListModel *> *list;

@end

@interface HUZUlikeMajorModel : HUZModel

@property (nonatomic,strong) HUZUlikeMajorDataModel *data;
@end

NS_ASSUME_NONNULL_END
