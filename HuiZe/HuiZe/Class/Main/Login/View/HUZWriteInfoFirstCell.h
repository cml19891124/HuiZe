//
//  HUZWriteInfoFirstCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZWriteInfoFirstCell : HUZCollectionViewCell

@property (nonatomic,strong) UILabel *labContent;

@property (nonatomic,assign) BOOL select;

- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath character:(NSString *)character subject:(NSString *)subject mark:(NSString *)mark rank:(NSString *)rank;

@end

NS_ASSUME_NONNULL_END
