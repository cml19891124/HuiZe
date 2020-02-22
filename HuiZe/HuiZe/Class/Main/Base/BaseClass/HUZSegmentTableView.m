//
//  HUZSegmentTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSegmentTableView.h"
#import "FORScrollViewEmptyAssistant.h"

@implementation HUZSegmentTableView


- (void)setDatas:(NSMutableArray *)datas{
    _datas = datas;
    [self reloadData];
}

- (instancetype)init {
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config{
    self.page = 1;
    self.size = 20;
    
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.dataSource = self;
    self.delegate = self;
    self.rowHeight = 45;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(60))];
    footerView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableFooterView =footerView;
    [self dz_registerCell:[UITableViewCell class]];
    self.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    return cell;
}

/// 显示无数据占图 包括占图,提示
- (void)configEmptyViewWithError:(NSString *)error{
    [self emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
        configer.emptyTitleFont = FontS(FONT_12);
        configer.emptyTitleColor = ColorS(COLOR_848484);
        configer.emptyTitle = error;
        configer.emptyImage = [error isEqualToString:EMPTYDATA] ? ImageNamed(EMPTYDATA_IMAGE) : ImageNamed(NETERROR_IMAGE);
    }];
}

/// 显示无数据占图 包括占图,提示,重新加载按钮
- (void)configEmptyViewWithErrorRequest:(NSString *)error{
    HUZWEAK_SELF
    [self emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
        configer.emptyTitleFont = FontS(FONT_12);
        configer.emptyTitleColor = ColorS(COLOR_848484);
        configer.emptyTitle = error;
        configer.emptyImage = [error isEqualToString:EMPTYDATA] ? ImageNamed(EMPTYDATA_IMAGE) : ImageNamed(NETERROR_IMAGE);
        configer.emptyBtnTitle = @"重新加载";
        configer.emptyBtnBackgroundImage = ImageNamed(@"btn_blue_bg");
        configer.emptyBtnClickBlock = ^{
            HUZSTRONG_SELF
            [strongSelf reloadDataAgain];
        };
    }];
}

- (void)reloadDataAgain{
    
}


-(void)setupRefresh{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onStartRefresh)];
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onStartLoadMore)];
//    [self.mj_footer endRefreshingWithNoMoreData];
    
}
-(void)onStartRefresh {
    
}
-(void)onStartLoadMore {
    
}
-(void)stopRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}
@end
