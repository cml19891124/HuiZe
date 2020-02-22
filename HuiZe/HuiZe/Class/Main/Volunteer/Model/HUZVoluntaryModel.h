//
//  HUZVoluntaryModel.h
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface HUZVoluntary : NSObject

@property (nonatomic,strong) NSString *category; // 专业名称
@property (nonatomic,strong) NSString *majorAllEntity; //
@property (nonatomic,strong) NSString *majorAllId; // 专业id ,
@property (nonatomic,strong) NSString *schoolName; // 大学名称
@property (nonatomic,strong) NSString *year; // 年份

@property (nonatomic,strong) NSString *admissionNum; // 录取人数
@property (nonatomic,strong) NSString *average; //  平均分
@property (nonatomic,strong) NSString *batch; // 批次 ,
@property (nonatomic,strong) NSString *grade; // 文理科：0文教，1理科
@property (nonatomic,strong) NSString *id; //
@property (nonatomic,strong) NSString *maxScore; //  最高分
@property (nonatomic,strong) NSString *minRanking; // 最低排名
@property (nonatomic,strong) NSString *minScore; /// 录取最低分 ,
@property (nonatomic,strong) NSString *recruitAddress; //
@property (nonatomic,strong) NSString *schoolId; // 大学id

@end

@interface HUZVoluntaryListModel : NSObject
@property (nonatomic,strong) NSString *category;          /// 父级名称
@property (nonatomic, copy) NSString * planNum;
@property (nonatomic, copy) NSString * majIntroduce;
@property (nonatomic,strong) HUZVoluntary *admissionMajorEntity;     /// 专业对象
@property (nonatomic,strong) NSString *majorAllEntityList;     /// 子级列表
@property (nonatomic,strong) NSString *majorAllId;
@property (nonatomic, strong) NSString *majorId;

@property (nonatomic,strong) NSString *year; // 年份
@property (nonatomic,assign) BOOL alternative; // 是否备选

@property (nonatomic,strong) NSString *admissionNum; // 录取人数
@property (nonatomic,strong) NSString *average; //  平均分
@property (nonatomic,strong) NSString *batch; // 批次 ,
@property (nonatomic,strong) NSString *grade; // 文理科：0文教，1理科
@property (nonatomic,strong) NSString *id; //
@property (nonatomic,strong) NSString *maxScore; //  最高分
@property (nonatomic,strong) NSString *minRanking; // 最低排名
@property (nonatomic,strong) NSString *minScore; /// 录取最低分 ,
@property (nonatomic,strong) NSString *recruitAddress; //
@property (nonatomic,strong) NSString *schoolId; // 大学id

@property (nonatomic, assign,getter=isSelect) BOOL select;
@end

@interface HUZVoluntaryModel : HUZModel
@property (nonatomic,strong) NSArray <HUZVoluntaryListModel*> *data;

@end

NS_ASSUME_NONNULL_END
