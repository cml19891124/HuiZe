//
//  HUZSearchMajorLikeTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 查专业--猜你喜欢
 */

#import "HUZSegmentTableView.h"

typedef NS_ENUM(NSInteger,HUZSearchMajorType){
    HUZSearchMajorUlike = 1, /// 猜你喜欢
    HUZSearchMajorHot,       /// 名企热招
};

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchMajorLikeTableView : HUZSegmentTableView

@property (nonatomic,assign) HUZSearchMajorType type;


@end

NS_ASSUME_NONNULL_END
