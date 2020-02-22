//
//  HUZHomeSearchView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHomeSearchView.h"

@implementation HUZHomeSearchView

- (void)initView{
        
    self.labCd = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_10) numberOfLines:2];
    self.labCd.text = @"距离高考";
    
    self.labDayNum = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:BoldFontS(FONT_22)];
    self.labDayNum.text = [HUZInsureValidate getGkTimeStamp];
    
    self.labDay = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_10)];
    self.labDay.text = @"天";
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = ColorS(COLOR_000000);
    self.ivBg.alpha = 0.08;
    ViewRadius(self.ivBg, 4);
    
    self.ivSearch = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_search")];
    
    self.labKeyword = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
    self.labKeyword.text = @"搜索学校、专业";
    
    [self addSubview:self.labCd];
    [self addSubview:self.labDayNum];
    [self addSubview:self.labDay];
    [self addSubview:self.ivBg];
    [self addSubview:self.ivSearch];
    [self addSubview:self.labKeyword];
    
    
    [self.labCd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(AutoDistance(5));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(21), AutoDistance(26)));
    }];
    
    [self.labDayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labCd).offset(-AutoDistance(3));
        make.left.equalTo(self.labCd.mas_right).offset(AutoDistance(2));
    }];

    [self.labDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labCd);
        make.left.equalTo(self.labDayNum.mas_right).offset(AutoDistance(3));
    }];

    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
//        make.left.equalTo(self).offset(AutoDistance(88));
        make.left.equalTo(self.labDay.mas_right).mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(257), AutoDistance(30)));
    }];

    [self.ivSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivBg);
        make.left.equalTo(self.ivBg).offset(AutoDistance(12));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(15), AutoDistance(15)));
    }];

    [self.labKeyword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivBg);
        make.left.equalTo(self.ivSearch.mas_right).offset(AutoDistance(8));
    }];
    
    [self.ivBg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        HUZSearchViewController *searchVC = [HUZSearchViewController new];
        [[UIViewController currentViewController].navigationController pushViewController:searchVC animated:YES];
    }];
    
}
    

@end
