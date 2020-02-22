//
//  HUZCharacterTestViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCharacterTestViewController.h"
//#import <WebKit/WebKit.h>
@interface HUZCharacterTestViewController ()
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) JSContext *context;
@end

@implementation HUZCharacterTestViewController
//http://api.hz985211.com/test/html/index.html?type=
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试题目";
    [self.view addSubview: self.webView];


    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.delegate = self;
        _webView.backgroundColor = UIColor.whiteColor;
        
        NSString *webUrl = [NSString stringWithFormat:@"http://api.hz985211.com/test/html/index.html?%zd",self.type];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
        
        // 获取context对象
        self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        //将huize对象指向自身 js里面写window.huize.getToken() 就会调用原生里的getToken方法
        self.context[@"huize"] = self;
        self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
            context.exception = exceptionValue;
            NSLog(@"异常信息：%@", exceptionValue);
        };
        
    }
    
    return _webView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

#pragma mark -- <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //将huize对象指向自身 js里面写window.huize.getToken() 就会调用原生里的getToken方法
//    self.context[@"huize"] = self;
//    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
//        context.exception = exceptionValue;
//        NSLog(@"异常信息：%@", exceptionValue);
//    };

    //获取localStorage值
    NSString *test2 = [self.webView stringByEvaluatingJavaScriptFromString:@"localStorage.getItem('token')"];
    NSLog(@"test2: %@",test2);

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

#pragma mark -- JSObjcDelegate
- (NSString *_Nullable)getToken {
    return HUZUserCenterManager.userModel.token;
}

/*
 
 NSString * userContent = @"{\"name\": \"Tom\", \"age\": 10}"];
 // 设置localStorage
 NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('userContent', '%@')", userContent];
 // 移除localStorage
 // NSString *jsString = @"localStorage.removeItem('userContent')";
 // 获取localStorage
 // NSString *jsString = @"localStorage.getItem('userContent')";
 [self.webView stringByEvaluatingJavaScriptFromString:jsString];
 //清理掉所有的localStorage数据
 //NSString *clearString = @"localStorage.clear()";
 ————————————————
 版权声明：本文为CSDN博主「清丶风」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
 原文链接：https://blog.csdn.net/weixin_39803108/article/details/80969808
 
 */

@end
