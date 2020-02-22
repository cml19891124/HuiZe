//
//  HUZVolUniDetailViewController.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolUniDetailViewController.h"
#import "HUZVolUniHeaderView.h"
#import "HUZVolUniTableViewCell.h"
#import "HUZSchoolListDataModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface HUZVolUniDetailViewController ()
@property (nonatomic,strong) HUZVolUniHeaderView *headView;

@end

@implementation HUZVolUniDetailViewController
-(void)setSchoolModel:(HUZSchoolModel *)schoolModel {
    _schoolModel = schoolModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"列表详情";
}

- (void)configComponents{
    [super configComponents];
    
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.view.backgroundColor = self.tableView.backgroundColor;
    
    self.dataSource = self.schoolModel.major.copy;
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.cellHeight = AutoDistance(89);
    [self.tableView dz_registerCell:[HUZVolUniTableViewCell class]];
    self.headView.schoolModel = self.schoolModel;
    self.tableView.tableHeaderView = self.headView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    HUZUniInfoGeneralizeMajorModel * majorModel = nil;
    if (indexPath.section < self.dataSource.count) {
        majorModel = self.dataSource[indexPath.section];
    }
    
    HUZVolUniTableViewCell *cell = [HUZVolUniTableViewCell cellWithTableView:tableView];
    cell.majorModel = majorModel;
    cell.delBlock = ^{
        ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
        [popView popAwaitAlertWithTitle:@"\"是否要删除加入的此专业\"" cancel:@"取消" confirm:@"确定"];
        popView.confirmClick = ^{
            
        };
    };
    cell.dBtn.tag = 11100 + indexPath.section;
    [cell.dBtn addTarget:self action:@selector(delMarjorClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel * majorModel = nil;
    if (indexPath.section < self.dataSource.count) {
        majorModel = self.dataSource[indexPath.section];
    }
    return  [tableView fd_heightForCellWithIdentifier:@"HUZVolUniTableViewCell" configuration:^(HUZVolUniTableViewCell *cell) {
        cell.majorModel = majorModel;
    }];
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
}
//删除专业
- (void)delMarjorClick:(UIButton*)sender {
    NSInteger section = sender.tag - 11100;
    HUZUniInfoGeneralizeMajorModel * majorModel = nil;
    if (section < self.dataSource.count) {
        majorModel = self.dataSource[section];
    }
    
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
    [popView popAwaitAlertWithTitle:@"\"是否要删除该专业\"" cancel:@"取消" confirm:@"确定"];
    MJWeakSelf;
    popView.confirmClick = ^{
        [weakSelf delMarjorActionSection:section];
    };
    
}

-(void)delMarjorActionSection:(NSInteger)section {
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.schoolModel.major];
    [tempArr removeObjectAtIndex:section];
    self.schoolModel.major = tempArr.copy;
    self.dataSource = self.schoolModel.major.copy;
    [self.tableView reloadData];
    if (self.delMarjorClickBlock) {
        self.delMarjorClickBlock();
    }
}

//删除学校和所有专业
- (void)delClick:(UIButton*)sender {
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
    [popView popAwaitAlertWithTitle:@"\"是否要删除加入的所有专业\"" cancel:@"取消" confirm:@"确定"];
    MJWeakSelf;
    popView.confirmClick = ^{
        if (weakSelf.delSchoolClickBlock) {
            weakSelf.delSchoolClickBlock(weakSelf.indexPath);
            [weakSelf.navigationController popViewControllerAnimated:true];
        }
    };
}

- (HUZVolUniHeaderView *)headView {
    if (!_headView) {
        _headView = [[HUZVolUniHeaderView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(85))];
        [_headView.dBtn addTarget:self action:@selector(delClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headView;
}
@end
