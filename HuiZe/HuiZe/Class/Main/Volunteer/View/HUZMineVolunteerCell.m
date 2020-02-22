//
//  HUZMineVolunteerCell.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMineVolunteerCell.h"
#import "HUZVolunteerModel.h"

@implementation HUZMineVolunteerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZMineVolunteerCell";
    HUZMineVolunteerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.contentView.backgroundColor = ColorS(COLOR_BG_163A6B);
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH - 2 * AutoDistance(15), AutoDistance(90))];
    bgView.backgroundColor = ColorS(COLOR_BG_284976);
    ViewRadius(bgView, 8);
    [self.contentView addSubview:bgView];
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_circle_good")];
    
    self.labTitle = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_17)];
    self.labTitle.text = @"我的志愿表01";
    
    self.labSubj = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_12)];
    self.labSubj.text = @"非常好";
    
    self.labType = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_12)];
    self.labType.text = @"#手动填报";
    
    self.labDate = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_12)];
    self.labDate.text = @"19/01/01";
    
    
    [bgView addSubview:self.ivLogo];
    [bgView addSubview:self.labTitle];
    [bgView addSubview:self.labSubj];
    [bgView addSubview:self.labType];
    [bgView addSubview:self.labDate];
    
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(18));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(21));
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
    }];
    
    [self.labSubj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labTitle);
        make.right.mas_offset(-AutoDistance(18));
        make.height.mas_offset(AutoDistance(17));
    }];
    
    [self.labType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(7));
        make.leading.equalTo(self.labTitle);
    }];
    
    [self.labDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labType);
        make.left.equalTo(self.labType.mas_right).offset(AutoDistance(18));
    }];
}

- (void)setModel:(HUZVolunteer *)model {
    _model = model;
    self.labTitle.text = model.volunteerName;

    if (model.volunteerType.integerValue == 0) {
        self.labType.text = @"#智能填报";
    }else if (model.volunteerType.integerValue == 1){
        self.labType.text = @"#院校优先填报";
    }else if (model.volunteerType.integerValue == 2){
        self.labType.text = @"#专业优先填报";
    }else if (model.volunteerType.integerValue == 3){
        self.labType.text = @"#手动填报";
    }
    
    self.labDate.text = model.createTime;//[HUZTools timestampSwitchTime:[NSString stringWithFormat:@"%ld",model.createTime] andFormatter:@"YY/MM/dd"];

    NSString *labSubjStr = @"";
    if (model.reasonable.integerValue == 0) {
        labSubjStr = @"不合理";
    }else if (model.reasonable.integerValue == 1) {
        labSubjStr = @"良好";
    }else if (model.reasonable.integerValue == 2){
        labSubjStr = @"非常好";
    }
    self.labSubj.hidden = YES;
    self.labSubj.text = labSubjStr;

}

@end
