//
//  HUZSettingViewController.m
//  HuiZe
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZSettingViewController.h"
#import "HUZAcountManageController.h"
#import "HUZLoginService.h"
#import "FileTool.h"
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface HUZSettingViewController ()
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic, assign) NSInteger memoryTotalSize;

@end

@implementation HUZSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    // 获取文件夹尺寸
    // 文件夹非常小,如果我的文件非常大
    [FileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        self.memoryTotalSize = totalSize;
        [self.tableView reloadData];
    }];
}

- (void)configComponents{
    [super configComponents];
    //,@"消息通知提醒"
    self.dataSource = @[@[@"账号管理"], @[@"清除缓存",@"给我们好评"]].mutableCopy;
    self.shouldMultiSections = YES;
    self.cellHeight = AutoDistance(58);
    [self.tableView dz_registerCell:[UITableViewCell class]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kTableViewCell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"kTableViewCell"];
    }
    cell.contentView.backgroundColor = UIColor.whiteColor;
    
    cell.textLabel.font = FontS(FONT_17);
    cell.textLabel.textColor = ColorS(COLOR_414141);
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.detailTextLabel.text = [self sizeStr];
        cell.detailTextLabel.font = FontS(FONT_14);
    }
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AutoDistance(24);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /// 账号管理
    if (indexPath.section == 0 && indexPath.row == 0) {
        HUZAcountManageController *acountVC = [HUZAcountManageController new];
        [self.navigationController pushViewController:acountVC animated:YES];
    }
    /// 消息通知提醒
    else if (indexPath.section == 1 && indexPath.row == 0) {
        
        /// 给我们好评
        UIAlertController *alterCV = [UIAlertController alertControllerWithTitle:@"确定清除缓存吗?" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        HUZWEAK_SELF;
        UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf clearCacheClick];
        }];
        
        
        UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        [alterCV addAction:okBtn];
        [alterCV addAction:cancelBtn];
        [self presentViewController:alterCV animated:YES completion:nil];
        
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        NSString  *nsStringToOpen = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",@"1463353458"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
    }
}

#pragma mark - Lazy
- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(58))];
        _footerView.backgroundColor = COLOR_BG_WHITE;
        UIButton *btn = [[UIButton alloc]initWithTitle:@"退出登录" textColor:ColorS(COLOR_BG_FF2E4A) autoTextFont:FontS(FONT_17)];
        btn.frame = CGRectMake((HUZSCREEN_WIDTH - AutoDistance(175))/2, 0, AutoDistance(175), AutoDistance(58));
        [btn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:btn];
    }
    return _footerView;
}

- (void)loginOut {
    HUZWEAK_SELF;
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
    [popView popAwaitAlertWithTitle:@"确定退出账户？" cancel:@"取消" confirm:@"确定"];
    popView.confirmClick = ^{
        [weakSelf displayOverFlowActivityView];
        [HUZLoginService getLogoutWithParameters:@{} success:^(NSString *success) {
            [weakSelf removeOverFlowActivityView];
            [weakSelf clearCacheClick];
            [weakSelf presentSheet:@"退出成功"];
            [HUZUserCenterManager logout];
            [weakSelf performBlock:^{
                [HUZTools gotologin];
            } afterDelay:1.f];
        } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
            [weakSelf removeOverFlowActivityView];
//            [weakSelf presentSheet:errorStr];
            [weakSelf presentSheet:@"退出成功"];
            [HUZUserCenterManager logout];
            [weakSelf performBlock:^{
                [HUZTools gotologin];
            } afterDelay:1.f];
        }];
    };
}


// 获取缓存尺寸字符串
- (NSString *)sizeStr
{
    NSInteger totalSize = _memoryTotalSize;
    NSString *sizeStr = @"";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%.1fMB",sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%.1fKB",sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%.ldB",totalSize];
    }else{
        sizeStr = @"0B";
    }
    
    return sizeStr;
}

//- (void)escCoachClick {
//    [self displayOverFlowActivityView];
//    [UIView animateWithDuration:1.5 animations:^{
//    } completion:^(BOOL finished) {
//        [self removeOverFlowActivityView];
//        [MBProgressHUD showSuccess:@"清除成功"];
//        [self clearCacheClick];
//    }];
//}

- (void)clearCacheClick
{
    // 清空缓存
    // 删除文件夹里面所有文件
    [FileTool removeDirectoryPath:CachePath];
    // 删除缓存之后,文件大小显示为0
    self.memoryTotalSize = 0;
    [self.tableView reloadData];
}

@end
