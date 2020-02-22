//
//  HUZMyGkInfoView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMyGkInfoView.h"

@interface HUZMyGkInfoView ()

@property (nonatomic,strong) UIButton *btnBack;
@property (nonatomic,strong) UIView *ivBg1;
@property (nonatomic,strong) UILabel *labProvince;
@property (nonatomic,strong) UIImageView *ivLock;
@property (nonatomic,strong) UILabel *labTip;
@property (nonatomic,strong) UILabel *labSubjectTip;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UILabel *labScoreTip;
@property (nonatomic,strong) UIView *ivBg2;
@property (nonatomic,strong) UILabel *labScore;
@property (nonatomic,strong) UILabel *labFen;
@property (nonatomic,strong) UILabel *labRankingTip;
@property (nonatomic,strong) UIView *ivBg3;
@property (nonatomic,strong) UILabel *labRanking;
@property (nonatomic,strong) UILabel *labMin;
@property (nonatomic,strong) UIButton *btnConfirm;

@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,copy) NSString *grade; // 文理科：0文科 1理科,2综合 ,
@property (nonatomic,copy) NSString *examinationProvince; // 高考省份
@end

@implementation HUZMyGkInfoView


- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.btnBack = [[UIButton alloc] initWithTitle:@"高考信息" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_24)];
    [self.btnBack setImage:ImageNamed(NAV_BACK_BLACK) forState:UIControlStateNormal];
    [self.btnBack LeftImageRightTitleWithSpace:AutoDistance(15)];
    [self.btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.ivBg1 = [UIView new];
    ViewBorderRadius(self.ivBg1, AutoDistance(4), AutoDistance(1), ColorS(COLOR_C8C8C8));
    
    self.examinationProvince = HUZUserCenterManager.userModel.provinceName;
    self.labProvince = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.labProvince.text = self.examinationProvince;
    
    self.ivLock = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_lock")];
    
    self.labTip = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_10)];
    self.labTip.text = @"注:高考省份不可修改、如需修改请联系客服";
    
    self.labSubjectTip = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    self.labSubjectTip.text = @"选择的科目";
    
    self.btnArray = [NSMutableArray new];
    
    self.btn1 = [[UIButton alloc] initWithTitle:@"理科" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.btn1.tag = 1;
    //COLOR_ffffff
    //ViewBorderRadius(self.btn1, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
    ViewBorderRadius(self.btn1, AutoDistance(4), AutoDistance(1), ColorS(COLOR_989898));
    [self.btn1 addTarget:self action:@selector(clickSubject:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [[UIButton alloc] initWithTitle:@"文科" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.btn2.tag = 2;
    ViewBorderRadius(self.btn2, AutoDistance(4), AutoDistance(1), ColorS(COLOR_989898));
    [self.btn2 addTarget:self action:@selector(clickSubject:) forControlEvents:UIControlEventTouchUpInside];

    self.btn3 = [[UIButton alloc] initWithTitle:@"新高考" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.btn3.tag = 3;
    ViewBorderRadius(self.btn3, AutoDistance(4), AutoDistance(1), ColorS(COLOR_989898));
    [self.btn3 addTarget:self action:@selector(clickSubject:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    self.btn3.userInteractionEnabled = NO;
    NSString *grade = HUZUserCenterManager.userModel.grade;
    self.grade = grade;
    switch ([grade integerValue]) {
        case 1: // 理科
        {
            [self.btn1 setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
            ViewBorderRadius(self.btn1, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
            self.btn1.backgroundColor = ColorS(COLOR_BG_2E86FF);
        }
            break;
        case 0: // 文科
        {
            [self.btn2 setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
            ViewBorderRadius(self.btn2, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
            self.btn2.backgroundColor = ColorS(COLOR_BG_2E86FF);
        }
            break;
        case 2: // 综合
        {
            [self.btn3 setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
            ViewBorderRadius(self.btn3, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
            self.btn3.backgroundColor = ColorS(COLOR_BG_2E86FF);
        }
            break;
        default:
            break;
    }
    
    [self.btnArray addObject:self.btn1];
    [self.btnArray addObject:self.btn2];
    [self.btnArray addObject:self.btn3];

    self.labScoreTip = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    self.labScoreTip.text = @"高考成绩预估分数";
    
    self.ivBg2 = [UIView new];
    ViewBorderRadius(self.ivBg2, AutoDistance(4), AutoDistance(1), ColorS(COLOR_C8C8C8));
    
    self.labScore = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17)];
    self.labScore.text = HUZUserCenterManager.userModel.estimateScore;
    
    self.labFen = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.labFen.text = @"分";
    
    self.labRankingTip = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    self.labRankingTip.text = @"高考排名";
    
    self.ivBg3 = [UIView new];
    ViewBorderRadius(self.ivBg3, AutoDistance(4), AutoDistance(1), ColorS(COLOR_C8C8C8));
    
    self.labRanking = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17)];
    self.labRanking.text = HUZUserCenterManager.userModel.estimateRanking;
    
    self.labMin = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.labMin.text = @"名";
    
    self.btnConfirm = [[UIButton alloc] initWithTitle:@"确定" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_17)];
    self.btnConfirm.backgroundColor = ColorS(COLOR_BG_2E86FF);
    [self.btnConfirm addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.btnConfirm, AutoDistance(22));
    
    [self addSubview:self.btnBack];
    [self addSubview:self.ivBg1];
    [self.ivBg1 addSubview:self.labProvince];
    [self.ivBg1 addSubview:self.ivLock];
    [self addSubview:self.labTip];
    
    [self addSubview:self.labSubjectTip];
    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
    [self addSubview:self.btn3];
    
    [self addSubview:self.labScoreTip];
    [self addSubview:self.ivBg2];
    [self.ivBg2 addSubview:self.labScore];
    [self.ivBg2 addSubview:self.labFen];
    
    [self addSubview:self.labRankingTip];
    [self addSubview:self.ivBg3];
    [self.ivBg3 addSubview:self.labRanking];
    [self.ivBg3 addSubview:self.labMin];
    
    [self addSubview:self.btnConfirm];
    
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(120),AutoDistance(33)));
    }];
    
    [self.ivBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnBack.mas_bottom).offset(AutoDistance(32));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(38)));
    }];
    
    [self.labProvince mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.ivBg1);
    }];
    
    [self.ivLock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.ivBg1);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(17), AutoDistance(17)));
    }];
    
    [self.labTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg1.mas_bottom).offset(AutoDistance(5));
        make.left.mas_offset(AutoDistance(50));
    }];
    
    [self.labSubjectTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTip.mas_bottom).offset(AutoDistance(35));
        make.left.mas_offset(AutoDistance(38));
    }];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSubjectTip.mas_bottom).offset(AutoDistance(14));
        make.left.mas_offset(AutoDistance(38));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(88), AutoDistance(38)));
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSubjectTip.mas_bottom).offset(AutoDistance(14));
        make.left.equalTo(self.btn1.mas_right).offset(AutoDistance(18));
        make.size.equalTo(self.btn1);
    }];
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSubjectTip.mas_bottom).offset(AutoDistance(14));
        make.left.equalTo(self.btn2.mas_right).offset(AutoDistance(18));
        make.size.equalTo(self.btn1);
    }];
    
    [self.labScoreTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_bottom).offset(AutoDistance(54));
        make.left.mas_offset(AutoDistance(38));
    }];
    
    [self.ivBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labScoreTip.mas_bottom).offset(AutoDistance(14));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(38)));
    }];

    [self.labScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.ivBg2);
    }];

    [self.labFen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.ivBg2);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(24)));
    }];

    [self.labRankingTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg2.mas_bottom).offset(AutoDistance(54));
        make.left.mas_offset(AutoDistance(38));
    }];

    [self.ivBg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labRankingTip.mas_bottom).offset(AutoDistance(14));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(38)));
    }];

    [self.labRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.ivBg3);
    }];

    [self.labMin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.ivBg3);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(24)));
    }];
    
    [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-AutoDistance(21));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(299), AutoDistance(44)));
    }];
    
    [self.ivBg2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickScore)]];
    [self.ivBg3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRanking)]];

}

