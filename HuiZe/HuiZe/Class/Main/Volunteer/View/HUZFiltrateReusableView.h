//
//  HUZFiltrateReusableView.h
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^FiltrateReusableViewBlock)(BOOL state,NSInteger index);

@interface HUZFiltrateReusableView : UICollectionReusableView
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIButton *rightBtn;
@property(nonatomic)NSInteger index;//索引值
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)FiltrateReusableViewBlock filtrateReusableViewBlock;
@end

NS_ASSUME_NONNULL_END
