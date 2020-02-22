//
//  HUZUniContinueStudyCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "ZZCircleProgress.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniContinueStudyCell : HUZTableViewCell

@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) ZZCircleProgress *progressView1;
@property (nonatomic,strong) ZZCircleProgress *progressView2;
@property (nonatomic,strong) UILabel *labContent1;
@property (nonatomic,strong) UILabel *labContent2;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;

@property (nonatomic,strong) HUZUniInfoGeneralizeDataModel *uniInfoModel;  /// 大学信息对象

@end

NS_ASSUME_NONNULL_END
