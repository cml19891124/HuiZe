//
//  HUZGradeCircleView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "ZZCircleProgress.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGradeCircleView : HUZView
@property (nonatomic,strong) ZZCircleProgress *progressView;
@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UILabel *labDes;

@end

NS_ASSUME_NONNULL_END
