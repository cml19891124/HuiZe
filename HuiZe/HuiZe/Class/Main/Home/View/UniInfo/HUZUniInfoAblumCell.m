//
//  HUZUniInfoAblumCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoAblumCell.h"
#import "HUZUniInfoAblumPicCell.h"
#import "HUZUniInfoGeneralizeModel.h"
//#import "HUZUniInfoGeneralizeSchoolpicVosModel.h"
@implementation HUZUniInfoAblumCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniInfoAblumCell";
    HUZUniInfoAblumCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return AutoDistance(140);
}

- (void)initView{
    [self.contentView addSubview:self.collectionView];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,HUZSCREEN_WIDTH,AutoDistance(103)) collectionViewLayout:flow];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView dz_registerCell:[HUZUniInfoAblumPicCell class]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor= COLOR_BG_WHITE;
    }
    return _collectionView;
}

- (void)setDataUniPhoto:(NSArray *)dataUniPhoto{
    _dataUniPhoto = dataUniPhoto;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataUniPhoto.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return AutoDistance(18);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, AutoDistance(15), 0, AutoDistance(15));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(AutoDistance(103), AutoDistance(103));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HUZUniInfoAblumPicCell *cell = [HUZUniInfoAblumPicCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    HUZUniInfoGeneralizeSchoolpicVosModel *picModel = self.dataUniPhoto[indexPath.item];
//    [cell reloadData:_dataUniPhoto[indexPath.row]];
    [cell.ivPic sd_setImageWithURL:[NSURL URLWithString:picModel.schoolPic]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoAblumPicCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (HUZUniInfoGeneralizeSchoolpicVosModel *imageModel in self.dataUniPhoto) {
        [imageArr addObject:imageModel.schoolPic];
    }
    
    
    YQBaseImageBrowserVC *imageBrowser = [[YQBaseImageBrowserVC alloc] initImageArrUrl:imageArr currentIndex:indexPath.item sourceObject:cell.ivPic];
    imageBrowser.currentPage = indexPath.item;
    [imageBrowser show];
}
@end
