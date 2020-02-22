//
//  HUZCharacterTestViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 MBTI 性格测试
 */

#import "HUZWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSObjcDelegate <JSExport>
- (NSString *_Nullable)getToken;
@end


NS_ASSUME_NONNULL_BEGIN

@interface HUZCharacterTestViewController : HUZViewController <UIWebViewDelegate,JSObjcDelegate>
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
