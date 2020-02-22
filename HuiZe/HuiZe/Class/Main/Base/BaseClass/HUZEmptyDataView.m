//
//  HUZEmptyDataView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/21.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZEmptyDataView.h"

@implementation HUZEmptyDataView

- (void)initView{
    
    self.ivEmpty = [UIImageView new];
    self.ivEmpty.image = ImageNamed(EMPTYDATA_IMAGE);
    
    self.labEmpty = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12) numberOfLines:2];

    [self addSubview:self.ivEmpty];
    [self addSubview:self.labEmpty];
    
    [self.ivEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(39));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(112), AutoDistance(99)));
    }];
    
    [self.labEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivEmpty.mas_right).offset(AutoDistance(18));
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.ivEmpty);
    }];
    
}

@end
