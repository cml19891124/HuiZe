//
//  HUZWebViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZWebViewController : HUZViewController<WKNavigationDelegate,WKUIDelegate>

///webview
@property (nonatomic,strong) WKWebView *webView;
///webView Title
@property (nonatomic,strong) NSString * webTitle;
///url
@property (nonatomic,copy) NSString * url;
/// 是否导航栏的title等于webView的title。默认是否 不等于，default is NO
@property (nonatomic, readwrite, assign) BOOL shouldDisableWebViewTitle;
@end

NS_ASSUME_NONNULL_END
