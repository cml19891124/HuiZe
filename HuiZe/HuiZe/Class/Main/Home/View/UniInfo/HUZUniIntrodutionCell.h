//
//  HUZUniIntrodutionCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniIntrodutionCell : HUZTableViewCell

@property (nonatomic,strong) UILabel *labIntrodution;
@property (nonatomic,strong) UIButton *btnAll;

- (void)setUniInfoModel:(HUZUniInfoGeneralizeDataModel *)uniInfoModel isOpen:(BOOL)isOpen;
+ (CGFloat)calculateHeightWithEntity:(HUZUniInfoGeneralizeDataModel *)entity isOpen:(BOOL)isOpen;  /// 计算高度
@end

NS_ASSUME_NONNULL_END
