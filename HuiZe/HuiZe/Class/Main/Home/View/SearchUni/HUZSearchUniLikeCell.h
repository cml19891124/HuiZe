//
//  HUZSearchUniLikeCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "FSPageContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchUniLikeCell : HUZTableViewCell

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@end

NS_ASSUME_NONNULL_END
