//
//  HUZNewGkSubjectViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZNewGkSubjectViewController.h"
#import "HUZGkSubjectCell.h"
#import "HUZNewGkSubjectModel.h"
#import "HUZPolicyExplainViewController.h"

@interface HUZNewGkSubjectViewController ()

@end

@implementation HUZNewGkSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新高考政策";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
    
//    self.dataSource = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"].mutableCopy;
    
    [self.tableView dz_registerCell:[UITableViewCell class]];
    [self.tableView dz_registerCell:[HUZGkSubjectCell class]];
    
    [self getNewGKData];
}

-(void)getNewGKData {
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_GET:kUrl_policy_newPolicy parameters:nil success:^(id  _Nonnull responseObject) {
        [self stopRefresh:self.tableView];
        NSString *code = [responseObject valueForKey:@"code"];
        if ([code integerValue] == 0) {
            [self removeOverFlowActivityView];
            if (self.page==1) {
                [self.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZNewGkSubjectModel class] json:responseObject[@"data"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            NSString *msg = responseObject[@"msg"];
            [self presentErrorSheet:msg];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:error];
    }];
}
 
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) return 1;
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) return AutoDistance(58);
    return AutoDistance(85);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == ) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//        cell.textLabel.text = @"新高考政策";
//        cell.textLabel.textColor = ColorS(COLOR_414141);
//        cell.textLabel.font = FontS(FONT_17);
//
//        UIImageView *ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
//        ivArrow.frame = CGRectMake(0, 0, AutoDistance(10), AutoDistance(10));
//        cell.accessoryView = ivArrow;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }else{
    HUZNewGkSubjectModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = self.dataSource[indexPath.row];
    }
    HUZGkSubjectCell *cell = [HUZGkSubjectCell cellWithTableView:tableView];
    cell.subjectModel = model;
    return cell;
//    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) return AutoDistance(8);
//    return AutoDistance(24);
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
        HUZNewGkSubjectModel *model = nil;
        if (indexPath.row < self.dataSource.count) {
            model = self.dataSource[indexPath.row];
        }
        HUZPolicyExplainViewController *policyExplainVC = [HUZPolicyExplainViewController new];
        policyExplainVC.subjectModel = model;
        [self.navigationController pushViewController:policyExplainVC animated:YES];
//    }else{
//        ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
//        [popView popAwaitAlertWithTitle:@"\"敬请期待\"" cancel:@"" confirm:@"确定"];
//        popView.confirmClick = ^{
//
//        };
//    }
}


@end
