//
//  HUZSearchUniFunctionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchUniFunctionView.h"

@implementation HUZSearchUniFunctionView

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title{
    self = [super init];
    if (self) {
        self.ivFunction = [[UIImageView alloc] initWithImage:ImageNamed(icon)];
        self.labFunction = [[UILabel alloc] initWithTextColor:ColorS(COLOR_525252) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
        self.labFunction.text = title;
        
        [self addSubview:self.ivFunction];
        [self addSubview:self.labFunction];
        
        [self.ivFunction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(AutoDistance(38), AutoDistance(38)));
        }];
        [self.labFunction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ivFunction.mas_bottom).offset(AutoDistance(4));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}
@end
