//
//  HUZUniContinueStudyCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniContinueStudyCell.h"

@implementation HUZUniContinueStudyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniContinueStudyCell";
    HUZUniContinueStudyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return AutoDistance(178);
}

- (void)initView{
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = ColorS(COLOR_BG_000000);
    self.ivBg.alpha = 0.06;
    ViewRadius(self.ivBg, AutoDistance(8));
    
    self.progressView1 = [[ZZCircleProgress alloc] initWithFrame:CGRectZero pathBackColor:ColorS(COLOR_BG_D8D8D8) pathFillColor:ColorS(COLOR_BG_2E86FF) startAngle:0 strokeWidth:AutoDistance(4)];
    self.progressView1.showPoint = NO;
    self.progressView1.showProgressText = NO;
//    self.progressView1.progress = 0.88;
    
    self.progressView2 = [[ZZCircleProgress alloc] initWithFrame:CGRectZero pathBackColor:ColorS(COLOR_BG_D8D8D8) pathFillColor:ColorS(COLOR_BG_2E86FF) startAngle:0 strokeWidth:AutoDistance(4)];
    self.progressView2.showPoint = NO;
    self.progressView2.showProgressText = NO;
//    self.progressView2.progress = 0.37;
    
    self.labContent1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_10)];
    self.labContent1.text = @"读研";
    
    self.labContent2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_10)];
    self.labContent2.text = @"出国";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
//    self.labDes1.text = @"84.82%";
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
//    self.labDes2.text = @"37.8%";

    [self.contentView addSubview:self.ivBg];
    [self.contentView addSubview:self.progressView1];
    [self.contentView addSubview:self.progressView2];
    [self.contentView addSubview:self.labContent1];
    [self.contentView addSubview:self.labContent2];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(152)));
    }];
    
    [self.progressView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(32));
        make.left.mas_offset(AutoDistance(52));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
    }];
    
    [self.progressView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(32));
        make.right.mas_offset(-AutoDistance(52));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
    }];
    
    [self.labContent1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(55));
        make.left.mas_offset(AutoDistance(71));
    }];
    
    [self.labContent2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(55));
        make.right.mas_offset(-AutoDistance(71));
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView1.mas_bottom).offset(AutoDistance(7));
        make.centerX.equalTo(self.progressView1);
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView2.mas_bottom).offset(AutoDistance(7));
        make.centerX.equalTo(self.progressView2);
    }];
}

- (void)setUniInfoModel:(HUZUniInfoGeneralizeDataModel *)uniInfoModel{
    self.progressView1.progress = [uniInfoModel.studyRatio floatValue];
    self.progressView2.progress = [uniInfoModel.abroadRatio floatValue];
    self.labDes1.text = [NSString stringWithFormat:@"%@%%",uniInfoModel.studyRatio];
    self.labDes2.text = [NSString stringWithFormat:@"%@%%",uniInfoModel.abroadRatio];

}

@end
