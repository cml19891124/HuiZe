//
//  HUZUniFiltrateView.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniFiltrateView.h"
#import "HUZFiltrateReusableView.h"
#import "HUZFiltrateCell.h"

#import "HUZLoginService.h"

@interface HUZUniFiltrateView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *sectionArr;
}
@property(nonatomic,strong)UICollectionView *collectView;
@end

@implementation HUZUniFiltrateView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        self.provinceArray = [NSMutableArray array];
        [self loadProvinceData];
        
    }
    return self;
}

#pragma mark - 加载省份数据
- (void)loadProvinceData
{
//    [self displayOverFlowActivityView];
    
    [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
//        [self removeOverFlowActivityView];
        
        [self.provinceArray addObjectsFromArray:object.data];
        [self.collectView reloadData];
        [self loadData];
        [self makeUI];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
//        [self removeOverFlowActivityView];
//        [self presentErrorSheet:errorStr];
    }];
}

-(void)loadData{
    self.dataArray = [NSMutableArray array];
    sectionArr =@[@"批次", @"地区", @"著名大学", @"大学性质",@"大学类型"];
    NSArray *row1 = @[@"不限", @"本科批", @"专科批"];
//    NSArray *row2 = @[@"不限", @"江西省", @"广东省", @"甘肃省", @"山东省", @"福建省", @"广东省", @"甘肃省", @"山东省", @"福建省"];
    
    NSArray *row3 = @[@"不限", @"985", @"211", @"双一流"];
    NSArray *row4 = @[@"不限", @"公办", @"民办"];
    NSArray *row5 = @[@"综合",@"工科",@"师范",@"农业",@"医药",@"军事",@"林业",@"语言",@"财经",@"体育",@"艺术",@"政法",@"民族"];
    
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
                        dic[@"id"]=[NSString stringWithFormat:@"%d",i];
                        dic[@"showclose"]=@"0";
                        dic[@"isSelected"]=@"0";
                        [arr addObject:dic];
                    }
                }
                break;
                case 1:
            {
                for(int i = 0;i<self.provinceArray.count;i++){
                    HUZProvince *model = self.provinceArray[i];

                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    dic[@"name"]= model.title;
                    dic[@"id"]=[NSString stringWithFormat:@"%@",model.Id];
                    dic[@"showclose"]=@"0";
                    dic[@"isSelected"]=@"0";
                    [arr addObject:dic];
                }
            }
                break;
                case 2:
            {
                for(int i = 0;i<row3.count;i++){
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    dic[@"name"]=row3[i];
                    dic[@"id"]=[NSString stringWithFormat:@"%ld",i + self.provinceArray.count];
                    dic[@"showclose"]=@"0";
                    dic[@"isSelected"]=@"0";
                    [arr addObject:dic];
                }
            }
                break;
                case 3:
            {
                for(int i = 0;i<row4.count;i++){
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    dic[@"name"]=row4[i];
                    dic[@"id"]=[NSString stringWithFormat:@"%ld",i + row3.count];
                    dic[@"showclose"]=@"0";
                    dic[@"isSelected"]=@"0";
                    [arr addObject:dic];
                }
            }
                break;
                case 4:
            {
                for(int i = 0;i<row5.count;i++){
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    dic[@"name"]=row5[i];
                    dic[@"id"]=[NSString stringWithFormat:@"%ld",i + row4.count];
                    dic[@"showclose"]=@"0";
                    dic[@"isSelected"]=@"0";
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
    
    [self.dataArray enumerateObjectsUsingBlock:^(NSMutableDictionary *musecDic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *arr  = musecDic[@"data"];
        [arr enumerateObjectsUsingBlock:^(NSMutableDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj[@"isSelected"] = @"0";
        }];
        [self.dataArray replaceObjectAtIndex:idx withObject:musecDic];
    }];
    
    self.category = @"-1";
    self.address = @"";
    self.keyOne = @"-1";
    self.schoolPrivate = @"-1";
    self.schoolType = @"-1";
    [self.collectView reloadData];
}
-(void)pressSure{
    if(self.sendBlock){
        self.sendBlock(self.category,self.address,self.keyOne,self.schoolPrivate,self.schoolType,self.score);
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
    
    [arr enumerateObjectsUsingBlock:^(NSMutableDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (indexPath.row == idx) {
            obj[@"isSelected"] = @"1";
        }else{
            obj[@"isSelected"] = @"0";
        }
    }];
    
//    if([mudic[@"isSelected"] integerValue]==1){
//        mudic[@"isSelected"] = @"0";
//    }
//    else{
//        mudic[@"isSelected"] = @"1";
//    }
    
    
    
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:musecDic];

    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
    switch (indexPath.section) {
        case 0:
            [self selectCategory:indexPath];
            break;
        case 1:
            [self selectAddress:indexPath];
            break;
        case 2:
            [self selectKeyone:indexPath];
            break;
        case 3:
            [self selectSchoolPrivate:indexPath];
            break;
        case 4:
            [self selectSchoolType:indexPath];
            break;
            
        default:
            break;
    }
    [self.collectView reloadSections:set];
    
}

- (void)selectCategory:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//不限
            self.category = @"-1";
        }else if (indexPath.row == 1) {//本科批
            self.category = @"0";
        }else if (indexPath.row == 2) {//专科批
            self.category = @"1";
        }
    }
}

- (void)selectAddress:(NSIndexPath *)indexPath
{
    HUZProvince *model = self.provinceArray[indexPath.row];
    if (indexPath.section == 1) {

        self.address = model.Id;

    }
}

- (void)selectKeyone:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {//不限
            self.keyOne = @"-1";
        }else if (indexPath.row == 1) {//985
            self.keyOne = @"0";
        }else if (indexPath.row == 2) {//211
            self.keyOne = @"1";
        }else if (indexPath.row == 3) {//双一流
            self.keyOne = @"2";
        }
    }
}

- (void)selectSchoolPrivate:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {//不限
            self.schoolPrivate = @"-1";
        }else if (indexPath.row == 1) {//公办
            self.schoolPrivate = @"0";
        }else if (indexPath.row == 2) {//民办
            self.schoolPrivate = @"1";
        }
    }
}

- (void)selectSchoolType:(NSIndexPath *)indexPath
{
    //0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {//不限
            self.schoolType = @"-1";
        }else{//工科
            self.schoolType = [NSString stringWithFormat:@"%ld",indexPath.row];
        }
        /*else if (indexPath.row == 2) {//师范
            self.schoolType = @"2";
        }else if (indexPath.row == 3) {//农业
            self.schoolType = @"3";
        }else if (indexPath.row == 4) {//医药
            self.schoolType = @"4";
        }else if (indexPath.row == 5) {//军事
            self.schoolType = @"5";
        }else if (indexPath.row == 6) {//林业
            self.schoolType = @"6";
        }else if (indexPath.row == 7) {//语言
            self.schoolType = @"7";
        }else if (indexPath.row == 8) {//财经
            self.schoolType = @"8";
        }else if (indexPath.row == 9) {//体育
            self.schoolType = @"9";
        }else if (indexPath.row == 10) {//艺术
            self.schoolType = @"10";
        }else if (indexPath.row == 11) {//政法
            self.schoolType = @"11";
        }else if (indexPath.row == 12) {//民族
            self.schoolType = @"12";
        }*/
    }
}
@end
