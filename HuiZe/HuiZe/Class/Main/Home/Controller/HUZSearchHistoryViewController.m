//
//  HUZSearchHistoryViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchHistoryViewController.h"
#import "HUZSearchHistoryView.h"

@interface HUZSearchHistoryViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) HUZSearchHistoryView *searchHistroyView;

@end

@implementation HUZSearchHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.searchHistroyView];
    self.searchHistroyView.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, [self.searchHistroyView cacluateHeight]);
    [self.scrollView setContentSize:CGSizeMake(HUZSCREEN_WIDTH, [self.searchHistroyView cacluateHeight])];
    HUZWEAK_SELF
    self.searchHistroyView.searchHistoryViewBlock = ^(NSString * _Nonnull searchStr) {
        HUZSTRONG_SELF
        [strongSelf.searchVC clickKeywordSearch:searchStr];
    };
}

- (void)reloadSearchHistory{
    [self.searchHistroyView setData];
}

#pragma mark - Lazy
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT)];
    }
    return _scrollView;
}

- (HUZSearchHistoryView *)searchHistroyView{
    if (!_searchHistroyView) {
        _searchHistroyView = [HUZSearchHistoryView new];
        [_searchHistroyView setData];
    }
    return _searchHistroyView;
}

@end
