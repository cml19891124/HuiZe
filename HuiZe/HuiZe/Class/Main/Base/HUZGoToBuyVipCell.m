//
//  HUZGoToBuyVipCell.m
//  HuiZe
//
//  Created by tbb on 2019/9/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGoToBuyVipCell.h"
#import "HUZGoToBuyVipView.h"

@interface HUZGoToBuyVipCell ()
@property (nonatomic, strong) HUZGoToBuyVipView * vipView;
@end

@implementation HUZGoToBuyVipCell

-(HUZGoToBuyVipView *)vipView {
    if (!_vipView) {
        _vipView = [HUZGoToBuyVipView viewFromXib];
        _vipView.topConst.constant = 25;
    }
    return _vipView;
}
-(void)setTitle:(NSString *)title {
    _title = [title copy];
    self.vipView.titleLb.text = title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.vipView];
        [self.vipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
