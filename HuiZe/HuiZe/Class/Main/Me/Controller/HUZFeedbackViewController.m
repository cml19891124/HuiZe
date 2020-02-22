//
//  HUZFeedbackViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZFeedbackViewController.h"
#import "HUZMineService.h"

@interface HUZFeedbackViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UIView *ivContact;
@property (nonatomic,strong) UILabel *labContact;
@property (nonatomic,strong) UILabel *labMobile;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIView *ivFeedback;
@property (nonatomic,strong) UITextView *tvFeedback;

@property (nonatomic,strong) NSString *phone;
@end

@implementation HUZFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self showBarButton:NAV_RIGHT title:@"发布" fontColor:ColorS(COLOR_2E86FF)];
}

- (void)rightButtonTouch{
    NSString *feedbackStr = self.tvFeedback.text;
    NSString *phoneStr = [HUZTools isCheckPhone:self.phone];
    if (DRStringIsEmpty(feedbackStr)) {
        return [self presentSheet:@"请输入反馈内容"];
    }
    if (DRStringIsNotEmpty(phoneStr)) {
        return [self presentSheet:phoneStr];
    }
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZMineService getFeedBackWithParameters:@{@"content":feedbackStr,@"phone":self.phone} success:^(HUZModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentSheet:@"反馈成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}


- (void)configComponents{
    [super configComponents];
    
    self.ivContact = [UIView new];
    self.ivContact.backgroundColor = COLOR_BG_WHITE;
    
    self.labContact = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    self.labContact.text = @"联系方式";
    
    self.labMobile = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentRight];
    self.labMobile.text = HUZUserCenterManager.userModel.mobile;
    self.phone = HUZUserCenterManager.userModel.mobile;
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivFeedback = [UIView new];
    self.ivFeedback.backgroundColor = COLOR_BG_WHITE;
    
    self.tvFeedback = [UITextView new];
    [self.tvFeedback jk_addPlaceHolder:@"说说你在使用产品过程中的问题或意见吧~"];
    self.tvFeedback.textColor = ColorS(COLOR_414141);
    self.tvFeedback.font = FontS(FONT_14);
    self.tvFeedback.delegate = self;
    
    [self.view addSubview:self.ivContact];
    [self.ivContact addSubview:self.labContact];
    [self.ivContact addSubview:self.labMobile];
    [self.ivContact addSubview:self.ivArrow];
    
    [self.view addSubview:self.ivFeedback];
    [self.ivFeedback addSubview:self.tvFeedback];
    
    [self.ivContact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(8));
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(AutoDistance(58));
    }];
    
    [self.labContact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.ivContact);
    }];
    
    [self.labMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(29));
        make.centerY.equalTo(self.ivContact);
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.ivContact);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(10), AutoDistance(10)));
    }];
    
    [self.ivFeedback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivContact.mas_bottom).offset(AutoDistance(24));
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(AutoDistance(240));
    }];
    
    [self.tvFeedback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(15));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
        make.bottom.mas_offset(-AutoDistance(15));
    }];
    
    HUZWEAK_SELF
    [self.ivContact jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
        [popView popInputAlertWithTitle:@"联系方式" placeholder:@"请输入联系方式"];
        popView.inputViewBlock = ^(NSString *str) {
            HUZSTRONG_SELF
            strongSelf.labMobile.text = str;
            strongSelf.phone = str;
        };
    }];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (DRStringIsNotEmpty(textView.text) && DRStringIsNotEmpty(self.phone)) {
        [self showBarButton:NAV_RIGHT title:@"发布" fontColor:ColorS(COLOR_2E86FF)];
    }else{
        [self showBarButton:NAV_RIGHT title:@"发布" fontColor:ColorS(COLOR_C8C8C8)];
    }
}

@end

