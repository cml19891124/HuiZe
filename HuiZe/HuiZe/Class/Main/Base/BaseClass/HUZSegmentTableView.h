//
//  HUZSegmentTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "SHTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSegmentTableView : SHTableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) int page;
@property (nonatomic,assign) int size;

/// 数据源
@property (nonatomic,strong) NSArray *datas;


/// 显示无数据占图 包括占图,提示
- (void)configEmptyViewWithError:(NSString *)error;
/// 显示无数据占图 包括占图,提示,重新加载按钮
- (void)configEmptyViewWithErrorRequest:(NSString *)error;
/// 重载数据
- (void)reloadDataAgain;

-(void)setupRefresh;
-(void)onStartRefresh;
-(void)onStartLoadMore;
-(void)stopRefresh;
@end

NS_ASSUME_NONNULL_END
