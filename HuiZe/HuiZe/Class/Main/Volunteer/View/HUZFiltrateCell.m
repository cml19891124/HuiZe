//
//  HUZFiltrateCell.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFiltrateCell.h"

@implementation HUZFiltrateCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZFiltrateCell";
    HUZFiltrateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)initView{
    
    ViewBorderRadius(self, AutoDistance(4), 1, ColorS(COLOR_BG_E9E9E9));
    
    self.titleLab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

-(void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.titleLab.text = dic[@"name"];
    if([dic[@"isSelected"] integerValue]==1){
        self.contentView.backgroundColor = [UIColor colorWithRed:46/255. green:134/255. blue:255/255. alpha:0.6];
        self.titleLab.textColor = [UIColor whiteColor];
    }else{
        self.contentView.backgroundColor = COLOR_BG_WHITE;
        self.titleLab.textColor = ColorS(COLOR_989898);
    }
}
@end
