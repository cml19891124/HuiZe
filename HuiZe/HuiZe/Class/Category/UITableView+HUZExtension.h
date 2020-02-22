//
//  UITableView+HUZExtension.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HUZExtension)
/**
 * 使用以下两个方法注册的cell，identifier和类名保持一致
 * 推荐使用类名做cell的标识符
 * 使用该方法获取identifier字符串：
 * NSString *identifier = NSStringFromClass([UITableViewCell class])
 */
- (void)dz_registerCell:(Class)cls;
- (void)dz_registerNibCell:(Class)cls;

- (void)dz_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;
- (void)dz_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)dz_registerHeaderFooterViewView:(Class)cls;
- (void)dz_registerHeaderFooterViewNibView:(Class)cls;

- (void)dz_registerHeaderFooterView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier;
- (void)dz_registerHeaderFooterNibView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier;
@end

NS_ASSUME_NONNULL_END
