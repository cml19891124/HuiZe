//
//  HUZGradeDeatilCityView.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeDeatilCityView.h"
#import "HUZGradeCityRadioCell.h"

@implementation HUZGradeDeatilCityView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(12));
    
    self.labTop = [[UILabel alloc]init];
    self.labTop.textColor = ColorS(COLOR_848484);
    self.labTop.font = FontS(FONT_12);
    self.labTop.text = @"录取人数最多的5个城市";
    [self addSubview:self.labTop];
    
    self.ctableview = [[UITableView alloc]init];
    self.ctableview.dataSource = self;
    self.ctableview.delegate = self;
    self.ctableview.scrollEnabled = NO;
    self.ctableview.separatorColor = [UIColor clearColor];
    self.ctableview.rowHeight = AutoDistance(38);
    self.ctableview.tableFooterView = [UIView new];
    [self.ctableview dz_registerCell:[HUZGradeCityRadioCell class]];
    [self addSubview:self.ctableview];
    
    [self.labTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(AutoDistance(17));
    }];
    
    [self.ctableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTop.mas_bottom).offset(AutoDistance(25));
        make.bottom.left.right.mas_equalTo(self);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.data.admissionDetailsEntitiesCIty.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZGradeCityRadioCell *cell = [HUZGradeCityRadioCell cellWithTableView:tableView];
    cell.labTrade.text =  self.model.data.admissionDetailsEntitiesCIty[indexPath.row].city;
    NSString *progress = self.model.data.admissionDetailsEntitiesCIty[indexPath.row].fraction;
    cell.progressView.progress = [progress floatValue]/100;
    cell.labRadio.text = [NSString stringWithFormat:@"%.2lf%",[progress floatValue]];
    return cell;
}

- (void)setModel:(HUZGradeAnalyzeModel *)model {
    _model = model;
    [self.ctableview reloadData];
}


@end
