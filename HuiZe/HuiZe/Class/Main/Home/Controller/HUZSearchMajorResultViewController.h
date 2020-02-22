//
//  HUZSearchMajorResultViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchMajorResultViewController : HUZTableViewController

- (void)searchMajorWithkeyword:(NSString *)keyword;
@property (nonatomic, assign) BOOL isGotoMajor;
@end

NS_ASSUME_NONNULL_END
