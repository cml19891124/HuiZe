//
//  HUZUniSelectController.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniSelectController.h"
#import "HUZSearchNavView.h"
#import "HUZUniSelectTableViewCell.h"
#import "HUZVolunteerPacketController.h"

#import "HUZVolunteerService.h"

@interface HUZUniSelectController ()
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) HUZSearchNavView *searchView;
@end

@implementation HUZUniSelectController

- (void)viewDidLoad {
    self.style = UITableViewStyleGrouped;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择院校";
    [self setupRefresh:self.tableView];
    [self onStartRefresh];
}


- (void)onStartRefresh {
    self.page = 1;
    [self loadSchoolData];
}

- (void)onStartLoadMore {
    self.page ++;
    [self loadSchoolData];
}

- (void)configComponents{
    [super configComponents];
    
//    self.dataSource = @[@"1", @"1", @"1", @"1", @"1", @"1"].mutableCopy;
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.cellHeight = AutoDistance(58);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView dz_registerCell:[HUZUniSelectTableViewCell class]];
//    self.tableView.tableHeaderView = self.headView;
}

- (void)loadSchoolData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"batch"] = self.batch;
    dic[@"pageNow"] = @(self.page);

    dic[@"pageSize"] = @"10";

    HUZWEAK_SELF
    [HUZVolunteerService getUniversitiesWithParamters:dic success:^(HUZSchoolListDataModel * _Nonnull dataModel) {
        [weakSelf stopRefresh:weakSelf.tableView];
        [weakSelf removeOverFlowActivityView];
        if (weakSelf.page == 1) {
            [weakSelf.dataSource removeAllObjects];
        }
        
        [weakSelf.dataSource addObjectsFromArray:dataModel.data.list];
        [weakSelf configEmptyViewWithError:EMPTYDATA];
        [weakSelf.tableView reloadData];
        if (dataModel.data.list == 0) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf stopRefresh:weakSelf.tableView];
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else{
        return self.dataSource.count;
    }
}

/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZUniSelectTableViewCell *cell = [HUZUniSelectTableViewCell cellWithTableView:tableView];
    HUZSchoolModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZWEAK_SELF
    HUZSchoolModel *model = self.dataSource[indexPath.row];
    if (_selectBlock) {
        _selectBlock(model);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return AutoDistance(63);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, 44)];
        bgView.backgroundColor = UIColor.whiteColor;
        
        UILabel *titleLb = [UILabel new];
        titleLb.font = [UIFont systemFontOfSize:14 weight:(UIFontWeightRegular)];
        titleLb.textColor = ColorS(COLOR_414141);
        titleLb.text = @"猜你喜欢";
        
        [bgView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(bgView.mas_centerY);
            make.height.mas_equalTo(17);
        }];
        
        return bgView;
    }
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(63))];
    headerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [headerView addGestureRecognizer:tap];
    headerView.backgroundColor = COLOR_BG_WHITE;
    UILabel *lab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    lab.text = @"从我的备选志愿里挑选";
    lab.frame = CGRectMake(AutoDistance(15), AutoDistance(12), AutoDistance(165), AutoDistance(21));
    [headerView addSubview:lab];
    lab.huz_centerY = headerView.huz_centerY;
    UIImageView *ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    ivArrow.frame = CGRectMake( HUZSCREEN_WIDTH - AutoDistance(15) - AutoDistance(10), AutoDistance(18), AutoDistance(10), AutoDistance(10));
    ivArrow.huz_centerY = lab.huz_centerY;
    [headerView addSubview:ivArrow];
    UIImageView *ivDiviceline = [UIImageView new];
    ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
//    ivDiviceline.frame = CGRectMake(0, AutoDistance(45) - AutoDistance(2), HUZSCREEN_WIDTH, AutoDistance(8));
    [headerView addSubview:ivDiviceline];
    [ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(headerView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [headerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(headerView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
    
    return headerView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(52))];
        _headView.backgroundColor = COLOR_BG_WHITE;
        HUZSearchNavView *searchView = [[HUZSearchNavView alloc]initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(7), HUZSCREEN_WIDTH - 2 * AutoDistance(15), AutoDistance(30))];
        searchView.tfKeyword.placeholder = @"搜索院校";
        self.searchView = searchView;
        [_headView addSubview:searchView];
        UIImageView *ivDiviceline = [UIImageView new];
        ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        ivDiviceline.frame = CGRectMake(0, CGRectGetMaxY(searchView.frame) + AutoDistance(7), HUZSCREEN_WIDTH, AutoDistance(8));
        [_headView addSubview:ivDiviceline];
        
    }
    return _headView;
}

- (void)tap:(UITapGestureRecognizer*)tap {
    HUZVolunteerPacketController *packet = [HUZVolunteerPacketController new];
    HUZWEAK_SELF
    packet.schoolBlcok = ^(NSDictionary * _Nullable postDic, HUZPacketVolListModel * _Nullable model) {
        if (weakSelf.allBlock) {
            weakSelf.allBlock(postDic,model);
        }
    };
    packet.batch = self.batch;
    [self.navigationController pushViewController:packet animated:YES];
}


@end
