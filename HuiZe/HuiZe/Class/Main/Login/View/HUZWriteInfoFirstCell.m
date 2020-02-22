//
//  HUZWriteInfoFirstCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZWriteInfoFirstCell.h"

@implementation HUZWriteInfoFirstCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZWriteInfoFirstCell";
    HUZWriteInfoFirstCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)initView{
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17) textAlignment:NSTextAlignmentCenter];
    self.labContent.backgroundColor = COLOR_BG_WHITE;
    ViewBorderRadius(self.labContent, 4, 1, ColorS(COLOR_989898));
    [self.contentView addSubview:self.labContent];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)setSelect:(BOOL)select{
    self.labContent.backgroundColor = select ? ColorS(COLOR_BG_2E86FF) : COLOR_BG_WHITE;
    self.labContent.textColor = select ? ColorS(COLOR_ffffff) : ColorS(COLOR_989898);
    if (select) {
        ViewBorderRadius(self.labContent, 4, 1, [UIColor clearColor]);
    }else{
        ViewBorderRadius(self.labContent, 4, 1, ColorS(COLOR_989898));
    }
}

- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath character:(NSString *)character subject:(NSString *)subject mark:(NSString *)mark rank:(NSString *)rank{
    if (indexPath.section == 0) {
        self.labContent.text = entity;
        self.labContent.backgroundColor = [self.labContent.text isEqualToString:character] ? ColorS(COLOR_BG_2E86FF) : COLOR_BG_WHITE;
        self.labContent.textColor = [self.labContent.text isEqualToString:character] ? ColorS(COLOR_ffffff) : ColorS(COLOR_989898);
        [self borderColor:[self.labContent.text isEqualToString:character]];
    }
    
    else if (indexPath.section == 2){
        self.labContent.text = entity;
        self.labContent.backgroundColor = [self.labContent.text isEqualToString:subject] ? ColorS(COLOR_BG_2E86FF) : COLOR_BG_WHITE;
        self.labContent.textColor = [self.labContent.text isEqualToString:subject] ? ColorS(COLOR_ffffff) : ColorS(COLOR_989898);
        [self borderColor:[self.labContent.text isEqualToString:character]];
    }
    
    else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            self.labContent.text = DRStringIsNotEmpty(mark) ? [NSString stringWithFormat:@"%@分",mark] : entity;
            self.labContent.textColor = DRStringIsNotEmpty(mark) ? ColorS(COLOR_2E86FF) : ColorS(COLOR_989898);
        }else{
            self.labContent.text = DRStringIsNotEmpty(rank) ? rank : entity;
            self.labContent.textColor = DRStringIsNotEmpty(rank) ? ColorS(COLOR_2E86FF) : ColorS(COLOR_989898);
        }
        self.labContent.backgroundColor = COLOR_BG_WHITE;
        ViewBorderRadius(self.labContent, 4, 1, ColorS(COLOR_989898));
    }

}

- (void)borderColor:(BOOL)select{
    if (select) {
        ViewBorderRadius(self.labContent, 4, 1, [UIColor clearColor]);
    }else{
        ViewBorderRadius(self.labContent, 4, 1, ColorS(COLOR_989898));
    }
}

@end
