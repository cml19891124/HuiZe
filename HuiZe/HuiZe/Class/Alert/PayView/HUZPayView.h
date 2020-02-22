//
//  HUZPayView.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HUZPayViewBlock)(NSString *payway);

@interface HUZPayView : HUZView

- (void)showWithPrice:(NSString *)price;

- (void)dismiss;

@property (nonatomic,copy) HUZPayViewBlock payBlock;

@end

NS_ASSUME_NONNULL_END
