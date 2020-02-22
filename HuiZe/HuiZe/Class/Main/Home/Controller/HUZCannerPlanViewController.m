//
//  HUZCannerPlanViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCannerPlanViewController.h"
#import "HUZCannerPlanHeaderView.h"
#import "HUZCannerPlanCell.h"
#import "HUZCharacterTestViewController.h"
#import "HUZAgreementViewController.h"
@interface HUZCannerPlanViewController ()

@end

@implementation HUZCannerPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"生涯规划";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSource = @[@[@{@"icon":@"ic_mbti_test",@"name":@"MBTI职业性格测试",@"des":@"进行性格测试"}],
                        ].mutableCopy;
//    @[@{@"icon":@"ic_mbti_test",@"name":@"霍兰德兴趣测试",@"des":@"进行兴趣测试"}]
    self.cellHeight = AutoDistance(77);
    self.shouldMultiSections = YES;
    [self.tableView dz_registerCell:[HUZCannerPlanCell class]];
}

- (void)configStyle{
    self.style = UITableViewStyleGrouped;
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.dataSource[indexPath.section];
    NSDictionary *dict = arr[indexPath.row];
    HUZCannerPlanCell *cannerPlanCell = [HUZCannerPlanCell cellWithTableView:tableView];
    [cannerPlanCell reloadData:dict];
    return cannerPlanCell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
//    HUZCannerPlanCell *cannerPlanCell = (HUZCannerPlanCell *)cell;
//    [cannerPlanCell reloadData:object];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return AutoDistance(178);
    return AutoDistance(12);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        HUZCannerPlanHeaderView *headerView = [[HUZCannerPlanHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(178))];
        return headerView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alterCV = [UIAlertController alertControllerWithTitle:@"" message:@"MBTI（迈尔斯布里格斯类型指标）职业性格测试，是美国心理学家伊莎贝尔·布里格斯·迈尔斯和她的母亲凯瑟琳·库克·布里格斯制定的。MBTI职业性格测试是一种迫选型、自我报告式的性格评估理论模型，用以衡量和描述人们在获取信息、作出决策、对待生活等方面的心理活动规律和性格类型。性格没有好与坏，测试的目的是反映最真实的自己，而不是别人所期待的你。请最大程度放松下来，选择当您面临下述这些情况时不由自主、自然和不假思索的决定或倾向。本测试共有93道题，大约需要10分钟，若中途退出测试，则已答部分将自动视为无效，需重新开始作答。" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"进入答题" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        HUZCharacterTestViewController *characterTestVC = [HUZCharacterTestViewController new];
        characterTestVC.type = 0;
        [self.navigationController pushViewController:characterTestVC animated:YES];
    }];
    
    [alterCV addAction:okBtn];
    [self presentViewController:alterCV animated:YES completion:nil];
    
//    NSString *url = [NSString stringWithFormat:@"http://47.107.101.26/huize/index.html#/index?questiontype=%zd&token=%@",indexPath.section,HUZUserCenterManager.userModel.token];
//    HUZCharacterTestViewController *agreementVC = [[HUZCharacterTestViewController alloc] init];
//    agreementVC.url = url;
//    [self.navigationController pushViewController:agreementVC animated:true];
}
@end
