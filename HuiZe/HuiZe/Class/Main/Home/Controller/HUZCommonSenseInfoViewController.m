//
//  HUZCommonSenseInfoViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCommonSenseInfoViewController.h"

@interface HUZCommonSenseInfoViewController ()

@end

@implementation HUZCommonSenseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shouldDisableWebViewTitle = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


@end
