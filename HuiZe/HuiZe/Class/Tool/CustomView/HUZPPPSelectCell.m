//
//  HUZPPPSelectCell.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZPPPSelectCell.h"

@implementation HUZPPPSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setModel:(HUZPPPModel *)model {
    _model = model;
    _titleLab.text = [NSString stringWithFormat:@"%@",_model.title];
    _selectBtn.selected = _model.isSelected;
}

#pragma mark - private actions
- (void)setupView {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleLab = [UILabel new];
    _titleLab.font = [UIFont systemFontOfSize:14];
    CGFloat name_color = 65/255.0;
    _titleLab.textColor = [UIColor colorWithRed:name_color green:name_color blue:name_color alpha:1];
    
    _selectBtn = [[UIButton alloc] init];
    _selectBtn.backgroundColor = [UIColor clearColor];
    [_selectBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"ic_blue_select"] forState:UIControlStateSelected];
    _selectBtn.userInteractionEnabled = NO;
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_selectBtn];
    
    UIView *superView = self.contentView;
    CGFloat margin = AutoDistance(16);
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(margin);
        make.height.mas_equalTo(AutoDistance(20));
        make.top.equalTo(superView).offset(AutoDistance(12));
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView).offset(-margin);
        make.centerY.equalTo(self.titleLab);
        make.size.sizeOffset(CGSizeMake(AutoDistance(9), AutoDistance(9)));
    }];
    
}


@end
