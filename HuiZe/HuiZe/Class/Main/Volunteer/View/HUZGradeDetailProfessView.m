//
//  HUZGradeDetailProfessView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeDetailProfessView.h"

@implementation HUZGradeDetailProfessView


- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(12));
    
    self.labTop = [[UILabel alloc]init];
    self.labTop.textColor = ColorS(COLOR_848484);
    self.labTop.font = FontS(FONT_12);
    self.labTop.text = @"录取人数最多的5个专业";
    [self addSubview:self.labTop];
    
    self.ptableview = [[UITableView alloc]init];
    self.ptableview.dataSource = self;
    self.ptableview.delegate = self;
    self.ptableview.scrollEnabled = NO;
    self.ptableview.separatorColor = COLOR_BG_WHITE;
    self.ptableview.rowHeight = AutoDistance(40);
    self.ptableview.tableFooterView = [UIView new];
    [self.ptableview dz_registerCell:[UITableViewCell class]];
    [self addSubview:self.ptableview];
    
    [self.labTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(AutoDistance(17));
    }];
    
    [self.ptableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTop.mas_bottom).offset(AutoDistance(25));
        make.bottom.left.right.mas_equalTo(self);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"  %@", self.model.data.admissionMajorEntities[indexPath.row].category];
    cell.textLabel.font = FontS(FONT_12);
    cell.textLabel.textColor = ColorS(COLOR_414141);
    UILabel *labe = [[UILabel alloc]initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    labe.frame = CGRectMake(0, 0, AutoDistance(70), AutoDistance(30));
    labe.text = self.model.data.admissionMajorEntities[indexPath.row].admissionNum;
    labe.textAlignment = NSTextAlignmentCenter;
    cell.accessoryView = labe;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setModel:(HUZGradeAnalyzeModel *)model {
    _model = model;
    [self.ptableview reloadData];
}

@end
