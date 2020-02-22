//
//  HUZCommentInputView.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HUZCommentInputDelegate <NSObject>

- (void)commitComment:(NSString *)comment;

@end


@interface HUZCommentInputView : HUZView

- (void)show;
- (void)dismiss;
- (void)reset;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,weak) id<HUZCommentInputDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
