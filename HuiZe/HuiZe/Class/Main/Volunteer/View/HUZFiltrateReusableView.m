//
//  HUZFiltrateReusableView.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFiltrateReusableView.h"

@implementation HUZFiltrateReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.titleLab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    
    self.rightBtn = [[UIButton alloc]initWithTitle:@"查看更多" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    [self.rightBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:ImageNamed(@"ic_btn_down") forState:UIControlStateNormal];
    [self.rightBtn setImage:ImageNamed(@"ic_btn_top") forState:UIControlStateSelected];

    [self addSubview:self.titleLab];
    [self addSubview:self.rightBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(24));
        make.top.mas_offset(AutoDistance(14));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(24));
        make.width.mas_offset(AutoDistance(100));
        make.centerY.equalTo(self.titleLab);
    }];
    
    CGFloat spacing = 4.0;
    CGSize imageSize = self.rightBtn.imageView.frame.size;
    self.rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing);
    CGSize titleSize = self.rightBtn.titleLabel.frame.size;
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing, 0.0, - titleSize.width);
    [self.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
}

- (void)pressBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if(self.filtrateReusableViewBlock){
        self.filtrateReusableViewBlock(sender.selected,self.index);
    }
}

-(void)setDic:(NSDictionary *)dic {
    _dic = dic;
    if([dic[@"switch"] integerValue]==1){//展开
        self.rightBtn.selected=YES;
    }else{//关闭
        self.rightBtn.selected=NO;
    }
    NSString *stateStr = dic[@"showRight"];
    if([stateStr isEqualToString:@"1"]){
        self.rightBtn.hidden = NO;
    }else{
        self.rightBtn.hidden = YES;
    }
    
}

-(void)showAnimateDown:(BOOL)isON{
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animate.duration = 0.5;
    animate.beginTime = 0;
    if(isON){
        animate.toValue = @(M_PI);
    }else{
        animate.toValue = @(0);
    }
    animate.removedOnCompletion = NO;
    animate.fillMode = kCAFillModeForwards;
    [self.rightBtn.layer addAnimation:animate forKey:nil];
}
@end
