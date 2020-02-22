//
//  HUZPPPSelectView.h
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//  弹出单选列表

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

@class HUZPPPSelectView;

@protocol HUZPPPSelectViewDelegate <NSObject>

@optional
/**
 选择后代理方法
 @param result 选择的数据
 */
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView result:(NSString *)result;


- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result;

@end

@interface HUZPPPSelectView : HUZView
@property (copy, nonatomic) NSString *headTitle;
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据源
@property (weak, nonatomic) id <HUZPPPSelectViewDelegate> delegate;

/**
 显示  必须调用
 */
- (void)show;
@end

NS_ASSUME_NONNULL_END
