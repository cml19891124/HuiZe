//
//  HUZGradeCityRadioCell.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeCityRadioCell.h"

@implementation HUZGradeCityRadioCell


+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZGradeCityRadioCell";
    HUZGradeCityRadioCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)initView{
    
    self.labTrade = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labTrade.text = @"北京";
    self.labTrade.adjustsFontSizeToFitWidth = YES;
    
    self.progressView = [ZYLineProgressView new];
    self.progressView.config.backLineColor = ColorS(COLOR_BG_D8D8D8);
    self.progressView.config.progressLineColor = ColorS(COLOR_BG_2E86FF);
    self.progressView.config.isShowDot = NO;
    self.progressView.progress = 0.632;
    
    self.labRadio = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labRadio.text = @"78.06%";
    
    [self addSubview:self.labTrade];
    [self addSubview:self.progressView];
    [self addSubview:self.labRadio];
    
    self.labTrade.frame = CGRectMake(AutoDistance(24), AutoDistance(9), AutoDistance(49), AutoDistance(20));
    self.progressView.frame = CGRectMake(AutoDistance(73), AutoDistance(17), AutoDistance(185), AutoDistance(5));
    self.labRadio.frame = CGRectMake(AutoDistance(270), AutoDistance(9), AutoDistance(49), AutoDistance(23));
}


@end
