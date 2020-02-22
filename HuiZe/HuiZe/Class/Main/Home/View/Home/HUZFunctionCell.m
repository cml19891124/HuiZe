//
//  HUZFunctionCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZFunctionCell.h"

@implementation HUZFunctionCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZFunctionCell";
    HUZFunctionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}


- (void)initView{
    self.ivFunction = [UIImageView new];
    self.labFunction = [[UILabel alloc] initWithTextColor:ColorS(COLOR_525252) autoTextFont:FontS(FONT_12)];
    
    [self.contentView addSubview:self.ivFunction];
    [self.contentView addSubview:self.labFunction];
    
    [self.ivFunction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    
    [self.labFunction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivFunction.mas_bottom).offset(4);
        make.centerX.equalTo(self.contentView);
    }];
    
}

@end
