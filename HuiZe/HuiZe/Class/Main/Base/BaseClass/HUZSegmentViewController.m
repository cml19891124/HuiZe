//
//  HUZSegmentViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSegmentViewController.h"

@interface HUZSegmentViewController ()

@end

@implementation HUZSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    self.progressW = HUZSCREEN_WIDTH/2.0;
}

#pragma mark - SHSegTableViewDelegate
- (void)segTableViewDidScrollY:(CGFloat)offsetY {
    
}
- (void)segTableViewDidScroll:(UIScrollView *)tableView {
    
}
- (void)segTableViewDidScrollSub:(UIScrollView *)subTableView {
    
}
- (void)segTableViewDidScrollProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    if (progress == 1) {
        [self.segmentControl setSegmentSelectedIndex:targetIndex];
    }
}

#pragma mark - Lzay
- (SHSegmentControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(45)) items:self.dataSegment];
        _segmentControl.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        _segmentControl.titleNormalColor = ColorS(COLOR_989898);
        _segmentControl.titleSelectColor = ColorS(COLOR_2E86FF);
        _segmentControl.titleNormalFont = FontS(FONT_15);
        _segmentControl.titleSelectFont = FontS(FONT_15);
        _segmentControl.progressColor = ColorS(COLOR_BG_2E86FF);
        _segmentControl.progressHeight = AutoDistance(2);
        _segmentControl.progressWidth = self.progressW;
        [_segmentControl reloadViews];
        __weak __typeof(&*self)weakSelf = self;
        _segmentControl.curClick = ^(NSInteger index) {
            [weakSelf.segTableView setSegmentSelectIndex:index];
        };
        [_segmentControl insertSubview:self.ivRadio atIndex:0];
    }
    return _segmentControl;
}

- (SHSegmentedControlTableView *)segTableView {
    if (!_segTableView) {
        _segTableView = [[SHSegmentedControlTableView alloc] initWithFrame:self.view.bounds];
        _segTableView.tableView.bounces = NO;
        _segTableView.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        _segTableView.delegateCell = self;
        [_segTableView setBarView:self.segmentControl];
    }
    return _segTableView;
}

- (UIView *)ivRadio{
    if (!_ivRadio) {
        _ivRadio = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
        _ivRadio.backgroundColor = [UIColor whiteColor];
        [UIView huz_bezierPathWithRoundedRect:_ivRadio];
    }
    return _ivRadio;
}

@end
