//
//  HUZSearchAllMajorCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchAllMajorCell.h"
#import "HUZMajorListModel.h"

@interface HUZSearchAllMajorCell ()

@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZSearchAllMajorCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZSearchAllMajorCell";
    HUZSearchAllMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivArrow = [[UIImageView alloc] initWithFrame:CGRectMake(AutoDistance(16), AutoDistance(27), AutoDistance(6), AutoDistance(10))];
    self.ivArrow.image = ImageNamed(@"ic_arrow_close");
    
    self.ivDiviceline = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoDistance(58), HUZSCREEN_WIDTH, AutoDistance(2))];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
}

- (void)reloadData:(HUZMajorListModel *)entity{
    //如果是一级cell
    if (entity.second_index == 0 && entity.third_index == 0) {
        self.textLabel.text = [NSString stringWithFormat:@"    %@",entity.content];
        self.textLabel.textColor = ColorS(COLOR_414141);
        self.ivDiviceline.hidden = entity.is_show ? NO : YES;
        self.ivArrow.hidden = entity.is_show ? NO : YES;
        self.ivArrow.image = entity.is_open ? ImageNamed(@"ic_arrow_open") : ImageNamed(@"ic_arrow_close");
        
        if (entity.is_open) {
            self.ivArrow.frame = CGRectMake(AutoDistance(16), AutoDistance(27), AutoDistance(10), AutoDistance(6));
        }else{
            self.ivArrow.frame = CGRectMake(AutoDistance(16), AutoDistance(27), AutoDistance(6), AutoDistance(10));
        }
        return;
    }
    
    //如果是二级cell
    if (entity.third_index == 0) {
        self.textLabel.text = [NSString stringWithFormat:@"         %@",entity.content];
        self.textLabel.textColor = ColorS(COLOR_414141);
        self.ivDiviceline.hidden = entity.is_show ? NO : YES;
        self.ivArrow.hidden = entity.is_show ? NO : YES;
        self.ivArrow.image = entity.is_open ? ImageNamed(@"ic_arrow_open") : ImageNamed(@"ic_arrow_close");
        
        if (entity.is_open) {
            self.ivArrow.frame = CGRectMake(AutoDistance(34), AutoDistance(27), AutoDistance(10), AutoDistance(6));
        }else{
            self.ivArrow.frame = CGRectMake(AutoDistance(34), AutoDistance(27), AutoDistance(6), AutoDistance(10));
        }
        return;
    }
    
    //如果是三级cell
    self.textLabel.text = [NSString stringWithFormat:@"      %@",entity.content];
    self.textLabel.textColor = ColorS(COLOR_989898);
    self.ivArrow.image = ImageNamed(@"");
    self.ivArrow.hidden = YES;
    self.ivDiviceline.hidden = entity.is_show ? NO : YES;

}

@end
