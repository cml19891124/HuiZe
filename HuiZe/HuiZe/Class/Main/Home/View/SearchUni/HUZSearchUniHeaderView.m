//
//  HUZSearchUniHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchUniHeaderView.h"

@implementation HUZSearchUniHeaderView

- (void)initView{
    
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    UIView *ivWhite = [UIView new];
    ivWhite.backgroundColor = COLOR_BG_WHITE;
    
    self.bannerView = [HUZHomeBannerView new];
    
    self.ivAllUni = [[HUZSearchUniFunctionView alloc] initWithIcon:@"ic_all_uni" title:@"全部高校"];
    self.ivProvinceUni = [[HUZSearchUniFunctionView alloc] initWithIcon:@"ic_province_uni" title:@"本省高校"];
    self.ivUniList = [[HUZSearchUniFunctionView alloc] initWithIcon:@"ic_uni_list" title:@"高校榜单"];
    self.ivUniPK = [[HUZSearchUniFunctionView alloc] initWithIcon:@"ic_uni_pk" title:@"高校PK"];
    self.ivUniPK.hidden = YES;
    self.ivAllUni.tag = 1;
    self.ivProvinceUni.tag = 2;
    self.ivUniList.tag = 3;
    self.ivUniPK.tag = 4;

    [self addSubview:ivWhite];
    [self addSubview:self.bannerView];
    [self addSubview:self.ivAllUni];
    [self addSubview:self.ivProvinceUni];
    [self addSubview:self.ivUniList];
    [self addSubview:self.ivUniPK];
    
    CGFloat bgH = HUZSCREEN_WIDTH >= 414 ? 283 : 253;
    [ivWhite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(bgH);
    }];
        
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(BannerH);
    }];
    if (self.type == HUZSearchMajor) {
        
        [self.ivAllUni mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom);
            make.left.mas_offset(AutoDistance(27));
            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
        }];
        
        [self.ivProvinceUni mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom);
            make.left.equalTo(self.ivAllUni.mas_right).offset(AutoDistance(27));
            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
        }];
        
        [self.ivUniPK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom);
            make.right.mas_offset(-AutoDistance(27));
            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
        }];
        
        [self.ivUniList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom);
            make.right.equalTo(self.ivUniPK.mas_left).offset(-AutoDistance(27));
            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
        }];
    }else{
        CGFloat w = (HUZSCREEN_WIDTH - 3*AutoDistance(60) - 2*AutoDistance(27)) / 2.0;
        [self.ivAllUni mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom);
            make.left.mas_offset(AutoDistance(27));
            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
        }];
        
        [self.ivProvinceUni mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom);
            make.left.equalTo(self.ivAllUni.mas_right).offset(AutoDistance(w));
            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
        }];
        
//        [self.ivUniPK mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.bannerView.mas_bottom);
//            make.right.mas_offset(-AutoDistance(27));
//            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
//        }];
        [self.ivUniList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom);
            make.right.mas_offset(-AutoDistance(27));
            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
        }];
//
//        [self.ivUniList mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.bannerView.mas_bottom);
//            make.right.equalTo(self.ivProvinceUni.mas_left).offset(-AutoDistance(27));
//            make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
//        }];
    }

}

- (void)setType:(HUZSearchUniOrMajorType)type{
    _type = type;
    if (type == HUZSearchMajor) {
        self.ivUniPK.hidden = YES;
        self.ivUniList.hidden = YES;
        self.ivAllUni.labFunction.text = @"所有专业";
        self.ivProvinceUni.labFunction.text = @"学科评估";
        self.ivAllUni.ivFunction.image = ImageNamed(@"ic_all_major");
        self.ivProvinceUni.ivFunction.image = ImageNamed(@"ic_major_list");
    }
}

@end

