//
//  HUZSearchMajorAllAssessHeader.m
//  HuiZe
//
//  Created by tbb on 2019/11/13.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZSearchMajorAllAssessHeader.h"

@implementation HUZSearchMajorAllAssessHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.leftBtn setImage:[UIImage imageNamed:@"ic_btn_right"] forState:(UIControlStateNormal)];
    [self.leftBtn setImage:[UIImage imageNamed:@"ic_btn_down"] forState:(UIControlStateSelected)];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.backgroundColor = UIColor.whiteColor;
}
@end
