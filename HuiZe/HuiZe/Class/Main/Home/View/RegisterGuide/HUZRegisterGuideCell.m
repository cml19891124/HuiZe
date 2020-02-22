//
//  HUZRegisterGuideCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRegisterGuideCell.h"
#import "HUZRegisterGuideModel.h"
#import "HUZCommonSenseModel.h"

@interface HUZRegisterGuideCell ()

//@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@end

@implementation HUZRegisterGuideCell

- (void)initView{
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(10), AutoDistance(10)));
    }];
    self.labContent.numberOfLines = 0;
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_equalTo(self.ivArrow.mas_left).mas_equalTo(-5);
        make.top.mas_offset(AutoDistance(17));
//        make.size.mas_equalTo(CGSizeMake(AutoDistance(210), AutoDistance(24)));
        make.bottom.mas_equalTo(-17);
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath{
    if ([entity isKindOfClass:[HUZRegisterGuideDataModel class]]) {
        HUZRegisterGuideDataModel *model = (HUZRegisterGuideDataModel *)entity;
        self.labContent.text = [NSString stringWithFormat:@"%@",model.title];
    }
    else if ([entity isKindOfClass:[HUZCommonSenseDataListModel class]]){
        HUZCommonSenseDataListModel *model = (HUZCommonSenseDataListModel *)entity;
        self.labContent.text = [NSString stringWithFormat:@"%@",model.title];
    }
}

@end
