//
//  HUZDressUniView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZDressUniView.h"
#import "HUZFiltrateReusableView.h"
#import "HUZFiltrateCell.h"
#import "HUZProvinceModel.h"

@interface HUZDressUniView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *sectionArr;
    int _category; // 批次 -1不限  其他从0开始
    int _address;  // 地区 -1不限  其他从0开始
    int _keyOne; //著名大学 -1不限  其他从0开始
    int _schoolPrivate;  //大学性质 -1不限 其他从0开始
    int _schoolType; //大学类型 -1不限 其他从0开始
}

@property(nonatomic,strong)UICollectionView *collectView;
@property (nonatomic,strong) UIView *rightfullView;

@end

@implementation HUZDressUniView

- (void)show{
    UIView *rightfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    rightfullView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    self.rightfullView = rightfullView;
    [[UIApplication sharedApplication].keyWindow addSubview:rightfullView];
    UIView *leftfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(55), HUZSCREEN_HEIGHT)];
    leftfullView.backgroundColor = [UIColor clearColor];
    [rightfullView addSubview:leftfullView];
    [leftfullView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    [rightfullView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(50, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT);
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(HUZSCREEN_WIDTH, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        if (finished) {
            [self.rightfullView removeFromSuperview];
        }
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.dataProvince = [NSMutableArray new];
        [self makeUI];
    }
    return self;
}

-(void)loadData:(NSMutableArray *)dataProvince{
    self.dataProvince = dataProvince;
    _category = -1;
    _address = -1;
    _keyOne = -1;
    _schoolPrivate = -1;
    _schoolType = -1;
    
    self.dataArray = [NSMutableArray array];
    sectionArr =@[@"层次", @"地区", @"院校标签", @"院校性质",@"院校类型"];
    NSArray *row1 = @[@"不限", @"本科批", @"专科批"];
    NSMutableArray *row2 = dataProvince;
    NSArray *row3 = @[@"不限", @"985", @"211", @"双一流"];
    NSArray *row4 = @[@"不限", @"公办", @"民办"];
    NSMutableArray *row5 = HUZDataBaseManager.dataSchoolType.mutableCopy;
    
    if (self.type == 1) {
        sectionArr =@[@"层次",@"院校标签", @"院校性质",@"院校类型"];
        row2 = @[@"不限", @"985", @"211", @"双一流"].mutableCopy;
        row3 = @[@"不限", @"公办", @"民办"];
        row4 = HUZDataBaseManager.dataSchoolType.mutableCopy;
        for (int i = 0; i < sectionArr.count; i ++) {
            NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
            mudic[@"switch"] = @"0";
            mudic[@"name"] = @"";
            NSMutableArray *arr  = [NSMutableArray array];
            switch (i) {
                case 0:
                    {
                        for(int i = 0;i<row1.count;i++){
                            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                            dic[@"name"]=row1[i];
                            dic[@"id"]=[NSString stringWithFormat:@"%d",i-1];
                            dic[@"showclose"]=@"0";
                            dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                            [arr addObject:dic];
                        }
                    }
                    break;
                case 1:
                    {
                        for(int i = 0;i<row2.count;i++){
                            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                            dic[@"name"]=row2[i];
                            dic[@"id"]=[NSString stringWithFormat:@"%d",i -1];
                            dic[@"showclose"]=@"0";
                            dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                            [arr addObject:dic];
                        }
                    }
                    break;
                case 2:
                    {
                        for(int i = 0;i<row3.count;i++){
                            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                            dic[@"name"]=row3[i];
                            dic[@"id"]=[NSString stringWithFormat:@"%d",i -1];
                            dic[@"showclose"]=@"0";
                            dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                            [arr addObject:dic];
                        }
                    }
                    break;
                case 3:
                    {
                        for(int i = 0;i<row4.count;i++){
                            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                            dic[@"name"]= i == 0 ? @"不限" :row4[i];
                            dic[@"id"]=[NSString stringWithFormat:@"%d",i-1];
                            dic[@"showclose"]=@"0";
                            dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                            [arr addObject:dic];
                        }
                    }
                    break;
                    
                default:
                    break;
            }
            mudic[@"data"]= arr;
            //如果个数大于6个才显示右侧箭头
            if(arr.count>6){
                mudic[@"showRight"] = @"1";
            }else{
                mudic[@"showRight"] = @"0";
            }
            
            [self.dataArray addObject:mudic];
        }
    }else{
        for (int i = 0; i < sectionArr.count; i ++) {
            NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
            mudic[@"switch"] = @"0";
            mudic[@"name"] = @"";
            NSMutableArray *arr  = [NSMutableArray array];
            switch (i) {
                case 0:
                {
                    for(int i = 0;i<row1.count;i++){
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        dic[@"name"]=row1[i];
                        dic[@"id"]=[NSString stringWithFormat:@"%d",i-1];
                        dic[@"showclose"]=@"0";
                        dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                        [arr addObject:dic];
                    }
                }
                    break;
                case 1:
                {
                    for(int i = 0;i<row2.count;i++){
                        HUZProvince *province = row2[i];
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        dic[@"name"]=province.title;
                        dic[@"id"]=province.Id;
                        dic[@"showclose"]=@"0";
                        dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                        [arr addObject:dic];
                    }
                }
                    break;
                case 2:
                {
                    for(int i = 0;i<row3.count;i++){
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        dic[@"name"]=row3[i];
                        dic[@"id"]=[NSString stringWithFormat:@"%d",i -1];
                        dic[@"showclose"]=@"0";
                        dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                        [arr addObject:dic];
                    }
                }
                    break;
                case 3:
                {
                    for(int i = 0;i<row4.count;i++){
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        dic[@"name"]=row4[i];
                        dic[@"id"]=[NSString stringWithFormat:@"%d",i -1];
                        dic[@"showclose"]=@"0";
                        dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                        [arr addObject:dic];
                    }
                }
                    break;
                case 4:
                {
                    for(int i = 0;i<row5.count;i++){
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        dic[@"name"]= i == 0 ? @"不限" :row5[i];
                        dic[@"id"]=[NSString stringWithFormat:@"%d",i-1];
                        dic[@"showclose"]=@"0";
                        dic[@"isSelected"]= i == 0 ? @"1" : @"0";
                        [arr addObject:dic];
                    }
                }
                    break;
                default:
                    break;
            }
            
            mudic[@"data"]= arr;
            //如果个数大于6个才显示右侧箭头
            if(arr.count>6){
                mudic[@"showRight"] = @"1";
            }else{
                mudic[@"showRight"] = @"0";
            }
            
            [self.dataArray addObject:mudic];
            
        }
    }
    
    [self.collectView reloadData];
}
-(void)makeUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    float width = (HUZSCREEN_WIDTH-60-60)/3;
    layout.itemSize =  CGSizeMake(width, AutoDistance(31));
    layout.minimumLineSpacing = 18;
    layout.minimumInteritemSpacing=10;
    layout.sectionInset = UIEdgeInsetsMake(20, 24, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, AutoDistance(20), self.frame.size.width, self.frame.size.height-AutoDistance(28)-AutoDistance(49)) collectionViewLayout:layout];
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
    [self loadData:self.dataProvince];
    [self.collectView reloadData];
}
-(void)pressSure{
    [self dismiss];
    if(self.sendBlock){
        self.sendBlock(_category, _address, _keyOne, _schoolPrivate, _schoolType);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(HUZSCREEN_WIDTH-55, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HUZFiltrateReusableView *headReusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FiltrateReusableView" forIndexPath:indexPath];
    headReusableView.index = indexPath.section;
    headReusableView.titleLab.text = sectionArr[indexPath.section];
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
    
    if([sedic[@"switch"] integerValue]==0&&arr.count>6){
        return 6;
    }
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
    
    /// 设置非选中状态
    for (NSMutableDictionary *adic in arr) {
        adic[@"isSelected"] = @"0";
    }
    
    /// 设置点击的item为选中状态
    if([mudic[@"isSelected"] integerValue]==1){
        mudic[@"isSelected"] = @"0";
    }
    else{
        mudic[@"isSelected"] = @"1";
    }
    
    if (indexPath.section == 0) {
        _category = [mudic[@"id"] intValue];
    }else if (indexPath.section == 1){
        _address = [mudic[@"id"] intValue];
    }else if (indexPath.section == 2){
        _keyOne = [mudic[@"id"] intValue];
    }else if (indexPath.section == 3){
        _schoolPrivate = [mudic[@"id"] intValue];
    }else{
        _schoolType = [mudic[@"id"] intValue];
    }
    
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:musecDic];
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.collectView reloadSections:set];
    
}
@end
