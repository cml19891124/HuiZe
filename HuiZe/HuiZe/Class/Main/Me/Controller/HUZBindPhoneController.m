//
//  HUZBindPhoneController.m
//  HuiZe
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZBindPhoneController.h"
#import "HUZBindPhoneHeadView.h"
#import "HUZMyModifyPhoneController.h"

@interface HUZBindPhoneController ()
@property (nonatomic,strong) HUZBindPhoneHeadView *headerView;

@end

@implementation HUZBindPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定手机号";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSource = @[@"1"].mutableCopy;
    self.cellHeight = AutoDistance(0);
    self.tableView.tableFooterView = self.headerView;
}

- (HUZBindPhoneHeadView *)headerView {
    if (!_headerView) {
        _headerView = [[HUZBindPhoneHeadView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(185))];
        [_headerView.btnConfirm addTarget:self action:@selector(modifyPhone) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _headerView;
}

- (void)modifyPhone {
    HUZMyModifyPhoneController *modify = [HUZMyModifyPhoneController new];
    [self.navigationController pushViewController:modify animated:YES];
}
@end
