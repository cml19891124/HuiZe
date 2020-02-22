//
//  HUZGkTreasureCommentCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkTreasureCommentCell.h"
#import "HUZFriendListModel.h"

@implementation HUZGkTreasureCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZGkTreasureCommentCell";
    HUZGkTreasureCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(HUZFriendListDataListModel *)entity{
    /// 计算文字高度
    CGFloat H = [entity.content jk_heightWithFont:FontS(FONT_17) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    return H + AutoDistance(113) > AutoDistance(182) ? AutoDistance(182) : H + AutoDistance(113);
}

- (void)initView{
    
    self.ivHeader = [UIImageView new];
    ViewRadius(self.ivHeader, AutoDistance(14));
    
    self.labName = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labName.text = @"Sophia";
    
    self.labTime = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentRight];
    self.labTime.text = @"17小时前";
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) numberOfLines:3];
    self.labContent.text = @"健康比什么都重要。所谓宁可做健康的乞丐，也比做病恹恹的国王快活得多。性情乐观、体格健康、充满活力";
    
    self.labType = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labType.text = @"#高考宝典";
    
    self.btnLike = [[UIButton alloc] initWithImageNormal:@"btn_like_normal" imageSeleted:@"btn_like_checked"];;
    
    self.labLike = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labLike.text = @"80";
    
    self.btnComment = [[UIButton alloc] initWithImage:ImageNamed(@"btn_comment")];
    
    self.labComment = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labComment.text = @"30";
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivHeader];
    [self.contentView addSubview:self.labName];
    [self.contentView addSubview:self.labTime];
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.labType];
    [self.contentView addSubview:self.btnLike];
    [self.contentView addSubview:self.labLike];
    [self.contentView addSubview:self.btnComment];
    [self.contentView addSubview:self.labComment];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.ivHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(28), AutoDistance(28)));
    }];
    
    
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivHeader);
        make.left.equalTo(self.ivHeader.mas_right).offset(AutoDistance(8));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(200), AutoDistance(21)));
    }];
    
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labName);
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivHeader.mas_bottom).offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.labType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent.mas_bottom).offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(13));
    }];
    
    [self.btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labType);
        make.right.mas_offset(-AutoDistance(100));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(14), AutoDistance(14)));
    }];
    
    [self.labLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnLike);
        make.left.equalTo(self.btnLike.mas_right).offset(AutoDistance(2));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(40), AutoDistance(17)));
    }];
    
    [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labType);
        make.left.equalTo(self.labLike.mas_right).offset(AutoDistance(8));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(14), AutoDistance(14)));
    }];

    [self.labComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnLike);
        make.left.equalTo(self.btnComment.mas_right).offset(AutoDistance(2));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(30), AutoDistance(17)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)reloadData:(HUZFriendListDataListModel *)entity{
    [self.ivHeader sd_setImageWithURL:[NSURL URLWithString:entity.headUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labName.text = entity.username;
    self.labContent.text = entity.content;
    self.labTime.text = [HUZInsureValidate distanceTimeWithBeforeTime:[entity.createTime doubleValue]];
    self.btnLike.selected = [entity.isClick isEqualToString:@"1"] ? YES : NO;
    self.labLike.text = DRStringIsEmpty(entity.likeNum) ? @"0" : entity.likeNum;
    self.labComment.text = DRStringIsEmpty(entity.commentNum) ? @"0" : entity.commentNum;
    /// 1高考政策,2填报问题,3生涯规划,4大学专业,5志愿讲堂,6产品专区
    NSString *type = @"";
    if ([entity.typeId isEqualToString:@"1"]) {
        type = @"高考政策";
    }else if ([entity.typeId isEqualToString:@"2"]){
        type = @"填报问题";
    }else if ([entity.typeId isEqualToString:@"3"]){
        type = @"生涯规划";
    }else if ([entity.typeId isEqualToString:@"4"]){
        type = @"大学专业";
    }else if ([entity.typeId isEqualToString:@"5"]){
        type = @"志愿讲堂";
    }else{
        type = @"产品专区";
    }
    self.labType.text = [NSString stringWithFormat:@"%@",type];
}

@end
