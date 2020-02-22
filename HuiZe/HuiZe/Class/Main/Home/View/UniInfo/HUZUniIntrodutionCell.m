//
//  HUZUniIntrodutionCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniIntrodutionCell.h"

@implementation HUZUniIntrodutionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniIntrodutionCell";
    HUZUniIntrodutionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(HUZUniInfoGeneralizeDataModel *)entity isOpen:(BOOL)isOpen{
    if (isOpen) {
        CGFloat H = [entity.introduce jk_heightWithFont:FontS(FONT_12) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
        return H + AutoDistance(50);
    }else{
        return AutoDistance(110);
    }
}

- (void)initView{
    self.labIntrodution = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12) numberOfLines:4];
    self.labIntrodution.frame = CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(68));
    
    self.btnAll = [[UIButton alloc] initWithTitle:@"展开全部" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12)];
    [self.btnAll setImage:ImageNamed(@"ic_arrow_down") forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.labIntrodution];
    [self.contentView addSubview:self.btnAll];
    
    [self.labIntrodution mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-AutoDistance(20));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(80), AutoDistance(17)));
    }];
    
    [self.btnAll jk_setImagePosition:LXMImagePositionRight spacing:8];
    
}

- (void)setUniInfoModel:(HUZUniInfoGeneralizeDataModel *)uniInfoModel isOpen:(BOOL)isOpen{
    self.labIntrodution.text = uniInfoModel.introduce;
//    [self.labIntrodution changeSpacewithLineSpace:AutoDistance(2) WordSpace:0];
    if (isOpen) {
        self.labIntrodution.numberOfLines = 0;
    }else{
        self.labIntrodution.numberOfLines = 4;
    }

}

@end

