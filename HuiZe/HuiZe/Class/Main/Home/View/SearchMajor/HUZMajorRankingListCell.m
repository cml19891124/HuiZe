//
//  HUZMajorRankingListCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorRankingListCell.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZMajorRankingModel.h"
#import "HUZUniInfoAssessModel.h"
@interface HUZMajorRankingListCell ()

@property (nonatomic,strong) UILabel *labRanking;
@property (nonatomic,strong) UILabel *labMajor;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZMajorRankingListCell
- (void)setAssessModel:(HUZUniInfoAssessModel *)assessModel {
    _assessModel = assessModel;
    self.labRanking.text = [NSString stringWithFormat:@"%zd",self.indexPath.row+1];
    self.labMajor.text = assessModel.schoolName;
    self.labDes.hidden = NO;
    self.labDes.text = assessModel.assessResult;
}
-(void)setRankingModel:(HUZMajorRankingModel *)rankingModel {
    _rankingModel = rankingModel;
    self.labRanking.text = [NSString stringWithFormat:@"%zd",self.indexPath.row+1];
    self.labMajor.text = rankingModel.schoolName;
    self.labDes.hidden = NO;
    self.labDes.text = rankingModel.assessResult;
}

-(void)setMajorModel:(HUZUniInfoGeneralizeMajorModel *)majorModel {
    _majorModel = majorModel;
    self.labRanking.text = majorModel.ranking;
    self.labMajor.text = majorModel.category;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZMajorRankingListCell";
    HUZMajorRankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    self.labRanking = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    ViewBorderRadius(self.labRanking, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
    
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labMajor.text = @"计算机类";
    self.labMajor.adjustsFontSizeToFitWidth = YES;
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_F19147) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentRight];
    self.labDes.text = @"A +++";
    self.labDes.hidden = YES;
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labRanking];
    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(24), AutoDistance(24)));
    }];
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.labRanking.mas_right).offset(AutoDistance(12));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(240), AutoDistance(21)));
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
    
}

- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath{
//    self.labRanking.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    if (indexPath.row < 3) {
        self.labRanking.backgroundColor = ColorS(COLOR_BG_2E86FF);
        self.labRanking.textColor = ColorS(COLOR_ffffff);
        ViewBorderRadius(self.labRanking, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
    }else{
        self.labRanking.backgroundColor = COLOR_BG_WHITE;
        self.labRanking.textColor = ColorS(COLOR_2E86FF);
        ViewBorderRadius(self.labRanking, AutoDistance(4), AutoDistance(1), ColorS(COLOR_BG_2E86FF));
    }
}
@end
