//
//  HUZSearchUniListViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchUniListViewController : HUZTableViewController

@property (nonatomic,assign) int category; /// 批次  不限为-1 其他从0开始
@property (nonatomic,assign) int address; /// 地区 不限为-1 其他从0开始
@property (nonatomic,assign) int keyOne;  ///著名大学 不限为-1 其他从0开始
@property (nonatomic,assign) int schoolPrivate; ///大学性质 不限为-1 其他从0开始
@property (nonatomic,assign) int schoolType;  /// 大学类型 从0开始
@property (nonatomic,strong) NSString *examinationProvince; /// 省份id  本省大学需要传
@property (nonatomic, assign) NSInteger type;//0全部高校，1本省高校
/// 筛选刷新数据
- (void)reloadDataWithCategory:(int)category address:(int)address keyOne:(int)keyOnde schoolPrivate:(int)schoolPrivate schoolType:(int)schoolType;

@end

NS_ASSUME_NONNULL_END
