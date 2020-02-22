//
//  HUZUniEmploymentRadioCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEmploymentRadioCell.h"
#import "HUZIndustyLeaModel.h"
#import "HUZAreaLeaModel.h"

@interface HUZUniEmploymentRadioCell ()

@property (nonatomic,strong) UIView *ivTop;
@property (nonatomic,strong) UIView *ivCenter;
@property (nonatomic,strong) UIView *ivBottom;

@property (nonatomic,strong) UILabel *labTrade;
@property (nonatomic,strong) ZYLineProgressView *progressView;
@property (nonatomic,strong) UILabel *labRadio;

@end

@implementation HUZUniEmploymentRadioCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniEmploymentRadioCell";
    HUZUniEmploymentRadioCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivTop = [UIView new];
    self.ivTop.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.ivCenter = [UIView new];
    self.ivCenter.backgroundColor = ColorS(COLOR_BG_F6F6F6);

    self.ivBottom = [UIView new];
    self.ivBottom.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.labTrade = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labTrade.text = @"媒体";
    self.labTrade.adjustsFontSizeToFitWidth = YES;
    
    self.progressView = [ZYLineProgressView new];
    self.progressView.config.backLineColor = ColorS(COLOR_BG_D8D8D8);
    self.progressView.config.progressLineColor = ColorS(COLOR_BG_2E86FF);
    self.progressView.config.isShowDot = NO;
    self.progressView.progress = 0.632;
    
    self.labRadio = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labRadio.text = @"78.06%";
    
    [self addSubview:self.ivTop];
    [self addSubview:self.ivCenter];
    [self addSubview:self.ivBottom];
    
    [self.ivCenter addSubview:self.labTrade];
    [self.ivCenter addSubview:self.progressView];
    [self.ivCenter addSubview:self.labRadio];
    
    self.ivTop.frame = CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(23));
    self.ivCenter.frame = CGRectMake(AutoDistance(15), AutoDistance(23),HUZSCREEN_WIDTH-AutoDistance(30) , AutoDistance(38));
    self.ivBottom.frame = CGRectMake(AutoDistance(15), AutoDistance(61), HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(35));
    
    self.labTrade.frame = CGRectMake(AutoDistance(24), AutoDistance(9), AutoDistance(49), AutoDistance(20));
    self.progressView.frame = CGRectMake(AutoDistance(73), AutoDistance(17), AutoDistance(185), AutoDistance(5));
    self.labRadio.frame = CGRectMake(AutoDistance(270), AutoDistance(9), AutoDistance(49), AutoDistance(23));
}

- (void)setType:(HUZUniEmploymentRadioType)type{
    _type = type;
    /// 上半部分圆角
    if (type == HUZUniEmploymentRadioTop) {
        self.ivTop.frame = CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(23));
        self.ivCenter.frame = CGRectMake(AutoDistance(15), AutoDistance(23),HUZSCREEN_WIDTH-AutoDistance(30) , AutoDistance(38));
        self.ivBottom.frame = CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), 0);
    }
    ///没有圆角
    else if (type == HUZUniEmploymentRadioCenter){
        self.ivTop.frame = CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), 0);
        self.ivCenter.frame = CGRectMake(AutoDistance(15), 0,HUZSCREEN_WIDTH-AutoDistance(30) , AutoDistance(38));
        self.ivBottom.frame = CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), 0);
    }
    
    /// 下半部分圆角
    else{
        self.ivTop.frame = CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), 0);
        self.ivCenter.frame = CGRectMake(AutoDistance(15), 0,HUZSCREEN_WIDTH-AutoDistance(30) , AutoDistance(38));
        self.ivBottom.frame = CGRectMake(AutoDistance(15), AutoDistance(38), HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(23));
    }
    
    /// 设置圆角
    [UIView huz_bezierPathWithRoundedRect:self.ivTop];
    [UIView huzBezierPathWithBottomRoundedRect:self.ivBottom];

}

- (void)reloadData:(id)entity{
    /// 行业去向
    if ([entity isKindOfClass:[HUZIndustyLeaDataListModel class]]) {
        HUZIndustyLeaDataListModel *model = (HUZIndustyLeaDataListModel *)entity;
        self.labTrade.text = model.industryEntity.industryName;
        self.progressView.progress = [model.leaTowardsEntity.proportion floatValue]/100;
        self.labRadio.text = [NSString stringWithFormat:@"%@%%",model.leaTowardsEntity.proportion];
    }
    /// 地区去向
    else if ([entity isKindOfClass:[HUZAreaLeaDataListModel class]]){
        HUZAreaLeaDataListModel *model = (HUZAreaLeaDataListModel *)entity;
        self.labTrade.text = model.regionEntity.areaName;
        self.progressView.progress = [model.leaTowardsEntity.proportion floatValue]/100;
        self.labRadio.text = [NSString stringWithFormat:@"%@%%",model.leaTowardsEntity.proportion];

    }
}

@end
