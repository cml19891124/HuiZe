//
//  HUZPolicyExplainCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/27.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPolicyExplainCell.h"
#import "HUZPolicyListModel.h"

@interface HUZPolicyExplainCell ()

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labContent;
@end

@implementation HUZPolicyExplainCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZPolicyExplainCell";
    HUZPolicyExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(HUZPolicylistdataListModel *)entity{
    CGFloat titleH = [entity.title jk_heightWithFont:FontS(FONT_15) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    CGFloat contentH = [entity.content jk_heightWithFont:FontS(FONT_15) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    return titleH + contentH + AutoDistance(100);
}

- (void)initView{
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15) numberOfLines:0];
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_14) numberOfLines:0];
    
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labContent];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(21)));
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(23));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
}

- (void)reloadData:(HUZPolicylistdataListModel *)entity{
    self.labTitle.text = entity.title;
    self.labContent.text = entity.content;
}
@end
