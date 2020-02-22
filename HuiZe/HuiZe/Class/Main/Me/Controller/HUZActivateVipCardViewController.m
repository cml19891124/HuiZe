//
//  HUZActivateVipCardViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZActivateVipCardViewController.h"

@interface HUZActivateVipCardViewController ()

@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UITextField *tfNumber;
@property (nonatomic,strong) UIImageView *ivDiviceline1;
@property (nonatomic,strong) UITextField *tfPsd;
@property (nonatomic,strong) UIImageView *ivDiviceline2;
@property (nonatomic,strong) UIButton *btnActivate;
@end

@implementation HUZActivateVipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"激活VIP卡";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}
-(void)postActivate {
    NSString *numText = self.tfNumber.text;
    if (numText.length == 0) {
        [self presentErrorSheet:@"序列号不能为空"];
        return;
    }
    NSString *psdText= self.tfPsd.text;
    if (psdText.length == 0) {
        [self presentErrorSheet:@"请输入密码"];
        return;
    }
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"serialNumber"] = numText;
    par[@"password"] = psdText;
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_POST:kUrl_uservip_activationr parameters:par success:^(id  _Nonnull responseObject) {
        [self removeOverFlowActivityView];
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [self presentSuccessSheet:@"激活成功"];
            [self.navigationController popViewControllerAnimated:true];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:error];
    }];
}
- (void)configComponents{
    [super configComponents];
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = COLOR_BG_WHITE;
    
    self.tfNumber = [UITextField new];
    self.tfNumber.placeholder = @"请输入VIP序列号";
    self.tfNumber.font = FontS(FONT_15);
    self.tfNumber.textColor = ColorS(COLOR_989898);
    [self.tfNumber addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];

    self.ivDiviceline1 = [UIImageView new];
    self.ivDiviceline1.backgroundColor = ColorS(COLOR_C8C8C8);
    
    self.tfPsd = [UITextField new];
    self.tfPsd.placeholder = @"请输入VIP密码";
    self.tfPsd.font = FontS(FONT_15);
    self.tfPsd.textColor = ColorS(COLOR_989898);
    [self.tfPsd addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];


    self.ivDiviceline2 = [UIImageView new];
    self.ivDiviceline2.backgroundColor = ColorS(COLOR_C8C8C8);
    
    self.btnActivate = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnActivate setTitle:@"激活" forState:UIControlStateNormal];
    self.btnActivate.enabled = NO;
    ViewRadius(self.btnActivate, AutoDistance(22));
 
    [self.view addSubview:self.ivBg];
    [self.ivBg addSubview:self.tfNumber];
    [self.ivBg addSubview:self.ivDiviceline1];
    [self.ivBg addSubview:self.tfPsd];
    [self.ivBg addSubview:self.ivDiviceline2];
    [self.ivBg addSubview:self.btnActivate];
    HUZWEAK_SELF;
    [self.btnActivate addTapAction:^(id  _Nonnull sender) {
        [weakSelf postActivate];
    }];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.tfNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(59));
        make.centerX.equalTo(self.ivBg);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(21)));
    }];
    
    [self.ivDiviceline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfNumber.mas_bottom).offset(AutoDistance(6));
        make.centerX.equalTo(self.ivBg);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(1)));
    }];
    
    [self.tfPsd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivDiviceline1.mas_bottom).offset(AutoDistance(64));
        make.centerX.equalTo(self.ivBg);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(21)));
    }];
    
    [self.ivDiviceline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPsd.mas_bottom).offset(AutoDistance(6));
        make.centerX.equalTo(self.ivBg);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(1)));
    }];
    
    [self.btnActivate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ivBg);
        make.top.equalTo(self.ivDiviceline2.mas_bottom).offset(AutoDistance(64));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH- AutoDistance(76), AutoDistance(44)));
    }];
}

- (void)tfTextChange:(UITextField *)textField{
    self.btnActivate.enabled = (DRStringIsNotEmpty(self.tfNumber.text) && DRStringIsNotEmpty(self.tfPsd.text)) ? YES : NO;
}

@end
