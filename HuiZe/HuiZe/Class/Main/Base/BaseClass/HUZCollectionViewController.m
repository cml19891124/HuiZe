//
//  HUZCollectionViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCollectionViewController.h"

@interface HUZCollectionViewController ()

@end

@implementation HUZCollectionViewController

- (void)dealloc{
    // set nil
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Override
- (void)configComponents{
    [super configComponents];
    
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.cellSize = CGSizeMake(50, 50);
    self.edg = UIEdgeInsetsMake(10, 10, 10, 10);
    [self setScrollDirection];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = self.scrollDirection;
    //UICollectionView  的实例化
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    //UICollectionViewDelegateFlowLayout  代理
    collectionView.delegate = self;
    //UICollectionViewDataSource   数据源协议
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    self.collectionView = collectionView;

}

- (void)setScrollDirection{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

- (void)configureCell:(UICollectionViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
           withObject:(id)object{}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
       dequeueReusableCellWithIdentifier:(NSString *)identifier
                            forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
//设置段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //是否有分段
    if (self.shouldMultiSections) return self.dataSource?self.dataSource.count : 1;
    return 1;
}
//设置单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    if (self.shouldMultiSections) return [self.dataSource[section] count];
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [self collectionView:collectionView
                     dequeueReusableCellWithIdentifier:@"UICollectionViewCell"
                                          forIndexPath:indexPath];
    // fetch object
    id object = nil;
    if (self.shouldMultiSections) object = self.dataSource[indexPath.section][indexPath.row];
    if (!self.shouldMultiSections) object = self.dataSource[indexPath.row];
    
    /// bind model
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellSize;
}
//设置边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    return self.edg;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.minimumInteritemSpacing;
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
@end
