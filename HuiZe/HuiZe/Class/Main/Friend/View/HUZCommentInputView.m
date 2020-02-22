//
//  HUZCommentInputView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCommentInputView.h"

@interface HUZCommentInputView ()

@property (nonatomic,strong) UIView *ivLayer;
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIView *ivTop;
@property (nonatomic,strong) UIView *ivBlue;
@property (nonatomic,strong) UILabel *labTip;
@property (nonatomic,strong) UIView *ivBottom;
@property (nonatomic,strong) UITextView *tvText;
@property (nonatomic,strong) UIButton *btnCommit;
@end

@implementation HUZCommentInputView

- (void)initView{
    
    self.ivLayer = [UIView new];
    self.ivLayer.backgroundColor = ColorS(COLOR_000000);
    self.ivLayer.alpha = 0.4;
    self.ivLayer.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT);
    self.ivLayer.userInteractionEnabled = YES;
    
    self.ivBg = [[UIView alloc] initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(165))];
    self.ivBg.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [UIView huz_bezierPathWithRoundedRect:self.ivBg];
    
    self.ivTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(50))];
    self.ivTop.backgroundColor = COLOR_BG_WHITE;
    
    self.ivBlue = [[UIView alloc] initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(18), AutoDistance(4), AutoDistance(14))];
    self.ivBlue.backgroundColor = ColorS(COLOR_BG_2E86FF);
    
    self.labTip = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labTip.frame = CGRectMake(AutoDistance(27), AutoDistance(15), AutoDistance(250), AutoDistance(21));
    
    self.ivBottom = [[UIView alloc] initWithFrame:CGRectMake(0, AutoDistance(58), HUZSCREEN_WIDTH, AutoDistance(107))];
    self.ivBottom.backgroundColor = COLOR_BG_WHITE;
    
    self.tvText = [[UITextView alloc] initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(12), HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(50))];
    [self.tvText jk_addPlaceHolder:@"友善的评论是交流的起点"];
    self.tvText.font = FontS(FONT_15);
    self.tvText.textColor = ColorS(COLOR_414141);
    
    self.btnCommit = [[UIButton alloc] initWithTitle:@"发布" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17)];
    self.btnCommit.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(50), AutoDistance(70), AutoDistance(38), AutoDistance(24));
    
    [self addSubview:self.ivLayer];
    [self addSubview:self.ivBg];
    [self.ivBg addSubview:self.ivTop];
    [self.ivTop addSubview:self.ivBlue];
    [self.ivTop addSubview:self.labTip];
    
    [self.ivBg addSubview:self.ivBottom];
    [self.ivBottom addSubview:self.tvText];
    [self.ivBottom addSubview:self.btnCommit];
    
    
    [self.ivLayer addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    [self.ivBg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
    [self.btnCommit addTarget:self action:@selector(commitCommentClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForInputview" context:nil];
    [UIView setAnimationDuration:0.3f];
    [self showFrame:height];
    [UIView commitAnimations];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
}

- (void)setTitle:(NSString *)title{
    self.labTip.text = title;
}

- (void)commitCommentClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commitComment:)]) {
        [self.delegate commitComment:self.tvText.text];
    }
}

- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self setFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    [self.tvText becomeFirstResponder];
    [UIView commitAnimations];
}

- (void)dismiss{
    
    [UIView beginAnimations:@"dismiss" context:nil];
    [UIView setAnimationDuration:0.3f];
    [self.tvText resignFirstResponder];
    [self dismissFrame];
    [self removeFromSuperview];
    [UIView commitAnimations];
}

- (void)reset{
    self.tvText.text = @"";
}

- (void)showFrame:(int)height{
    [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT-AutoDistance(165)-height, HUZSCREEN_WIDTH, AutoDistance(165))];
}

- (void)dismissFrame{
    [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(165))];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

