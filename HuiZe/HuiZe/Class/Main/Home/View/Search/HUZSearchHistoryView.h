//
//  HUZSearchHistoryView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HUZSearchHistoryViewBlock)(NSString *searchStr);

@interface HUZSearchHistoryView : HUZView


- (void)setData;
- (CGFloat)cacluateHeight;

@property (nonatomic,copy) HUZSearchHistoryViewBlock searchHistoryViewBlock;

@end

NS_ASSUME_NONNULL_END
