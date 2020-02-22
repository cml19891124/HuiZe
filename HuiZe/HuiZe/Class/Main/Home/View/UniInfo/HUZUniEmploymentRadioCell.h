//
//  HUZUniEmploymentRadioCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HUZUniEmploymentRadioType){
    HUZUniEmploymentRadioTop = 1,   //上半部分圆角
    HUZUniEmploymentRadioCenter,    //没有圆角
    HUZUniEmploymentRadioBottom,    //下半部分圆角
};

@interface HUZUniEmploymentRadioCell : HUZTableViewCell

/// 是否显示圆角
@property (nonatomic,assign) HUZUniEmploymentRadioType type;

@end

NS_ASSUME_NONNULL_END
