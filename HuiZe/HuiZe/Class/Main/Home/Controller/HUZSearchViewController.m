//
//  HUZSearchViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchViewController.h"
#import "HUZSearchNavView.h"
#import "HUZSearchResultViewController.h"
#import "HUZSearchingViewController.h"
#import "HUZSearchHistoryViewController.h"

@interface HUZSearchViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) HUZSearchNavView *searchNavView;
@property (nonatomic,strong) HUZSearchResultViewController *searchResultVC;
@property (nonatomic,strong) HUZSearchingViewController *searchingVC;
@property (nonatomic,strong) HUZSearchHistoryViewController *searchHistoryVC;
@property (nonatomic, copy) NSString * keyword;
@end

@implementation HUZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    self.navigationItem.titleView = self.searchNavView;
    self.searchNavView.intrinsicContentSize = CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(58), AutoDistance(30));
    self.searchNavView.tfKeyword.delegate = self;
    [self.searchNavView.tfKeyword addTarget:self action:@selector(tfKeywordChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self addChildViewController:self.searchResultVC];
    [self.view addSubview:self.searchResultVC.view];
    self.searchResultVC.searchVC = self;
    [self.searchResultVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [self addChildViewController:self.searchingVC];
    [self.view addSubview:self.searchingVC.view];
    self.searchingVC.searchVC = self;
    [self.searchingVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [self addChildViewController:self.searchHistoryVC];
    [self.view addSubview:self.searchHistoryVC.view];
    self.searchHistoryVC.searchVC = self;
    [self.searchHistoryVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    self.searchResultVC.view.hidden = YES;
    self.searchingVC.view.hidden = YES;

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.keyword) {
        self.searchResultVC.view.hidden = NO;
        self.searchResultVC.isGotoMajor = self.isGotoMajor;
        [self.searchResultVC clickSearchWithKeyword:self.keyword];
    }
}

- (void)clickKeywordSearch:(NSString *)keyword{
    self.keyword = keyword;
    self.searchNavView.tfKeyword.text = keyword;
    [self.searchNavView.tfKeyword resignFirstResponder];
    self.searchHistoryVC.view.hidden = YES;
    self.searchingVC.view.hidden = YES;
    self.searchResultVC.view.hidden = NO;
    [self.searchResultVC clickSearchWithKeyword:self.keyword];
    [self savekeyword:keyword];
}

/// 缓存搜索记录
- (void)savekeyword:(NSString *)keyword{
    NSMutableArray *searchHistoty = HUZUserCenterManager.searchHistory;
    if (![searchHistoty containsObject:keyword]) {
        [searchHistoty addObject:keyword];
    }
    HUZUserCenterManager.searchHistory = searchHistoty;
    [HUZUserCenterManager saveToCache];
    [self.searchHistoryVC reloadSearchHistory];
}

#pragma mark NETWork
/// 模糊查询
- (void)loadSearchKeywork:(NSString *)keyword{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"keyWord"] = self.keyword;
    HUZWEAK_SELF
    [HUZHomeService getSearchKeyword:par success:^(HUZSearchKeywordModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf.searchingVC setUniKeyword:model.data.universityEntityList majorKeywork:model.data.subjectEntities keyword:keyword];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.searchHistoryVC.view.hidden = YES;
    self.searchingVC.view.hidden = YES;
    self.searchResultVC.view.hidden = NO;
    [textField resignFirstResponder];
    [self.searchResultVC clickSearchWithKeyword:textField.text];
    [self savekeyword:textField.text];
    self.keyword = nil;
    return YES;
}

- (void)tfKeywordChange:(UITextField *)tf{
    if (DRStringIsEmpty(tf.text)) {
        self.searchHistoryVC.view.hidden = NO;
        self.searchingVC.view.hidden = YES;
        self.searchResultVC.view.hidden = YES;
    }else{
        self.searchHistoryVC.view.hidden = YES;
        self.searchingVC.view.hidden = NO;
        self.searchResultVC.view.hidden = YES;
    }
    [self loadSearchKeywork:tf.text];
}

#pragma mark - Lazy
- (HUZSearchNavView *)searchNavView{
    if (!_searchNavView) {
        _searchNavView = [[HUZSearchNavView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH-AutoDistance(58), AutoDistance(30))];
    }
    return _searchNavView;
}

- (HUZSearchResultViewController *)searchResultVC{
    if (!_searchResultVC) {
        _searchResultVC = [HUZSearchResultViewController new];
    }
    return _searchResultVC;
}

- (HUZSearchingViewController *)searchingVC{
    if (!_searchingVC) {
        _searchingVC = [HUZSearchingViewController new];
    }
    return _searchingVC;
}
//搜索历史
- (HUZSearchHistoryViewController *)searchHistoryVC{
    if (!_searchHistoryVC) {
        _searchHistoryVC = [HUZSearchHistoryViewController new];
    }
    return _searchHistoryVC;
}

@end
