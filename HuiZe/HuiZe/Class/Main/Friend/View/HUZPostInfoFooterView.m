//
//  HUZPostInfoFooterView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPostInfoFooterView.h"

@interface HUZPostInfoFooterView ()

@property (nonatomic,strong) UILabel *labComment;
@property (nonatomic,strong) UIButton *btnCommit;

@end

@implementation HUZPostInfoFooterView


- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,3);// 设置阴影偏移量
    self.layer.shadowOpacity = 0.2;// 设置阴影透明度
    self.layer.shadowRadius = 4;// 设置阴影半径
    self.clipsToBounds = NO;
    
    self.userInteractionEnabled = YES;
    
    self.labComment = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.labComment.text = @"添加你的评论...";
    self.labComment.userInteractionEnabled = NO;
    
    self.btnCommit = [[UIButton alloc] initWithTitle:@"发布" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17)];
    self.btnCommit.userInteractionEnabled  = NO;
    
    [self addSubview:self.labComment];
    [self addSubview:self.btnCommit];
    
    [self.labComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self);
    }];
    
    [self.btnCommit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self);
    }];
}

@end

