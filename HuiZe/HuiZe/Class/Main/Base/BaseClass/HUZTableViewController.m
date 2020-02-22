//
//  HUZTableViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"
#import "FORScrollViewEmptyAssistant.h"

@interface HUZTableViewController ()

@end

@implementation HUZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)configComponents{
    [super configComponents];
    
    self.page = 1;
    self.size = 20;
    [self configStyle];
    self.cellHeight = 40.f;
    self.dataSource = [NSMutableArray new];

    
    /// FIXED: 纯代码布局，子类如果重新布局，建议用Masonry重新设置约束
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
    // 注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    self.tableView = tableView;

}
/// tableView style
- (void)configStyle{
    if (!self.style) {
        self.style = UITableViewStylePlain;
    }
}

/// duqueueReusavleCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //是否有分段
    if (self.shouldMultiSections) return self.dataSource?self.dataSource.count : 1;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.shouldMultiSections) return [self.dataSource[section] count];
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    // fetch object
    id object = nil;
//    if (self.shouldMultiSections) object = self.dataSource[indexPath.section][indexPath.row];
    if (!self.shouldMultiSections) object = self.dataSource[indexPath.row];
    
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}


/// 显示无数据占图 包括占图,提示
- (void)configEmptyViewWithError:(NSString *)error{
    [self.tableView emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
        configer.emptyTitleFont = FontS(FONT_12);
        configer.emptyTitleColor = ColorS(COLOR_848484);
        configer.emptyTitle = error;
        configer.emptyImage = [error isEqualToString:EMPTYDATA] ? ImageNamed(EMPTYDATA_IMAGE) : ImageNamed(NETERROR_IMAGE);
    }];
}

/// 显示无数据占图 包括占图,提示,重新加载按钮
- (void)configEmptyViewWithErrorRequest:(NSString *)error{
    HUZWEAK_SELF
    [self.tableView emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
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
/// 重载数据
- (void)reloadDataAgain{}

@end
