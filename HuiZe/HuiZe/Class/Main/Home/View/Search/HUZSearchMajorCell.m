//
//  HUZSearchMajorCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchMajorCell.h"
#import "HUZSearchMajorModel.h"

@implementation HUZSearchMajorCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZSearchMajorCell";
    HUZSearchMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.isZero = YES;
    
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    
    self.labType = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentRight];
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_arrow_detail")];
    
    self.ivDiviceline = [UIImageView new];

    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.labType];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(80));
    }];
    
    [self.labType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(29));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(10), AutoDistance(10)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(HUZSearchMajorDataListModel *)entity{
    self.labMajor.text = [NSString stringWithFormat:@"%@-%@",entity.schoolName,entity.category];
    self.labType.text = entity.schoolCategory;//[entity.undergraduate isEqualToString:@"0"] ? @"本科" : @"专科";
}

@end
