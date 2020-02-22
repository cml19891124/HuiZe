//
//  HUZUniAutoFillSchoolMajorCell.m
//  HuiZe
//
//  Created by tbb on 2019/11/21.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniAutoFillSchoolMajorCell.h"

@implementation HUZUniAutoFillSchoolMajorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.majorLb];
        [self.majorLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(62);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

}

-(UILabel *)majorLb {
    if (!_majorLb) {
        _majorLb = [[UILabel alloc] init];
        _majorLb.textColor = ColorS(COLOR_989898);
        _majorLb.font = [UIFont systemFontOfSize:12 weight:(UIFontWeightMedium)];
        _majorLb.text = @"---";
        _majorLb.numberOfLines = 0;
    }
    return _majorLb;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
