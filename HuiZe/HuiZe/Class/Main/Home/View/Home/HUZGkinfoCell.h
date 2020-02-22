//
//  HUZGkinfoCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "FSScrollContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGkinfoCell : HUZTableViewCell
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) NSString *currentTagStr;

@end

NS_ASSUME_NONNULL_END
