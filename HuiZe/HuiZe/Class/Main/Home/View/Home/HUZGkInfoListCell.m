//
//  HUZGkInfoListCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkInfoListCell.h"
#import "HUZGkInfoModel.h"

@implementation HUZGkInfoListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZGkInfoListCell";
    HUZGkInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}


- (void)initView{
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) numberOfLines:2];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12)];
    
    self.ivContent = [UIImageView new];
    ViewRadius(self.ivContent, 4);
    
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivContent];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(18);
        make.left.mas_offset(15);
        make.right.mas_offset(-139);
        make.height.mas_equalTo(48);
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(9);
        make.left.mas_offset(15);
    }];
    
    [self.ivContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(18);
        make.right.mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(112, 74));
    }];
    
    self.topView = [UIView new];
    self.topView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(2);
    }];
}

- (void)reloadData:(HUZGkInfoDataListModel *)entity{
    self.labTitle.text = entity.title;
    /// "热门推荐", "独家解析", "资讯头条", "报考指南", "备考经验", "高考政策" ,依次从0开始
    NSString *type = @"";
    if ([entity.type isEqualToString:@"0"]) {
        type = @"热门推荐";
    }else if ([entity.type isEqualToString:@"1"]){
        type = @"独家解析";
    }else if ([entity.type isEqualToString:@"2"]){
        type = @"资讯头条";
    }else if ([entity.type isEqualToString:@"3"]){
        type = @"报考指南";
    }else if ([entity.type isEqualToString:@"4"]){
        type = @"备考经验";
    }else{
        type = @"高考政策";
    }
//    NSString *time = [HUZInsureValidate distanceTimeWithBeforeTime:[entity.createTime doubleValue]];
    self.labDes.text = [NSString stringWithFormat:@"#%@    %@",type,entity.createTime];
//    entity.createTime;//
    [self.ivContent sd_setImageWithURL:[NSURL URLWithString:entity.picOne] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
}

@end
