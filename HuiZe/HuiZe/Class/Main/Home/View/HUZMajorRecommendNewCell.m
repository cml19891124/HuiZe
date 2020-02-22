//
//  HUZMajorRecommendNewCell.m
//  HuiZe
//
//  Created by tbb on 2019/11/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMajorRecommendNewCell.h"

@implementation HUZMajorRecommendNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.backgroundColor = COLOR_BG_WHITE;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,3);// 设置阴影偏移量
    self.layer.shadowOpacity = 0.2;// 设置阴影透明度
    self.layer.shadowRadius = 4;// 设置阴影半径
    self.layer.cornerRadius = 4;
    self.clipsToBounds = NO;
}

@end
