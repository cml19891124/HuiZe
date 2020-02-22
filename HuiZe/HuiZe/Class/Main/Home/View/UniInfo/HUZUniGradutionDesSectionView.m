//
//  HUZUniGradutionDesSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniGradutionDesSectionView.h"

@implementation HUZUniGradutionDesSectionView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:BoldFontS(FONT_15)];
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labDes1.text = @"";//每100个毕业生,
    
    self.labDes2 = [TTTAttributedLabel new];
    [self.labDes2 setTextColor:ColorS(COLOR_414141)];
    [self.labDes2 setFont:FontS(FONT_14)];
    
    [self addSubview:self.labTitle];
    [self addSubview:self.labDes1];
    [self addSubview:self.labDes2];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(15));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(24));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(24));
        make.left.equalTo(self.labDes1.mas_right);
    }];
}

- (void)setModel:(HUZIndustyLeaModel *)model{
    if (model.data.number.count == 2) {
        HUZIndustyLeaDataNumberModel *model1 = model.data.number[0];
        HUZIndustyLeaDataNumberModel *model2 = model.data.number[1];
        NSString *des = [NSString stringWithFormat:@"有%@个从事%@、%@个从事%@",model1.num,model1.industry_name,model2.num,model2.industry_name];
        self.labDes2.enabledTextCheckingTypes = NSTextCheckingTypePhoneNumber|NSTextCheckingTypeAddress|NSTextCheckingTypeLink;
        [self.labDes2 setText:des afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            //设置可点击文字的范围
            NSRange range1 = [[mutableAttributedString string] rangeOfString:model1.num options:NSCaseInsensitiveSearch];
            NSRange range2 = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@",model1.industry_name] options:NSCaseInsensitiveSearch];
            NSRange range3 = [[mutableAttributedString string] rangeOfString:model2.num options:NSCaseInsensitiveSearch];
            
            NSRange range4 = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@",model2.industry_name] options:NSCaseInsensitiveSearch];
            
            UIColor *color = ColorS(COLOR_2E86FF);
            if (color) {
                //设置可点击文本的颜色
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range1];
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range2];
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range3];
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range4];
            }
            return mutableAttributedString;
        }];
    }
}

@end
