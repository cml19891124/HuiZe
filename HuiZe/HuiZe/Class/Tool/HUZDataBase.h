//
//  HUZDataBase.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZDataBase : NSObject

+ (instancetype)shareDataBase;

/// 核心数据---获取年份数据
@property (nonatomic,strong,readonly) NSArray *dataYear;

/// 核心数据---投档线排序数据
@property (nonatomic,strong,readonly) NSArray *dataDroplineRanking;

/// 核心数据---录取线排序数据
@property (nonatomic,strong,readonly) NSArray *dataEnterlineRanking;

/// 招生计划---批次
@property (nonatomic,strong,readonly) NSArray *dataBatch;

/// 招生计划---录取方式
@property (nonatomic,strong,readonly) NSArray *dataType;

/// 招生计划---文理
@property (nonatomic,strong,readonly) NSArray *dataSubject;

/// 查大学---学校类型
@property (nonatomic,strong,readonly) NSArray *dataSchoolType;

/// 推荐列表--学校层次
@property (nonatomic,strong,readonly) NSArray *dataSchoolBatch;

//获取年份 kUrl_Year_Type_List
+(void)getYearType:(NSInteger)type yearBlock:(void(^)(NSArray *yearArr))yearBlock;
@end

NS_ASSUME_NONNULL_END
