//
//  HUZMessageListCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMessageListCell.h"

@interface HUZMessageListCell ()

@property (nonatomic,strong) UIImageView *ivHeader;
@property (nonatomic,strong) UIView *ivIsRead;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UILabel *labTime;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@end

@implementation HUZMessageListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZMessageListCell";
    HUZMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivHeader = [UIImageView new];
    self.ivHeader.backgroundColor = [UIColor grayColor];
    ViewRadius(self.ivHeader, AutoDistance(24));
    
    self.ivIsRead = [UIView new];
    self.ivIsRead.backgroundColor = ColorS(COLOR_BG_FF2E4A);
    ViewRadius(self.ivIsRead, AutoDistance(3));
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
    self.labTitle.text = @"Sophia 评论了问题";
    
    self.labTime = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentRight];
    self.labTime.text = @"2019-01-01 18:00";
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labContent.text = @"请问广东600分理科生、可以报名…";
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivHeader];
    [self.contentView addSubview:self.ivIsRead];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labTime];
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.ivHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(48), AutoDistance(48)));
    }];
    
    [self.ivIsRead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(16));
        make.left.mas_offset(AutoDistance(22));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(6), AutoDistance(6)));
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(17));
        make.left.equalTo(self.ivHeader.mas_right).offset(AutoDistance(11));
        make.right.mas_offset(-AutoDistance(120));
    }];
    
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labTitle);
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(4));
        make.left.equalTo(self.ivHeader.mas_right).offset(AutoDistance(11));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)setModel:(HUZMessageModel *)model
{
    _model = model;
    [self.ivHeader sd_setImageWithURL:[NSURL URLWithString:model.headUrl]];
    if (model.mesType == 1) {
        self.labTitle.text = @"系统提示";
    }else{
        self.labTitle.text = [NSString stringWithFormat:@"%@ 评论了问题",model.username] ;
    }

    self.labTime.text = model.creationTime;//[HUZTools timestampSwitchTime:[NSString stringWithFormat:@"%ld",model.creationTime] andFormatter:@"YY/MM/dd HH:MM"];

    self.labContent.text = model.mesTitle;

    if (model.mesState.intValue == 2) {
        self.ivIsRead.backgroundColor = UIColor.clearColor;
    }else if (model.mesState.intValue == 1) {
        self.ivIsRead.backgroundColor = ColorS(COLOR_BG_FF2E4A);

    }
}
@end

