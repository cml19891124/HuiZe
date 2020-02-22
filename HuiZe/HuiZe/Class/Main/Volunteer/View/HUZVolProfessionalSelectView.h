//
//  HUZVolProfessionalSelectView.h
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZVoluntaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HUZVolProfessionalSelectView;

@protocol HUZVolProfessionalSelectViewDelegate <NSObject>

/**
 选择后代理方法
 */
- (void)professionalSelectViewDelegateWith:(HUZVolProfessionalSelectView *)selectView selectArr:(NSMutableArray *)selectArr;

@end
@class HUZVoluntPriority;
@interface HUZVolProfessionalSelectView : HUZView
@property (strong, nonatomic) HUZVoluntaryModel *model;
@property (copy, nonatomic) NSString *schoolName;
@property (copy, nonatomic) NSString *ID;
@property (nonatomic, strong) HUZVoluntPriority * voluntPriorityModel;
@property (copy, nonatomic) NSString *headTitle;
@property (strong, nonatomic) UIButton *btnDone;
@property (weak, nonatomic) id <HUZVolProfessionalSelectViewDelegate> delegate;
@property (nonatomic, assign) NSInteger alternativeType;//// 来源：0智能填报，1院校优先填报，2专业优先填报，3手动填报
/**
 显示  必须调用 
 */
- (void)show;
@end

NS_ASSUME_NONNULL_END
