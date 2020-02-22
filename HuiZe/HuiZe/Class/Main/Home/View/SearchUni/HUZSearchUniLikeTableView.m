//
//  HUZSearchUniLikeTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchUniLikeTableView.h"
#import "HUZSearchUniLikeCell.h"
#import "FSSegmentTitleView.h"
#import "FSPageContentView.h"
#import "HUZUlikeUniViewController.h"
#import "HUZDressUniView.h"

#import "HUZLoginService.h"

@interface HUZSearchUniLikeTableView ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic,strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong) HUZSearchUniLikeCell *searchUniLikeCell;
@property (nonatomic,strong) HUZDressUniView *dressView;

@property (nonatomic,strong) NSMutableArray *dataProvince;  /// 省份
@property (nonatomic,strong) NSMutableArray *contentVCs;
@end

@implementation HUZSearchUniLikeTableView

- (void)setDatasType:(NSArray *)datasType{
    _datasType = datasType;
    [self reloadData];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.rowHeight = HUZSCREEN_HEIGHT-AutoDistance(90)-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT;
        
        [self loadProvince];
    }
    return self;
}

#pragma mark NETWork
/// 获取省份
- (void)loadProvince{
    self.dataProvince = [NSMutableArray new];
    HUZWEAK_SELF
    [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
        HUZSTRONG_SELF
        [strongSelf.dataProvince addObjectsFromArray:object.data];
        HUZProvince *province = [HUZProvince new];
        province.Id = @"-1";
        province.title = @"不限";
        [strongSelf.dataProvince insertObject:province atIndex:0];
        [strongSelf.dressView loadData:strongSelf.dataProvince];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
    }];
}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.searchUniLikeCell = [tableView dequeueReusableCellWithIdentifier:@"planCell"];
    UIViewController *VC = [UIViewController currentViewController];
    if (!self.searchUniLikeCell) {
        self.searchUniLikeCell = [[HUZSearchUniLikeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"planCell"];
        self.contentVCs = [NSMutableArray array];
        for (int i = 0 ; i < self.datasType.count; i ++) {
            HUZUlikeUniViewController *ulikeUniVC = [HUZUlikeUniViewController new];
            ulikeUniVC.type = self.type == HUZSearchUniLike ? 1 : 2; ///1-猜你喜欢  2-名企热招
            ulikeUniVC.category = -1;
            ulikeUniVC.address = -1;
            ulikeUniVC.keyOne = - 1;
            ulikeUniVC.schoolPrivate = -1;
            ulikeUniVC.schoolType = i-1;
            [self.contentVCs addObject:ulikeUniVC];
        }
        self.searchUniLikeCell.viewControllers = self.contentVCs;
        self.searchUniLikeCell.pageContentView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-AutoDistance(90)-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT) childVCs:self.contentVCs parentVC:VC delegate:self];
        [self.searchUniLikeCell.contentView addSubview:self.searchUniLikeCell.pageContentView];
    }
    return self.searchUniLikeCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(44);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
    headerView.backgroundColor = COLOR_BG_WHITE;
    
    self.titleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(10, 0, HUZSCREEN_WIDTH-AutoDistance(35), AutoDistance(44)) titles:self.datasType delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = COLOR_BG_WHITE;
    self.titleView.titleFont = FontS(FONT_14);
    self.titleView.titleSelectFont = FontS(FONT_14);
    self.titleView.titleNormalColor = ColorS(COLOR_989898);
    self.titleView.titleSelectColor = ColorS(COLOR_2E86FF);
    self.titleView.indicatorColor = [UIColor clearColor];
    self.titleView.itemMargin = 18;
    [headerView addSubview:self.titleView];
    
    /// 猜你喜欢 筛选功能
    if (self.type == HUZSearchUniLike) {
        UIView *ivBg = [[UIView alloc] initWithFrame:CGRectMake(HUZSCREEN_WIDTH - AutoDistance(35), 0, AutoDistance(35), AutoDistance(44))];
        ivBg.backgroundColor = COLOR_BG_WHITE;
        [headerView addSubview:ivBg];
        
        UIImageView *ivSearchConditon = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_search_condition")];
        ivSearchConditon.frame = CGRectMake(AutoDistance(10), AutoDistance(14), AutoDistance(14), AutoDistance(14));
        [ivBg addSubview:ivSearchConditon];
        ivSearchConditon.userInteractionEnabled  = YES;
        HUZWEAK_SELF
        [ivSearchConditon jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            HUZSTRONG_SELF
            [strongSelf showDressView];
        }];
    }
    return headerView;
}

#pragma mark FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectIndex = endIndex;
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.searchUniLikeCell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress{
}

/// 显示筛选弹窗
- (void)showDressView{
    [self.dressView show];
    HUZWEAK_SELF
    self.dressView.sendBlock = ^(int category, int address, int keyone, int schoolPrivate, int schoolType) {
        HUZSTRONG_SELF
        /// 滚动到对应的栏目 进行数据刷新
        strongSelf.searchUniLikeCell.pageContentView.contentViewCurrentIndex = schoolType+1;
        strongSelf.titleView.selectIndex = schoolType+1;
        HUZUlikeUniViewController *VC = strongSelf.contentVCs[schoolType+1];
        [VC reloadUlikeListWithCategory:category address:address keyOne:keyone schoolPrivate:schoolPrivate schoolType:schoolType];
    };
}

#pragma mark Lazy
- (HUZDressUniView *)dressView{
    if (!_dressView) {
        _dressView = [[HUZDressUniView alloc] initWithFrame:CGRectMake(HUZSCREEN_WIDTH, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT)];
    }
    return _dressView;
}

@end

