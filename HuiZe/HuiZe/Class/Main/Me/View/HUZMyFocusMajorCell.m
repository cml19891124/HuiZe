//
//  HUZMyFocusMajorCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMyFocusMajorCell.h"

@interface HUZMyFocusMajorCell ()

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@end

@implementation HUZMyFocusMajorCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZMyFocusMajorCell";
    HUZMyFocusMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labTitle.text = @"特警";
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes.text = @"公安与司法大类     公安管理类";
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(240), AutoDistance(21)));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.labTitle);
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(4));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
    
}

- (void)setModel:(HUZFocusMajorDataListModel *)model {
    _model = model;
    self.labTitle.text = model.category;//model.universityEntity.category;
    self.labDes.text = [NSString stringWithFormat:@"%@     %@", model.oneCategory, model.twoCategory];

}

@end
