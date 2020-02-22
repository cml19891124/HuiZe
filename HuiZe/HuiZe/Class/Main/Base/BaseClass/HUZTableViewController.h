//
//  HUZTableViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZTableViewController : HUZViewController<UITableViewDelegate,UITableViewDataSource>

/// 显示无数据占图 包括占图,提示
- (void)configEmptyViewWithError:(NSString *)error;
/// 显示无数据占图 包括占图,提示,重新加载按钮
- (void)configEmptyViewWithErrorRequest:(NSString *)error;
/// 重载数据
- (void)reloadDataAgain;

/// 当前列表
@property (nonatomic,strong) UITableView *tableView;

/// tableView‘s style defalut is UITableViewStylePlain , 只适合 UITableView 有效
@property (nonatomic,assign) UITableViewStyle style;
/// 设置 tableView style,子类可以重写
- (void)configStyle;

/// 是否数据是多段   defalut is NO
@property (nonatomic,assign) BOOL shouldMultiSections;

/// 默认行高
@property (nonatomic,assign) CGFloat cellHeight;
/// 页数
@property (nonatomic,assign) int page;
/// 每页条数
@property (nonatomic,assign) int size;

@property (nonatomic,strong) NSMutableArray *dataSource;

/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end

NS_ASSUME_NONNULL_END
