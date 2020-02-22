//
//  HUZSegmentViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"
#import "SHSegmentedControlTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSegmentViewController : HUZViewController<SHSegTableViewDelegate>

/// 分栏数据
@property (nonatomic,strong) NSArray *dataSegment;
/// segmentControl 下划线宽
@property (nonatomic,assign) CGFloat progressW;


@property (nonatomic,strong) SHSegmentedControlTableView *segTableView;
@property (nonatomic,strong) SHSegmentControl *segmentControl;
@property (nonatomic,strong) UIView *ivRadio;

@end

NS_ASSUME_NONNULL_END
