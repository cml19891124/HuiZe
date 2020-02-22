//
//  HUZSearchingCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchingCell : HUZTableViewCell
@property (nonatomic,strong) UILabel *labContent;

- (void)reloadData:(id)entity keyword:(NSString *)keyword;
@end

NS_ASSUME_NONNULL_END
