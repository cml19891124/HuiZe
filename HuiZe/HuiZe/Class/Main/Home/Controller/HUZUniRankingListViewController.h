//
//  HUZUniRankingListViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniRankingListViewController : HUZTableViewController

@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic, assign) NSInteger type;//0代表us, 1代表qs, 2代表全国排名，3代表武书联排名 4代表理科排名 5代表文科排名
@end

NS_ASSUME_NONNULL_END

