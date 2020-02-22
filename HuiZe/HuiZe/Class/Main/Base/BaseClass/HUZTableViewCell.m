//
//  HUZTableViewCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

@implementation HUZTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    return [self cellWithTableView:tableView style:UITableViewCellStyleDefault];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZTableViewCell";
    HUZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}
+ (CGFloat)calculateHeightWithEntity:(id)entity{ return 0;}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{}

- (void)reloadData:(id)entity{}

- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath{}

- (void)setIsZero:(BOOL)isZero{
    
    if (isZero) {
        self.preservesSuperviewLayoutMargins = false;
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins  = UIEdgeInsetsZero;
    }
}


- (HUZEmptyDataView *)emptyDataView{
    if (!_emptyDataView) {
        _emptyDataView = [[HUZEmptyDataView alloc] initWithFrame:self.contentView.bounds];
    }
    return _emptyDataView;
}
@end
