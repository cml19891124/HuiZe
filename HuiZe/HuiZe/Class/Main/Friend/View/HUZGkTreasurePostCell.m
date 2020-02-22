//
//  HUZGkTreasurePostCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkTreasurePostCell.h"
#import "HUZFriendListModel.h"

@interface HUZGkTreasurePostCell ()

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZGkTreasurePostCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZGkTreasurePostCell";
    HUZGkTreasurePostCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(HUZFriendListDataListModel *)entity{
    NSString *content = [NSString stringWithFormat:@"#加精帖 %@",entity.content];
    CGFloat H = [content jk_heightWithFont:FontS(FONT_17) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    return H + AutoDistance(38) > AutoDistance(86) ? AutoDistance(86) : H + AutoDistance(38);
}

- (void)initView{
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) numberOfLines:2];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(HUZFriendListDataListModel *)entity{
    self.labTitle.text = [NSString stringWithFormat:@"#加精帖 %@",entity.content];
    [self.labTitle addAttributestring:self.labTitle.text font:FontS(FONT_12) color:ColorS(COLOR_2E86FF) space:@" "];
}

@end
