//
//  HUZHomeRecommendCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHomeRecommendCell.h"
#import "HUZRecommendCell.h"
#import "HUZMajorRecommendCell.h"
#import "HUZUniInfoViewController.h"
#import "HUZMajorInfoViewController.h"
#import "HUZRecommendListViewController.h"
#import "HUZRecommendUniModel.h"
#import "HUZMajorRecommendNewCell.h"
#import "HUZRecommendMajorModel.h"
@interface HUZHomeRecommendCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UIButton *btnMore;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HUZHomeRecommendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZHomeRecommendCell";
    HUZHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return 240;
}

- (void)initView{
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    self.labContent.text = @"推荐的院校";
    
    self.btnMore = [[UIButton alloc] initWithTitle:@"查看更多" textColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_14)];
    [self.btnMore setImage:ImageNamed(@"ic_more_arrow") forState:UIControlStateNormal];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,HUZSCREEN_WIDTH,190) collectionViewLayout:flow];
    [self.contentView addSubview:self.collectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView dz_registerCell:[HUZRecommendCell class]];
    [self.collectionView dz_registerCell:[HUZMajorRecommendCell class]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HUZMajorRecommendNewCell" bundle:nil] forCellWithReuseIdentifier:@"HUZMajorRecommendNewCell"];
    self.collectionView.backgroundColor= COLOR_BG_WHITE;
    
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.btnMore];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.emptyDataView];
    self.emptyDataView.hidden = YES;
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(12);
        make.left.mas_offset(15);
    }];
    
    [self.btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(14);
        make.right.mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(80), 20));
    }];
    

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent.mas_bottom).offset(12);
        make.left.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH, 160));
    }];
    
    [self.emptyDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent.mas_bottom).offset(12);
        make.left.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH, 160));
    }];
    
    
    [self.btnMore LeftTitleRightImageWithSpace:8];
    [self.btnMore addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
}

/// 推荐列表
- (void)clickMore{
    HUZRecommendListViewController *recommendListVC = [HUZRecommendListViewController new];
    recommendListVC.type = _type == HUZHomeRecommendMajor ? 2 : 1;
    [[UIViewController currentViewController].navigationController pushViewController:recommendListVC animated:YES];
}

- (void)setType:(HUZHomeRecommendType)type{
    _type = type;
    self.labContent.text = type == HUZHomeRecommendUni ? @"推荐的院校" : @"推荐的专业";
}

- (void)setDatasUni:(NSArray *)datasUni{
    _datasUni = datasUni;
    if (DRArrayIsEmpty(_datasUni)) {
        self.emptyDataView.hidden = NO;
        self.collectionView.hidden = YES;
        self.emptyDataView.labEmpty.text = @"没有匹配到与您成绩相符的院校~\n继续加油吧~";
    }else{
        self.emptyDataView.hidden = YES;
        self.collectionView.hidden = NO;
    }
    [self.collectionView reloadData];
}

- (void)setDatasMajor:(NSArray *)datasMajor{
    _datasMajor = datasMajor;
    if (DRArrayIsEmpty(_datasMajor)) {
        self.emptyDataView.hidden = NO;
        self.collectionView.hidden = YES;
        self.emptyDataView.labEmpty.text = @"没有匹配到与您成绩相符的专业~\n继续加油吧~";
    }else{
        self.emptyDataView.hidden = YES;
        self.collectionView.hidden = NO;
    }
    [self.collectionView reloadData];
}

#pragma mark ————— collection代理方法 —————
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_type == HUZHomeRecommendUni) {
        return _datasUni.count;
    }
    return _datasMajor.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == HUZHomeRecommendUni) {
        HUZRecommendCell* cell = [HUZRecommendCell cellWithCollectionView:collectionView forIndexPath:indexPath];
        [cell reloadData:_datasUni[indexPath.row] indexPath:indexPath];
        return cell;
    }else{
        
        HUZRecommendMajorDataModel *majorModel = nil;
        if (indexPath.item < _datasMajor.count) {
            majorModel = _datasMajor[indexPath.item];
        }
        
        HUZMajorRecommendNewCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HUZMajorRecommendNewCell" forIndexPath:indexPath];
        newCell.schoolNameLb.text = majorModel.schoolNameTem;
        newCell.contentLb.text = majorModel.zhuanyeNameTem;
        newCell.yearAndNumLb.text = [NSString stringWithFormat:@"%@录取最低分%@",majorModel.year,majorModel.minScore];
        return newCell;
        
        HUZMajorRecommendCell *cell = [HUZMajorRecommendCell cellWithCollectionView:@"HUZMajorRecommendCell" forIndexPath:indexPath];
        [cell reloadData:_datasMajor[indexPath.row]];
        return cell;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;//行每个item的间隔
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;//列每个item的间隔
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(121, 148);
}
//设置整体内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);//分别为上、左、下、右
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == HUZHomeRecommendUni) {
        HUZUniInfoViewController *uniInfoVC = [HUZUniInfoViewController new];
        HUZRecommendUniDataModel *model = self.datasUni[indexPath.row];
        uniInfoVC.schoolId = model.schoolId;
        [[UIViewController currentViewController].navigationController pushViewController:uniInfoVC animated:YES];
    }else{
        HUZMajorInfoViewController *majorInfoVC = [HUZMajorInfoViewController new];
        HUZRecommendMajorDataModel *model = self.datasMajor[indexPath.row];
        majorInfoVC.majorId = model.majorAllId;
        [[UIViewController currentViewController].navigationController pushViewController:majorInfoVC animated:YES];
    }
    
}



@end
