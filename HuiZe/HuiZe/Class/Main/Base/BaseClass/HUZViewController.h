//
//  HUZViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RTRootNavigationController/RTRootNavigationController.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum {
    NAV_LEFT                    =0,
    NAV_RIGHT                   =1,
} NavigationBar;

@class HUZTargetBatchDataModel;
@interface HUZViewController : UIViewController


/// 界面初始化

- (void)configComponents;

/// 数据初始化

- (void)configDatas;

/// 自定义导航栏按钮
- (void)showBarButton:(NavigationBar)position title:(NSString *)name fontColor:(UIColor *)color;
- (void)showBarButton:(NavigationBar)position imageName:(NSString *)imageName;
- (void)showBarButton:(NavigationBar)position button:(UIButton *)button;
- (void)leftButtonTouch;
- (void)rightButtonTouch;

- (void)presentSheet:(NSString *)title;
- (void)presentSuccessSheet:(NSString *)title;
- (void)presentErrorSheet:(NSString *)title;
- (void)displayOverFlowActivityView;
- (void)removeOverFlowActivityView;
@property (nonatomic, strong) UIButton * rightBtn;
//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay;

///移除ios右滑返回
- (void)removeUIPanGestureRecognizer;
-(void)getVoluntaryTargetBatch:(void(^)(HUZTargetBatchDataModel *batchDataModel))targetBatchBlock;
-(void)stopRefresh:(UIScrollView *)scrollView;
-(void)setupRefresh:(UIScrollView *)scrollView;
-(void)onStartLoadMore;
-(void)onStartRefresh;
@end

NS_ASSUME_NONNULL_END
