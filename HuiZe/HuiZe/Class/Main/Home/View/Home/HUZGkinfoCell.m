//
//  HUZGkinfoCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkinfoCell.h"
#import "HUZGkInfoListViewController.h"

@implementation HUZGkinfoCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
//    static NSString *ID = @"HUZGkinfoCell";
//    HUZGkinfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
//    }
//    return cell;
//}

- (void)initView{

}


#pragma mark Setter
- (void)setViewControllers:(NSMutableArray *)viewControllers{
    _viewControllers = viewControllers;
}

- (void)setCellCanScroll:(BOOL)cellCanScroll{
    _cellCanScroll = cellCanScroll;
    
    for (HUZGkInfoListViewController *VC in _viewControllers) {
        VC.vcCanScroll = cellCanScroll;
        if (!cellCanScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.tableView.contentOffset = CGPointZero;
        }
    }
}

- (void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    
    for (HUZGkInfoListViewController *VC in self.viewControllers) {
        if ([VC.title isEqualToString:self.currentTagStr]) {
            VC.isRefresh = isRefresh;
        }
    }
}

@end
