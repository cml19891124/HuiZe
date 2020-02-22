//
//  HUZCannerPlanCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCannerPlanCell.h"

@interface HUZCannerPlanCell ()
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivArrow;
@end

@implementation HUZCannerPlanCell

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.ivLogo = [UIImageView new];

    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivArrow];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(17));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(32), AutoDistance(32)));
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
        make.centerY.equalTo(self.ivLogo);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(210), AutoDistance(24)));
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(4));
        make.left.equalTo(self.labTitle);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(210), AutoDistance(17)));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(24));
        make.right.mas_offset(-AutoDistance(47));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(15), AutoDistance(15)));
    }];

}

- (void)reloadData:(NSDictionary *)entity{
    self.ivLogo.image = ImageNamed(entity[@"icon"]);
    self.labTitle.text = entity[@"name"];
    self.labDes.text = entity[@"des"];
}

@end