- (void)back{
    [[UIViewController currentViewController].navigationController popViewControllerAnimated:YES];
}


/// 选择的科目
- (void)clickSubject:(UIButton *)sender{
    switch (sender.tag) {
        case 1: // 理科
            self.grade = @"1";
            break;
        case 2: // 文科
            self.grade = @"0";
            break;
        case 3: // 综合
            self.grade = @"2";
            break;
        default:
            break;
    }
    for (UIButton *button in self.btnArray) {
        if (button.tag == sender.tag) {
            button.backgroundColor = ColorS(COLOR_BG_2E86FF);
            [button setTitleColor:ColorS(COLOR_ffffff) forState:UIControlStateNormal];
            ViewBorderRadius(button, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
        }else{
            button.backgroundColor = COLOR_BG_WHITE;
            [button setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
            ViewBorderRadius(button, AutoDistance(4), AutoDistance(1), ColorS(COLOR_989898));
        }
    }
}

/// 高考成绩预估分数
- (void)clickScore{
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
    [popView popInputAlertWithTitle:@"高考成绩预估分数" placeholder:@"请输入分数"];
    HUZWEAK_SELF
    popView.inputViewBlock = ^(NSString *str) {
        HUZSTRONG_SELF
        strongSelf.labScore.text = str;
    };
}

/// 高考排名
- (void)clickRanking{
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
    [popView popInputAlertWithTitle:@"高考排名预估" placeholder:@"请输入排名"];
    HUZWEAK_SELF
    popView.inputViewBlock = ^(NSString *str) {
        HUZSTRONG_SELF
        strongSelf.labRanking.text = str;
    };
}

- (void)sureClick {
    if (DRStringIsEmpty(self.grade)) {
         [MBProgressHUD showError:@"请选择科目" toView:self];
        return;
    }
    if (DRStringIsEmpty(self.labScore.text)) {
        [MBProgressHUD showError:@"请输入高考成绩预估分数" toView:self];
        return;
    }
    if (DRStringIsEmpty(self.labRanking.text)) {
        [MBProgressHUD showError:@"请输入预估高考排名" toView:self];
        return;
    }
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:self.labScore.text forKey:@"estimateScore"];
    [postDic setValue:self.labRanking.text forKey:@"estimateRanking"];
    [postDic setValue:self.examinationProvince forKey:@"examinationProvince"];
    [postDic setValue:self.grade forKey:@"grade"];
    
    [postDic setValue:HUZUserCenterManager.userModel.examinationYear forKey:@"examinationYear"];
    [postDic setValue:HUZUserCenterManager.userModel.userRole forKey:@"userRole"];
    
    if (_callBackBlock) {
        _callBackBlock(postDic);
    }
    
}
@end

