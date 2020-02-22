//
//  HUZMajorMatchUniController.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMajorMatchUniController.h"
#import "HUZVolunteerSelectController.h"
#import "HUZUniPriorityFillCell.h"

@interface HUZMajorMatchUniController ()

@end

@implementation HUZMajorMatchUniController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"按专业选学校";

}

- (void)configComponents{
    [super configComponents];
    
    if (!self.dataModel) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSArray *imageArray = @[@"ic_uni_chong",@"ic_uni_wen",@"ic_uni_bao"];
    NSArray *titleArray = @[@"可冲击的大学",@"较稳妥的大学",@"可保底的大学"];
    NSArray *subtitleArray = @[@"大学录取的可能性低",@"大学录取的可能性较高",@"大学录取的可能性非常高"];
    NSArray *detailArray = @[@(self.dataModel.data.punching),@(self.dataModel.data.stable),@(self.dataModel.data.protect)];
    
    for (int i = 0; i < imageArray.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:imageArray[i] forKey:@"image"];
        [dic setValue:titleArray[i] forKey:@"title"];
        [dic setValue:subtitleArray[i] forKey:@"subtitle"];
        [dic setValue:detailArray[i] forKey:@"detailtitle"];
        [array addObject:dic];
    }
    self.dataSource = [array mutableCopy];
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = self.tableView.backgroundColor;
    [self.tableView dz_registerCell:[HUZUniPriorityFillCell class]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZUniPriorityFillCell *cell = [HUZUniPriorityFillCell cellWithTableView:tableView];
    [cell setDic:self.dataSource[indexPath.section]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZVolunteerSelectController *uniSel = [HUZVolunteerSelectController new];
    uniSel.batchId = self.batch;
    uniSel.isMajorPriority = YES;
    uniSel.volType = indexPath.section;
    uniSel.majorAllIdsArr = self.majorAllIdsArr;
    [self.navigationController pushViewController:uniSel animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return AutoDistance(77.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoDistance(6.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AutoDistance(4);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}
@end
