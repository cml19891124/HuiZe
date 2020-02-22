//
//  HUZPostInfoHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPostInfoHeaderView.h"

@interface HUZPostInfoHeaderView ()

@property (nonatomic,strong) UIView *ivTop;
@property (nonatomic,strong) UIImageView *ivHeader;
@property (nonatomic,strong) UILabel *labName;
@property (nonatomic,strong) UILabel *labTime;
@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UILabel *labType;
@property (nonatomic,strong) UIButton *btnLike;
@property (nonatomic,strong) UILabel *labLike;
@property (nonatomic,strong) UIButton *btnComment;
@property (nonatomic,strong) UILabel *labComment;

@property (nonatomic,strong) UIView *ivBottom;
@property (nonatomic,strong) UILabel *labNum;


@end

@implementation HUZPostInfoHeaderView

- (void)initView{
    
    self.ivTop = [UIView new];
    self.ivTop.backgroundColor = COLOR_BG_WHITE;
    
    self.ivHeader = [UIImageView new];
    self.ivHeader.backgroundColor = [UIColor grayColor];
    ViewRadius(self.ivHeader, AutoDistance(14));
    
    self.labName = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    
    self.labTime = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentRight];
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) numberOfLines:0];
    
    self.labType = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    
    self.btnLike = [[UIButton alloc] initWithImageNormal:@"btn_like_normal" imageSeleted:@"btn_like_checked"];;
    
    self.labLike = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    
    self.btnComment = [[UIButton alloc] initWithImage:ImageNamed(@"btn_comment")];
    
    self.labComment = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    
    self.ivBottom = [UIView new];
    self.ivBottom.backgroundColor = COLOR_BG_WHITE;
    
    self.labNum = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.btnRanking = [[UIButton alloc] initWithTitle:@"排序" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    [self.btnRanking setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    
    [self addSubview:self.ivTop];
    [self.ivTop addSubview:self.ivHeader];
    [self.ivTop addSubview:self.labName];
    [self.ivTop addSubview:self.labTime];
    [self.ivTop addSubview:self.labContent];
    [self.ivTop addSubview:self.labType];
    [self.ivTop addSubview:self.btnLike];
    [self.ivTop addSubview:self.labLike];
    [self.ivTop addSubview:self.btnComment];
    [self.ivTop addSubview:self.labComment];
    
    [self addSubview:self.ivBottom];
    [self.ivBottom addSubview:self.labNum];
    [self.ivBottom addSubview:self.btnRanking];
    
    [self.ivTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.right.equalTo(self);
        make.height.mas_offset(AutoDistance(174));
    }];
    
    [self.ivHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(28), AutoDistance(28)));
    }];
    
    
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivHeader);
        make.left.equalTo(self.ivHeader.mas_right).offset(AutoDistance(8));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(200), AutoDistance(21)));
    }];
    
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labName);
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivHeader.mas_bottom).offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.labType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent.mas_bottom).offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(13));
    }];
    
    [self.btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labType);
        make.right.mas_offset(-AutoDistance(100));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(14), AutoDistance(14)));
    }];
    
    [self.labLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnLike);
        make.left.equalTo(self.btnLike.mas_right).offset(AutoDistance(2));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(40), AutoDistance(17)));
    }];
    
    [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labType);
        make.left.equalTo(self.labLike.mas_right).offset(AutoDistance(8));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(14), AutoDistance(14)));
    }];
    
    [self.labComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnLike);
        make.left.equalTo(self.btnComment.mas_right).offset(AutoDistance(2));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(30), AutoDistance(17)));
    }];
    
    [self.ivBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivTop.mas_bottom).offset(AutoDistance(24));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(40));
    }];
    
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivBottom).offset(AutoDistance(15));
        make.centerY.equalTo(self.ivBottom);
    }];
    
    [self.btnRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(5));
        make.centerY.equalTo(self.ivBottom);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(55), AutoDistance(20)));
    }];
    
    [self.btnRanking jk_setImagePosition:LXMImagePositionRight spacing:0];
    
    [self.btnLike addTarget:self action:@selector(clickLike) forControlEvents:UIControlEventTouchUpInside];
}

/// 点赞
- (void)clickLike{
    if (self.btnLike.selected) return;
    if (self.likeBlock) {
        self.likeBlock();
    }
}

- (void)setModel:(HUZFriendListDataListModel *)model{
    [self.ivHeader sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labName.text = model.username;
    self.labTime.text = [HUZInsureValidate distanceTimeWithBeforeTime:[model.createTime doubleValue]];
    self.labContent.text = model.content;
    /// 1高考政策,2填报问题,3生涯规划,4大学专业,5志愿讲堂,6产品专区
    NSString *type = @"";
    if ([model.typeId isEqualToString:@"1"]) {
        type = @"高考政策";
    }else if ([model.typeId isEqualToString:@"2"]){
        type = @"填报问题";
    }else if ([model.typeId isEqualToString:@"3"]){
        type = @"生涯规划";
    }else if ([model.typeId isEqualToString:@"4"]){
        type = @"大学专业";
    }else if ([model.typeId isEqualToString:@"5"]){
        type = @"志愿讲堂";
    }else{
        type = @"产品专区";
    }
    self.labType.text = [NSString stringWithFormat:@"#%@",type];
    self.btnLike.selected = [model.isClick isEqualToString:@"1"] ? YES : NO;
    self.labLike.text = DRStringIsEmpty(model.likeNum) ? @"0" : model.likeNum;
    self.labComment.text = DRStringIsEmpty(model.commentNum) ? @"0" : model.commentNum;
    self.labNum.text = [NSString stringWithFormat:@"评论(%@)",DRStringIsEmpty(model.commentNum) ? @"0" : model.commentNum];
    [self.labNum addAttributestring:self.labNum.text font:FontS(FONT_17) color:ColorS(COLOR_414141) range:NSMakeRange(0, 2)];

}

- (CGFloat)cacluateHeightWithModel:(HUZFriendListDataListModel *)model{
    CGFloat H = [model.content jk_heightWithFont:FontS(FONT_17) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    [self.ivTop mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.right.equalTo(self);
        make.height.mas_offset(AutoDistance(105) + H);
    }];
    [self.ivBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivTop.mas_bottom).offset(AutoDistance(24));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(40));
    }];
    return H + AutoDistance(188);
}

@end
