//
//  HUZUniPkListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniPkListViewController.h"
#import "HUZPkListHeaderView.h"
#import "HUZPkListCell.h"

@interface HUZUniPkListViewController ()

@property (nonatomic,strong) UIButton *btnPK;
@property (nonatomic,strong) NSMutableArray *dataSelect; //加入PK的院校

@end

@implementation HUZUniPkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.title = @"PK列表";
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSelect = [NSMutableArray new];
    
    self.dataSource = @[@{@"uni":@"北京大学",@"city":@"北京市"},@{@"uni":@"清华大学",@"city":@"北京市"},@{@"uni":@"中山大学",@"city":@"广州市"},@{@"uni":@"华南理工大学",@"city":@"广州市"}].mutableCopy;
    
    self.cellHeight = AutoDistance(60);
    [self.tableView dz_registerCell:[HUZPkListCell class]];
    [self.view addSubview:self.btnPK];
    
}

- (void)addObserver{
    self.btnPK.enabled = DRArrayIsEmpty(self.dataSelect) ? NO : YES;
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZPkListCell cellWithTableView:tableView];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    HUZPkListCell *pkListCell = (HUZPkListCell *)cell;
    [pkListCell reloadData:object hasSelect:self.dataSelect];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(54);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HUZPkListHeaderView *uniPkListHeaderView = [[HUZPkListHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(52))];
    return uniPkListHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataSource[indexPath.row];
    if ([self.dataSelect containsObject:dic]){
        [self.dataSelect removeObject:dic];
    }else{
        [self.dataSelect addObject:dic];
    }
    [self.tableView reloadData];
    [self addObserver];
}

#pragma mark - Lazy
- (UIButton *)btnPK{
    if (!_btnPK) {
        _btnPK = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
        _btnPK.frame = CGRectMake(0, HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49));
        [_btnPK setTitle:@"开始PK" forState:UIControlStateNormal];
        [_btnPK setTitleColor:ColorS(COLOR_ffffff) forState:UIControlStateNormal];
        _btnPK.enabled = NO;
    }
    return _btnPK;
}

@end

