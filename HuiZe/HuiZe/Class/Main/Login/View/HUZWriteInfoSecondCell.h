//
//  HUZWriteInfoSecondCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCollectionViewCell.h"

@protocol HUZWriteInfoSecondDelegate <NSObject>

- (void)clickInfoType:(NSInteger)type;

@end


NS_ASSUME_NONNULL_BEGIN

@interface HUZWriteInfoSecondCell : HUZCollectionViewCell

@property (nonatomic,strong) UILabel *labProvice;
@property (nonatomic,strong) UILabel *labYear;
@property (nonatomic,strong) UIImageView *ivPullDown1;
@property (nonatomic,strong) UIImageView *ivPullDown2;

@property (nonatomic,weak) id<HUZWriteInfoSecondDelegate> delegate;

- (void)reloadProvice:(NSString *)provice year:(NSString *)year;

@end

NS_ASSUME_NONNULL_END
