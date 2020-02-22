//
//  HUZPkListCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZPkListCell : HUZTableViewCell

- (void)reloadData:(id)entity hasSelect:(NSMutableArray *)dataSelect;

@end

NS_ASSUME_NONNULL_END
