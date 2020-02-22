//
//  HUZShareView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HUZShareViewBlock)(NSString *platform);

static NSString *QZone = @"QZone";
static NSString *WCMoment =@"wechatmoment";
static NSString *WB =  @"weibo";
static NSString *QQ = @"qq";
static NSString *Wechat = @"wechat";

@interface HUZShareView : HUZView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *ivAlpha;
@property (nonatomic,strong) UIView *ivShare;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,copy) HUZShareViewBlock block;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
