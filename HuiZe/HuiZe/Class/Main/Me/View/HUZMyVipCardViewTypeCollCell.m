//
//  HUZMyVipCardViewTypeCollCell.m
//  HuiZe
//
//  Created by tbb on 2019/9/3.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMyVipCardViewTypeCollCell.h"
#import "HUZMyVipCardViewTypeCollCellCollViewCell.h"
#import "HUZMyVipCardPriceModel.h"
#define kITEMSIZEW ((HUZSCREEN_WIDTH - 45) / 2.0)
#define kITEMSIZEH ((HUZSCREEN_WIDTH - 45) / 2.0) * (120 / 165.0)

@interface HUZMyVipCardViewTypeCollCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collView;
@property (nonatomic, strong) UILabel * titleLb;
@end

@implementation HUZMyVipCardViewTypeCollCell
-(void)setDataArr:(NSArray *)dataArr {
    _dataArr = [dataArr copy];
    [self.collView reloadData];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(21);
    }];
    [self.contentView addSubview:self.collView];
    [self.collView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}
#pragma mark -- lazy
-(UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = ColorS(COLOR_414141);
        _titleLb.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
        _titleLb.text = @"升级专区";
    }
    return _titleLb;
}
-(UICollectionView *)collView {
    if (!_collView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.itemSize = CGSizeMake(kITEMSIZEW, kITEMSIZEH);
        _collView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collView.backgroundColor = UIColor.whiteColor;
        _collView.dataSource = self;
        _collView.delegate = self;
        _collView.bounces = NO;
        [_collView registerNib:[UINib nibWithNibName:@"HUZMyVipCardViewTypeCollCellCollViewCell" bundle:nil] forCellWithReuseIdentifier:@"HUZMyVipCardViewTypeCollCellCollViewCell"];
    }
    return _collView;
}
#pragma mark -- lazy end

#pragma mark -- lazy
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HUZMyVipCardViewTypeCollCellCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HUZMyVipCardViewTypeCollCellCollViewCell" forIndexPath:indexPath];
    HUZMyVipCardPriceModel *model = self.dataArr[indexPath.item];
    if (indexPath.item < self.dataArr.count) {
        cell.priceModel = model;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataArr enumerateObjectsUsingBlock:^(HUZMyVipCardPriceModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.item) {
            if (obj.isSelection) {
                return;
            }
            obj.selection = YES;
        }else{
            obj.selection = NO;
        }
    }];
    [self.collView reloadData];
    if ([self.delegate respondsToSelector:@selector(selectPriceIndex:)]) {
        [self.delegate selectPriceIndex:indexPath.item];
    }
}

#pragma mark -- lazy end
@end
