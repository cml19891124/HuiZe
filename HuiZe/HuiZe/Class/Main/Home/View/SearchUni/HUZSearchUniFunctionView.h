//
//  HUZSearchUniFunctionView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchUniFunctionView : HUZView

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;

@property (nonatomic,strong) UIImageView *ivFunction;
@property (nonatomic,strong) UILabel *labFunction;
@end

NS_ASSUME_NONNULL_END
