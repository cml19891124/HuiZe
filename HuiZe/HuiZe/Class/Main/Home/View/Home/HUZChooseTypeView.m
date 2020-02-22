//
//  HUZChooseTypeView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZChooseTypeView.h"

@implementation HUZChooseTypeView

- (void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labContent.textAlignment = NSTextAlignmentRight;
    
    self.ivSelect = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_pull_down2")];
    self.ivSelect.userInteractionEnabled = YES;
    
    [self addSubview:self.labContent];
    [self addSubview:self.ivSelect];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [self.ivSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.labContent.mas_right).offset(AutoDistance(5));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(15), AutoDistance(15)));
    }];
}

@end
