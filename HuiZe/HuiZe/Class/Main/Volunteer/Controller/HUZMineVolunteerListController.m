//
//  HUZMineVolunteerListController.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMineVolunteerListController.h"
#import "HUZMineVolunteerCell.h"
#import "HUZVolunteerService.h"
#import "HUZVolunteerModel.h"

#import "HUZVolunteerDetailController.h"
#import "HUZFillVolunteerController.h"
@interface HUZMineVolunteerListController ()<KSSideslipCellDelegate>
@property (strong, nonatomic) UIButton *addBtn;
@property (nonatomic) NSIndexPath *indexPath;
@end

@implementation HUZMineVolunteerListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的志愿表";
    [self setupNavLeftItem];
}

-(void)setupNavLeftItem {
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 20.0, 20.0)];//
    
    [back setImage:[[UIImage imageNamed:NAV_BACK_BLACK] yq_imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [back addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    back.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
-(void)leftItemAction:(UIButton *)sender {
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    if (self.barckVc == nil) {
        [self.navigationController popViewControllerAnimated:true];
    }else if ([self.barckVc isEqualToString:@"HUZFillVolunteerController"]) {
        [self.navigationController popToRootViewControllerAnimated:true];
    } else{
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[NSClassFromString(self.barckVc) class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //修改返回按钮和导航栏标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = ColorS(COLOR_BG_163A6B);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (void)configComponents{
    [super configComponents];
    
    self.view.backgroundColor = ColorS(COLOR_BG_163A6B);
    self.cellHeight = AutoDistance(90);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.tableView dz_registerCell:[HUZMineVolunteerCell class]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(AutoDistance(24));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
        make.bottom.equalTo(self.view);
    }];
    
    self.addBtn = [[UIButton alloc]initWithImageNormal:@"ico_btn_add_big" imageHighlight:@"ico_btn_add_big"];
    [self.addBtn addTarget:self action:@selector(addTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
     [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_offset(-AutoDistance(11));
         make.bottom.mas_offset(-AutoDistance(51));
         make.size.sizeOffset(CGSizeMake(AutoDistance(79), AutoDistance(79)));
     }];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf configDatas];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf configDatas];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)configDatas {
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZVolunteerService getVolunteerListWithParamters:@{@"pageNow":@(self.page),@"pageSize":@(self.size)} success:^(HUZVolunteerModel * _Nonnull volunteerModel) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:volunteerModel.data.list];
        if (DRArrayIsEmpty(self.dataSource)) {
            [strongSelf configEmptyViewWithError:EMPTYDATA];
            strongSelf.view.backgroundColor = COLOR_BG_WHITE;
            strongSelf.tableView.backgroundColor = strongSelf.view.backgroundColor;
        }
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)configStyle {
    self.style = UITableViewStyleGrouped;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZMineVolunteerCell *cell = [HUZMineVolunteerCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    cell.delegate = self;
    
    HUZVolunteer *model = self.dataSource[indexPath.section];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HUZVolunteer *model = self.dataSource[indexPath.section];

    HUZVolunteerDetailController *detailvc = [HUZVolunteerDetailController new];
    detailvc.ID = model.Id;
    detailvc.volatileTitle = model.volunteerName;
    [self.navigationController pushViewController:detailvc animated:YES];
}

- (void)addTap {
    // 手动填报
    [self.navigationController pushViewController:[[NSClassFromString(@"HUZFillVolunteerController") alloc]init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoDistance(24);
    }
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AutoDistance(18);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

#pragma mark - KSSideslipCellDelegate
- (NSArray<KSSideslipCellAction *> *)sideslipCell:(KSSideslipCell *)sideslipCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    KSSideslipCellAction *action = [KSSideslipCellAction rowActionWithStyle:KSSideslipCellActionStyleDestructive title:@"删除" handler:^(KSSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击删除");
    }];
    NSArray *array =  @[action];
    return array;
}

- (BOOL)sideslipCell:(KSSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UIView *)sideslipCell:(KSSideslipCell *)sideslipCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index {
//    self.indexPath = indexPath;
    
    self.indexPath = [self.tableView indexPathForCell:sideslipCell];

    UIButton * view =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 135, 0)];
    view.titleLabel.textAlignment = NSTextAlignmentCenter;
    view.titleLabel.font = [UIFont systemFontOfSize:17];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view setTitle:@"确认删除" forState:UIControlStateNormal];
    view.backgroundColor = [UIColor redColor];
    [view addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (void)delBtnClick{
    HUZVolunteer *vol = self.dataSource[self.indexPath.section];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:vol.Id forKey:@"id"];
    [self displayOverFlowActivityView];
    HUZWEAK_SELF;
    [HUZVolunteerService delVolunteerWithParamters:postDic success:^(NSString * _Nonnull success) {
        [weakSelf.dataSource removeObjectAtIndex:self.indexPath.row];
        [weakSelf removeOverFlowActivityView];
        [weakSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf configEmptyViewWithError:errorStr];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
//已使用第三方，无须调用系统自带的删除方法处理UI
    //    [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
@end
//
