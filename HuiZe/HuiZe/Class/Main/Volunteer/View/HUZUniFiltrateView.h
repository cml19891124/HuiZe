//
//  HUZUniFiltrateView.h
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^FiltrateViewBlock)(NSString *category,NSString *address,NSString *keyOne,NSString *schoolPrivate,NSString *schoolType,NSString *score);
@interface HUZUniFiltrateView : HUZView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *scrArray;
@property(nonatomic,copy)FiltrateViewBlock sendBlock;

@property (strong, nonatomic) NSMutableArray *provinceArray;
/**
 筛选条件的各种属性
 */
@property (nonatomic, copy) NSString *category;//批次
@property (nonatomic, copy) NSString *address;//大学所在地省份id

@property (nonatomic, copy) NSString *keyOne;//1代表985，2代表211，3代表双一流

@property (nonatomic, copy) NSString *schoolPrivate;//学校性质（0 公办 1民办

@property (nonatomic, copy) NSString *schoolType;//学校类型（0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族）
@property (nonatomic, copy) NSString *score;

@property (nonatomic, assign) BOOL selectedModel;
@end

NS_ASSUME_NONNULL_END
