//
//  HUZThirdLoginView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZThirdLoginView.h"

@implementation HUZThirdLoginView

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    UIView *tipView = ({
        UIView *view = [UIView new];
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(AutoDistance(38), AutoDistance(10), AutoDistance(88), AutoDistance(1))];
        leftView.backgroundColor = [UIColor whiteColor];
        [view addSubview:leftView];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((HUZSCREEN_WIDTH - AutoDistance(80))/2, 0, AutoDistance(80), AutoDistance(20))];
        lab.text = @"第三方登录";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = FontS(FONT_14);
        lab.textColor = ColorS(COLOR_C8C8C8);
        [view addSubview:lab];
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH - AutoDistance(88) - AutoDistance(38),  AutoDistance(10), AutoDistance(88), AutoDistance(1))];
        rightView.backgroundColor = [UIColor whiteColor];
        [view addSubview:rightView];
        view;
    });
    self.btnQQ = [[UIButton alloc] initWithImage:ImageNamed(@"ic_login_qq")];
    self.btnWechat = [[UIButton alloc] initWithImage:ImageNamed(@"ic_login_wechat")];
    self.btnWb = [[UIButton alloc] initWithImage:ImageNamed(@"ic_login_wb")];
    
    [self addSubview:tipView];
    [self addSubview:self.btnQQ];
    [self addSubview:self.btnWechat];
    [self addSubview:self.btnWb];
    [self addSubview:self.aLable];

    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(AutoDistance(10));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(25));
        make.centerX.mas_equalTo(self);
    }];
    
    [self.btnWb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_bottom).offset(HUZIPHONESE ? AutoDistance(10) : AutoDistance(20));
        make.centerX.mas_equalTo(self);
    }];
    self.btnWb.hidden = YES;
    [self.btnQQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnWb.mas_left).offset(0);//-AutoDistance(63)
        make.centerY.mas_equalTo(self.btnWb);
    }];
    
    [self.btnWechat mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.btnWb.mas_right).offset(0);//AutoDistance(63)
        make.centerY.mas_equalTo(self.btnWb);
    }];
    
    
    [self.aLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
//        make.bottom.equalTo(self).offset(HUZIPHONESE ? -AutoDistance(15):-AutoDistance(10));
        make.top.equalTo(self.btnWechat.mas_bottom).mas_equalTo(AutoDistance(10));
    }];
}

- (TTTAttributedLabel *)aLable
{
    if (!_aLable)
    {
        _aLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _aLable.lineBreakMode = NSLineBreakByWordWrapping;
        _aLable.delegate = self;
        _aLable.font = FontS(FONT_12);
        _aLable.textColor = COLOR_BG_WHITE;
        //要放在`text`, with either `setText:` or `setText:afterInheritingLabelAttributesAndConfiguringWithBlock:前面才有效
        _aLable.enabledTextCheckingTypes = NSTextCheckingTypePhoneNumber|NSTextCheckingTypeAddress|NSTextCheckingTypeLink;
        //链接正常状态文本属性
        _aLable.linkAttributes = @{NSForegroundColorAttributeName:ColorS(COLOR_2E86FF),NSUnderlineStyleAttributeName:@(1)};
        //链接高亮状态文本属性
        _aLable.activeLinkAttributes = @{NSForegroundColorAttributeName:ColorS(COLOR_2E86FF),NSUnderlineStyleAttributeName:@(1)};
        _aLable.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
        NSString *text = @"登录/注册即代表同意《慧择云志愿用户协议》";
        __block NSRange boldRange;
        [_aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            // 设置可点击文字的范围
            boldRange = [[mutableAttributedString string] rangeOfString:@"《慧择云志愿用户协议》" options:NSCaseInsensitiveSearch];
            //设定可点击文字的的大小
            UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:12];
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName,
                                                               boldSystemFont.pointSize, NULL);
            if (font) {
                //设置可点击文本的大小
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
                //设置可点击文本的颜色
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[ColorS(COLOR_2E86FF) CGColor] range:boldRange];
                CFRelease(font);
            }
            return mutableAttributedString;
        }];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.exiucai.com/"]];
        //设置链接的url
        [_aLable addLinkToURL:url withRange:boldRange];
    }
    return _aLable;
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"linkClick");
}
@end
