//
//  HUZUniInfoCommonCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoCommonCell.h"
#import "HUZSearchAllMajorModel.h"
#import "HUZMajorInfoModel.h"
@implementation HUZUniInfoCommonCell
-(void)setInfoModel:(HUZMajorInfoModel *)infoModel {
    _infoModel = infoModel;
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniInfoCommonCell";
    HUZUniInfoCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return AutoDistance(60);
}

- (void)initView{
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentRight];
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(29));
        make.width.mas_greaterThanOrEqualTo(45);
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(AutoDistance(15));
//        make.size.mas_equalTo(CGSizeMake(AutoDistance(130), AutoDistance(24)));
        make.height.mas_equalTo(AutoDistance(24));
        make.right.mas_equalTo(self.labDes.mas_left).mas_equalTo(-12);
    }];
    

    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(10), AutoDistance(10)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(HUZUniInfoGeneralizeDataModel *)entity indexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        HUZUniInfoGeneralizeDataModel *model = (HUZUniInfoGeneralizeDataModel *)entity;
        if (indexPath.row == 0) {
            self.labContent.text = @"校园官网";
            self.labDes.text = model.websiteUrl;
        }else{
            self.labContent.text = @"招生电话";
            self.labDes.text = model.recrPhone;
        }
    }else{
        HUZUniInfoGeneralizeMajorModel *model = (HUZUniInfoGeneralizeMajorModel *)entity;
        if (model.category.length > 0) {
            self.labContent.text = model.category;
        }else{
            self.labContent.text = model.majorName;
        }
        
        self.labDes.text = @"";
    }
}

- (void)reloadData:(HUZSearchAllMajorDataListModel *)entity{
    self.labContent.text = entity.category;
}

@end
