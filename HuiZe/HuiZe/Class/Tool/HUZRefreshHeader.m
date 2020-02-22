//
//  HUZRefreshHeader.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/8.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRefreshHeader.h"

@implementation HUZRefreshHeader

- (void)prepare{
    [super prepare];
    
//    /// 刷新状态文字颜色
//
//    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
//    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
//
//    ///  隐藏最后更新
//    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = NO;
}

- (void)placeSubviews{
    [super placeSubviews];
    
//    self.stateLabel.frame = CGRectMake(0, MJRefreshHeaderHeight - 25, HUZSCREEN_WIDTH, 20);
}


@end
