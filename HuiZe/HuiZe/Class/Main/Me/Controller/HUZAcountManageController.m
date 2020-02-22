//
//  HUZAcountManageController.m
//  HuiZe
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZAcountManageController.h"
#import "HUZAccountCell.h"
#import "HUZBindPhoneController.h"
#import "HUZMyResetPasswordController.h"

@interface HUZAcountManageController ()

@property (strong, nonatomic) NSMutableArray *marr;
@end

@implementation HUZAcountManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账号管理";
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)configComponents{
    [super configComponents];
    [self resetDataSource];
}

- (void)resetDataSource {
    self.dataSource = @[@"手机号",@"密码"].mutableCopy;//, @"微信", @"QQ", @"微博"
    NSString *phone = HUZUserCenterManager.userModel.mobile;
    NSString *pass = [HUZUserCenterManager.userModel.havePassword isEqualToString:@"1"] ? @"更改" : @"未设置";
    self.marr = @[phone, pass, @"已绑定", @"去绑定", @"去绑定"].mutableCopy;
    self.cellHeight = AutoDistance(58);
    [self.tableView dz_registerCell:[HUZAccountCell class]];
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZAccountCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZAccountCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadDataWith:self.dataSource[indexPath.row] detail:self.marr[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return AutoDistance(12);
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /// 手机号
    if (indexPath.row == 0) {
        HUZBindPhoneController *bind = [HUZBindPhoneController new];
        [self.navigationController pushViewController:bind animated:YES];
    }
    /// 密码
    else if (indexPath.row == 1) {
//        if ([HUZUserCenterManager.userModel.havePassword isEqualToString:@"0"] ) {
        HUZMyResetPasswordController *pass = [HUZMyResetPasswordController new];
        pass.callBackBlock = ^{
            [self resetDataSource];
        };
        [self.navigationController pushViewController:pass animated:YES];
//        }
    }
    /// 微信
    else if (indexPath.row == 2) {
        
    }
    /// QQ
    else if (indexPath.row == 3) {
        
    }
    /// 微博
    else if (indexPath.row == 4) {
        
    }
}
@end
