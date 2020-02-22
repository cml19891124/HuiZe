//
//  HUZMyGkInfoView.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBackBlock)(NSMutableDictionary *postDic);

@interface HUZMyGkInfoView : HUZView
@property (nonatomic,copy) CallBackBlock callBackBlock;

@end

NS_ASSUME_NONNULL_END
