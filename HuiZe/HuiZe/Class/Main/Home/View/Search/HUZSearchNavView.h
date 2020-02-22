//
//  HUZSearchNavView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchNavView : HUZView

@property(nonatomic, assign) CGSize intrinsicContentSize;

@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIImageView *ivSearch;
@property (nonatomic,strong) UITextField *tfKeyword;

@end

NS_ASSUME_NONNULL_END
