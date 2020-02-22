//
//  HUZSearchingViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchingViewController.h"
#import "HUZSearchingHeaderView.h"
#import "HUZSearchingCell.h"
#import "HUZSearchingFooterView.h"
#import "HUZSearchKeywordModel.h"
#import "HUZAllMajorViewController.h"

@interface HUZSearchingViewController ()

@property (nonatomic,strong) NSString *keyword;

@end

@implementation HUZSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(36);
    self.shouldMultiSections = YES;
    [self.tableView dz_registerCell:[HUZSearchingCell class]];

}

- (void)configStyle{
    self.style = UITableViewStyleGrouped;
}

- (void)setUniKeyword:(NSArray *)uniArray majorKeywork:(NSArray *)majorArray keyword:(nonnull NSString *)keyword{
    [self.dataSource removeAllObjects];
    [self.dataSource addObject:uniArray];
    [self.dataSource addObject:majorArray];
    self.keyword = keyword;
    [self.tableView reloadData];
}

#pragma mark - tableview
/// duqueueReusavleCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZSearchingCell *cell = [HUZSearchingCell cellWithTableView:tableView];
//    if (indexPath.section == 0) {
//        HUZSearchKeywordDataUniModel *uniModel = self.dataSource[indexPath.section];
//    }else{
//        HUZSearchKeywordDataSubjectModel
//    }
    NSArray *arr = self.dataSource[indexPath.section];
    [self configureCell:cell atIndexPath:indexPath withObject:arr[indexPath.row]];
    return cell;
}

- (void)configureCell:(HUZSearchingCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object keyword:self.keyword];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSArray *array = self.dataSource[section];
    return DRArrayIsEmpty(array) ? 0.00001f : AutoDistance(45);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) return 0.00001f;
    NSArray *array = self.dataSource[section];
    return DRArrayIsEmpty(array) ? 0.00001f : AutoDistance(40);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array = self.dataSource[section];
    CGFloat headerH = DRArrayIsEmpty(array) ? 0.00001f : AutoDistance(45);
    HUZSearchingHeaderView *searchingHeaderView = [[HUZSearchingHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, headerH)];
    if (!DRArrayIsEmpty(array)) {
        searchingHeaderView.labTitle.text = section == 0 ? @"学校" : @"专业";
    }
    return searchingHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) return [UIView new];
    NSArray *array = self.dataSource[section];
    CGFloat footerH = DRArrayIsEmpty(array) ? 0.00001f : AutoDistance(40);
    if (DRArrayIsEmpty(array)) {
        return [UIView new];
    }else{
        HUZSearchingFooterView *searchFooterView = [[HUZSearchingFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, footerH)];
        [searchFooterView.btnMore addTapAction:^(id  _Nonnull sender) {
            HUZAllMajorViewController *allMajorVC = [HUZAllMajorViewController new];
            allMajorVC.keyStr = self.keyword;
            [self.navigationController pushViewController:allMajorVC animated:YES];
        }];
        return searchFooterView;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *searchKeyword = @"";
    if (indexPath.section == 0) {
        HUZSearchKeywordDataUniModel *uniModel = self.dataSource[indexPath.section][indexPath.row];
        searchKeyword = uniModel.schoolName;
    }else{
        HUZSearchKeywordDataSubjectModel *majorModel = self.dataSource[indexPath.section][indexPath.row];
        searchKeyword = majorModel.category;
    }
    [self.searchVC clickKeywordSearch:searchKeyword];
}

@end
