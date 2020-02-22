//
//  HUZMyFocusViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMyFocusViewController.h"
#import "HUZMyFocusSchoolViewController.h"
#import "HUZMyFocusMajorViewController.h"

@interface HUZMyFocusViewController ()

@end

@implementation HUZMyFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);

}

- (void)configComponents{
    [super configComponents];
    
    self.datas = @[@"学校",@"专业"];
    
    [self addivRadioBg];
    [self addTabPageBar];
    [self addPagerController];
    
    self.tabBar.frame = CGRectMake(0, AutoDistance(8), HUZSCREEN_WIDTH, AutoDistance(44));
    self.pagerController.view.frame = CGRectMake(0, AutoDistance(52), HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-AutoDistance(52));
    self.pagerController.view.backgroundColor = [UIColor redColor];
    
    [self.tabBar reloadData];
    [self.pagerController reloadData];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        return [HUZMyFocusSchoolViewController new];
    }
    return [HUZMyFocusMajorViewController new];
}

@end
