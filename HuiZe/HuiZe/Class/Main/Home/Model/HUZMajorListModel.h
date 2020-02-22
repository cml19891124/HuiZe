//
//  HUZMajorListModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorListModel : HUZModel

@property (nonatomic ,assign) NSInteger first_index;
@property (nonatomic ,assign) NSInteger second_index;
@property (nonatomic ,assign) NSInteger third_index;
@property (nonatomic ,assign) BOOL is_show;         //是否显示
@property (nonatomic ,assign) BOOL is_open;         //是否打开

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *majorId;

- (instancetype)initWithFirst_index:(NSInteger)first_index second_index:(NSInteger)second_index third_index:(NSInteger)third_index is_show:(BOOL)is_show is_open:(BOOL)is_open content:(NSString *)content majorId:(NSString *)majorId;

@end

NS_ASSUME_NONNULL_END
