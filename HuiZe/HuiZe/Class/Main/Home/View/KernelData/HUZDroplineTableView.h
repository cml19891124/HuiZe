//
//  HUZDroplineTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 核心数据-投档线
 */

#import "HUZSegmentTableView.h"
#import "HUZKernelConditonView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HUZDroplineDataType){
    HUZDroplineType = 1,   /// 投档线
    HUZEnterlineType,      /// 录取线
};

@interface HUZDroplineTableView : HUZSegmentTableView

@property (nonatomic,strong) HUZKernelConditonView *kernelConditonView;


@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *conditon;

@property (nonatomic,assign) HUZDroplineDataType type;

@property (nonatomic, strong) HUZGoToBuyVipView * droplineToBuyVipView;
@property (nonatomic, strong) HUZGoToBuyVipView * enterlineToBuyVipView;

@property (nonatomic, assign) NSInteger vipState;
@end

NS_ASSUME_NONNULL_END
