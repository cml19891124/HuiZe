//
//  HUZMajorFiltrateView.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMajorFiltrateView.h"
#import "HUZFiltrateReusableView.h"
#import "HUZFiltrateCell.h"

@interface HUZMajorFiltrateView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)NSArray *sectionArr;

@end

@implementation HUZMajorFiltrateView


- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self makeUI];
    }
    return self;
}

-(void)loadDataWithSectionArr:(NSArray*)sectionArr array:(NSArray*)array {
    self.dataArray = [NSMutableArray array];

    self.sectionArr = sectionArr;
    
    for (int i = 0; i < sectionArr.count; i ++) {
        NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
        mudic[@"switch"] = @"0";
        mudic[@"name"] = @"";
        NSMutableArray *arr  = [NSMutableArray array];
        for(int i = 0;i<array.count;i++){
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];

            HUZMajorDataListModel *model = array[i];
            
            dic[@"name"]= model.category;
            dic[@"id"]= model.majorAllId;//[NSString stringWithFormat:@"%d",i];
            dic[@"isSelected"]= model.isSelected;//@"0";
            [arr addObject:dic];

        }
        
        mudic[@"data"]= arr;
      
        [self.dataArray addObject:mudic];
        
    }
    
    self.scrArray = [self.dataArray mutableCopy];
    
}
-(void)makeUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    float width = (HUZSCREEN_WIDTH-60-60)/3;
    layout.itemSize =  CGSizeMake(width, AutoDistance(31));
    layout.minimumLineSpacing = 18;
    layout.minimumInteritemSpacing=10;
    layout.sectionInset = UIEdgeInsetsMake(20, 24, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, AutoDistance(32), self.frame.size.width, self.frame.size.height-AutoDistance(32)-AutoDistance(49)) collectionViewLayout:layout];
    self.collectView.delegate=self;
    self.collectView.dataSource=self;
    [self addSubview:self.collectView];
    self.collectView.backgroundColor=[UIColor whiteColor];
    [self.collectView registerClass:[HUZFiltrateReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FiltrateReusableView"];
    [self.collectView dz_registerCell:[HUZFiltrateCell class]];
    
    [self addSubview:self.footerView];
    
}
-(UIView *)footerView{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-49, self.self.frame.size.width, 49)];
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.self.frame.size.width, 1)];
    line.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [bgView addSubview:line];
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bgView.self.frame.size.width/2, 49)];
    [leftBtn setTitle:@"重置" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(pressReset) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
    [bgView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(bgView.self.frame.size.width/2, 0, bgView.self.frame.size.width/2, 49)];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(pressSure) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
    rightBtn.titleLabel.textColor = COLOR_BG_WHITE;
    rightBtn.backgroundColor=ColorS(COLOR_2E86FF);
    [bgView addSubview:rightBtn];
    
    return bgView;
}

-(void)pressReset{
    
    NSMutableDictionary *arrdic = self.dataArray[0];
    NSArray *arr = arrdic[@"data"];
    
    NSMutableDictionary *unlimitedDict = arr[0];
    
    if ([[NSString stringWithFormat:@"%@",unlimitedDict[@"isSelected"]] isEqualToString:@"1"]) {
        return;
    }
    
    
    for (int i = 0; i < arr.count; i++) {
        NSMutableDictionary *dic = arr[i];
        if ([dic[@"isSelected"] isEqualToString:@"1"]) {
            dic[@"isSelected"] = @"0";
        }
    }
    unlimitedDict[@"isSelected"] = @"1";
    [self.collectView reloadData];
}
-(void)pressSure{
    NSMutableDictionary *arrdic = self.dataArray[0];
    NSArray *arr = arrdic[@"data"];
    self.selectedTitleArray = [NSMutableArray array];
    self.selectedIdArray = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSMutableDictionary *dic = arr[i];
        if ([dic[@"isSelected"] isEqualToString:@"1"]) {
            [self.selectedIdArray addObject:dic[@"id"]];
            [self.selectedTitleArray addObject:dic[@"name"]];
        }
    }

    if(self.sendBlock){
        self.sendBlock([self.selectedTitleArray componentsJoinedByString:@","],[self.selectedIdArray componentsJoinedByString:@","]);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(HUZSCREEN_WIDTH-55, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HUZFiltrateReusableView *headReusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FiltrateReusableView" forIndexPath:indexPath];
    headReusableView.index = indexPath.section;
    headReusableView.titleLab.text = self.sectionArr[indexPath.section];
    headReusableView.dic = self.dataArray[indexPath.section];
    
    headReusableView.filtrateReusableViewBlock = ^(BOOL state,NSInteger index){
        NSDictionary *dic = self.dataArray[index];
        NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:dic];
        NSString *stateStr = @"0";
        if(state){
            stateStr = @"1";
        }
        mudic[@"switch"]=stateStr;
        [self.dataArray replaceObjectAtIndex:index withObject:mudic];
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
        [self.collectView reloadSections:set];
        
    };
    return headReusableView;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *sedic = self.dataArray[section];
    NSArray *arr = sedic[@"data"];
    return arr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HUZFiltrateCell *cell =  [HUZFiltrateCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    NSDictionary *sedic = self.dataArray[indexPath.section];
    NSArray *arr  = sedic[@"data"];
    NSDictionary *item = arr[indexPath.row];
    
    cell.dic = item;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *musecDic = self.dataArray[indexPath.section];
    NSMutableArray *arr  = musecDic[@"data"];
    NSMutableDictionary *mudic = arr[indexPath.row];
    
//    if([mudic[@"isSelected"] integerValue]==1){
//        mudic[@"isSelected"] = @"0";
//    }
//    else{
//        mudic[@"isSelected"] = @"1";
//    }
    
    NSMutableDictionary *unlimitedDict = arr[0];
    if (indexPath.row == 0) {
        [self pressReset];
    }
    
    if([mudic[@"isSelected"] integerValue]==1 && indexPath.row != 0){
        mudic[@"isSelected"] = @"0";
    }
    else{
        unlimitedDict[@"isSelected"] = @"0";
        mudic[@"isSelected"] = @"1";
    }
    
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:musecDic];
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
//    [self.collectView reloadSections:set];
    [self.collectView reloadData];
}

@end
