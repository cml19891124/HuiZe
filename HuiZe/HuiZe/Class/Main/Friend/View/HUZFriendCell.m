//
//  HUZFriendCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZFriendCell.h"
#import "HUZFriendListModel.h"

@interface HUZFriendCell ()

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labNewsType;
@property (nonatomic,strong) UILabel *labLike;
@property (nonatomic,strong) UILabel *labComment;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZFriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZFriendCell";
    HUZFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(HUZFriendListDataListModel *)entity{
    /// 计算文字高度
    NSString *content = [NSString stringWithFormat:@"#加精帖 %@",entity.content];
    CGFloat H = [content jk_heightWithFont:FontS(FONT_17) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    return H + AutoDistance(70) > AutoDistance(118) ? AutoDistance(118) : H + AutoDistance(70);
}

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) numberOfLines:2];
    
    self.labNewsType = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12)];
    
    self.labLike = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12)];
    
    self.labComment = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12)];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labNewsType];
    [self.contentView addSubview:self.labLike];
    [self.contentView addSubview:self.labComment];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.labNewsType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(15));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.labLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labNewsType);
        make.left.equalTo(self.labNewsType.mas_right).offset(AutoDistance(18));
    }];
    
    [self.labComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labNewsType);
        make.left.equalTo(self.labLike.mas_right).offset(AutoDistance(18));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)reloadData:(HUZFriendListDataListModel *)entity{
    self.labTitle.text = [NSString stringWithFormat:@"#加精帖 %@",entity.content];
    [self.labTitle addAttributestring:self.labTitle.text font:FontS(FONT_12) color:ColorS(COLOR_2E86FF) space:@" "];
    
    self.labLike.text = [NSString stringWithFormat:@"点赞 %@",DRStringIsEmpty(entity.likeNum)? @"0" : entity.likeNum];
    self.labComment.text = [NSString stringWithFormat:@"评论 %@",DRStringIsEmpty(entity.commentNum) ? @"0" : entity.commentNum];
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
    self.labNewsType.text = [NSString stringWithFormat:@"%@",type];
}



@end
