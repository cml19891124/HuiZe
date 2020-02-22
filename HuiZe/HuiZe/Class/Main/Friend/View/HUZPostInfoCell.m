//
//  HUZPostInfoCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPostInfoCell.h"
#import "HUZFriendCommentModel.h"

@interface HUZPostInfoCell ()
@property (nonatomic,strong) UIImageView *ivHeader;
@property (nonatomic,strong) UILabel *labName;
@property (nonatomic,strong) UILabel *labTime;
@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UIImageView *ivDiviceline;


@end

@implementation HUZPostInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZPostInfoCell";
    HUZPostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(HUZFriendCommentDataEvosListModel *)entity{
    CGFloat H = [entity.content jk_heightWithFont:FontS(FONT_17) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    return H + AutoDistance(84);
}

- (void)initView{
    self.ivHeader = [UIImageView new];
    self.ivHeader.backgroundColor = [UIColor grayColor];
    ViewRadius(self.ivHeader, AutoDistance(14));
    
    self.labName = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labName.text = @"Sophia";
    
    self.labTime = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentRight];
    self.labTime.text = @"17小时前";
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) numberOfLines:0];
    self.labContent.text = @"健康比什么都重要。所谓宁可做健康的乞丐，也比做病恹恹的国王快活得多。性情乐观、体格健康、充满活力";
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivHeader];
    [self.contentView addSubview:self.labName];
    [self.contentView addSubview:self.labTime];
    [self.contentView addSubview:self.labContent];
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
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)reloadData:(HUZFriendCommentDataEvosListModel *)entity{
    [self.ivHeader sd_setImageWithURL:[NSURL URLWithString:entity.headUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labName.text = entity.username;
    self.labTime.text = entity.createTime;//[HUZInsureValidate distanceTimeWithBeforeTime:[entity.createTime doubleValue]];
    self.labContent.text = entity.content;
}

@end
