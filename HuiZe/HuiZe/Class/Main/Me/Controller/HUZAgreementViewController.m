//
//  HUZAgreementViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZAgreementViewController.h"

@interface HUZAgreementViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation HUZAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
//    self.webView.scrollView.bounces = NO;
//    self.webView.frame = CGRectMake(0, HUZSTATUS_BAR_HEIGHT, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_HEIGHT);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    panGesture.delegate = self; // 设置手势代理，拦截手势触发
//    [self.view addGestureRecognizer:panGesture];
//    // 一定要禁止系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)setNavTitle:(NSString *)navTitle {
    _navTitle = [navTitle copy];
    self.navigationItem.title = navTitle;
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
//    if(self.navigationController.childViewControllers.count == 1)
//    {
//        return NO;
//    }
//
//    return YES;
//}

- (void)handleNavigationTransition:(UIGestureRecognizer *)ges{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
-(void)setUrl:(NSString *)url {
    _url = url;
}
-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT)];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        _webView.backgroundColor = UIColor.whiteColor;
    }
    return _webView;
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//
//{
//    return YES;
//}




-(void)webViewDidFinishLoad:(UIWebView *)webView
{
/*
    NSString *js = @"function changeImgWH() { \
           var imgs = document.getElementsByTagName('img'); \
           for (var i = 0; i < imgs.length; ++i) {\
           var img = imgs[i];\
           var imgW = img.width;\
           var imgH = img.height;\
           var s = imgH/imgW;\
           img.style.maxWidth = %f;\
           img.height = img.width*s; \
           } \
            let body = document.getElementsByTagName('body')[0]; \
            body.setAttribute('style', 'margin: 0;padding: 10px') \
           } \
       changeImgWH()";
    
       js = [NSString stringWithFormat:js, HUZSCREEN_WIDTH];
       [webView stringByEvaluatingJavaScriptFromString:js];
    webView.scrollView.contentSize = CGSizeMake(HUZSCREEN_WIDTH, webView.scrollView.contentSize.height + 30);
    //获取到webview的高度
//    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height + 30);
//    }];

*/
}

@end
