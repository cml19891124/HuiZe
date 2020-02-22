//
//  HUZUlikeUniViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUlikeUniViewController : HUZTableViewController

@property (nonatomic,assign) int type;  /// 1-猜你喜欢  2-名企热招

@property (nonatomic,assign) int category; /// 批次  不限为-1 其他从0开始
@property (nonatomic,assign) int address; /// 地区 不限为-1 其他从0开始
@property (nonatomic,assign) int keyOne;  ///著名大学 不限为-1 其他从0开始
@property (nonatomic,assign) int schoolPrivate; ///大学性质 不限为-1 其他从0开始
@property (nonatomic,assign) int schoolType;  /// 大学类型 不限为-1 其他从0开始

/// 刷新猜你喜欢模块
- (void)reloadUlikeListWithCategory:(int)category address:(int)address keyOne:(int)keyOne schoolPrivate:(int)schoolPrivate schoolType:(int)schoolType;

@end

NS_ASSUME_NONNULL_END
