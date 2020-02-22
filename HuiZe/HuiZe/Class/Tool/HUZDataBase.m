//
//  HUZDataBase.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZDataBase.h"

@interface HUZDataBase ()

@property (nonatomic,strong,readwrite) NSArray *dataYear;
@property (nonatomic,strong,readwrite) NSArray *dataDroplineRanking;
@property (nonatomic,strong,readwrite) NSArray *dataEnterlineRanking;
@property (nonatomic,strong,readwrite) NSArray *dataBatch;
@property (nonatomic,strong,readwrite) NSArray *dataType;
@property (nonatomic,strong,readwrite) NSArray *dataSubject;
@property (nonatomic,strong,readwrite) NSArray *dataSchoolType;
@property (nonatomic,strong,readwrite) NSArray *dataSchoolBatch;
@end

@implementation HUZDataBase

+ (instancetype)shareDataBase{
    static HUZDataBase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        /// 获取年份
        instance.dataYear = @[@"2018",@"2017",@"2016"];
        
        /// 核心数据---投档线排序数据
        instance.dataDroplineRanking = @[@"投档最高分位次",@"投档平均分位次",@"投档最低分位次"];
        
        /// 核心数据---录取线排序数据
        instance.dataEnterlineRanking = @[@"录取最高分位次",@"录取最低分位次",@"录取平均分位次"];
        
        /// 招生计划---批次
        instance.dataBatch = @[@"本科批",@"本科一批",@"本科二批",@"本科三批",@"专科批",@"平行录取一段",@"平行录取二段",@"平行录取三段",@"本科提前批",@"国家专项计划本科批"];
        
        /// 招生计划---录取方式
        instance.dataType = @[@"录取人数",@"录取最低排名",@"录取最低分数"];
        
        /// 招生计划---文理
        instance.dataSubject = @[@"理科",@"文科",@"综合",@"体育",@"艺术文",@"艺术理"];
        
        /// 查大学---学校类型  学校类型：不限为-1 0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族
        instance.dataSchoolType = @[@"全部",@"综合",@"工科",@"师范",@"农业",@"医药",@"军事",@"林业",@"语言",@"财经",@"体育",@"艺术",@"政法",@"民族"];
        
        /// 推荐列表--学校层次
        instance.dataSchoolBatch = @[@"可冲击的大学",@"较稳妥的大学",@"可保底的大学"];
        
        
    });
    return instance;
}

//获取年份
+(void)getYearType:(NSInteger)type yearBlock:(void(^)(NSArray *yearArr))yearBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kUrl_Year_Type_List,@(type)];
    [HUZNetWorkTool huz_POSTWithForm:url parameters:nil success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if([codeStr integerValue] == 0) {
            NSArray *arr = responseObject[@"data"];
            NSMutableArray *yearArr = [NSMutableArray array];
            for (NSDictionary *dict in arr) {
                [yearArr addObject:dict[@"year"]];
            }
            if(yearBlock) {
                yearBlock(yearArr.copy);
            }
        }else{
//              [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//        [MBProgressHUD showError:error];
    }];
}
@end
