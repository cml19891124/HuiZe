//
//  HUZAccountCell.h
//  HuiZe
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZAccountCell : HUZTableViewCell
- (void)reloadDataWith:(NSString*)title detail:(NSString*)detail;

@end

NS_ASSUME_NONNULL_END
