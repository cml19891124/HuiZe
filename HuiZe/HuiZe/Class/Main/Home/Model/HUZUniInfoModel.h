//
//  HUZUniInfoModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniInfoDataModel : NSObject

@property (nonatomic,strong) NSString *schoolId;   /// 学校id
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *schoolNumber; /// 学校电话
@property (nonatomic,strong) NSString *keyOne;  /// 是否985
@property (nonatomic,strong) NSString *keyTwo;  /// 是否211
@property (nonatomic,strong) NSString *logoUrl;  /// logo
@property (nonatomic,strong) NSString *provinceName; /// 城市名
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * uniCity;
@property (nonatomic,strong) NSString *opinions;  /// 报考意见
@property (nonatomic,strong) NSString *schoolType; /// 学校类型：0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族
@property (nonatomic,strong) NSString *category;  /// 0本科 1专科
@property (nonatomic,strong) NSString *schoolPrivate;  /// 0公立 1私立

@property (nonatomic, assign) BOOL attention;

@property (nonatomic, assign) BOOL pkSchool;

@end

@interface HUZUniInfoModel : HUZModel

@property (nonatomic,strong) HUZUniInfoDataModel *data;

@end

NS_ASSUME_NONNULL_END
