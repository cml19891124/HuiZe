//
//  HUZViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"
#import "HUZTargetBatchModel.h"
@interface HUZViewController ()
@property (nonatomic,assign)BOOL isPresentSheet;

@end

@implementation HUZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BG_WHITE;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self configComponents];
    
    [self configDatas];
}

/// UI
- (void)configComponents{}

/// Datas
- (void)configDatas{}

#pragma mark - 自定义导航栏按钮
- (void)showBarButton:(NavigationBar)position title:(NSString *)name fontColor:(UIColor *)color{
    UIButton *button = [[UIButton alloc] initNavigationButtonWithTitle:name textColor:color];
    self.rightBtn = button;
    [self showBarButton:position button:button];
}

- (void)showBarButton:(NavigationBar)position imageName:(NSString *)imageName{
    UIButton *button = [[UIButton alloc] initNavigationButton:[UIImage imageNamed:imageName]];
    [self showBarButton:position button:button];
}

- (void)showBarButton:(NavigationBar)position button:(UIButton *)button{
    if (NAV_LEFT == position) {
        [button addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }else if (NAV_RIGHT == position){
        [button addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

- (void)leftButtonTouch{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonTouch{}

- (void)removeUIPanGestureRecognizer{
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
}

- (void)presentSheet:(NSString *)title {
    self.isPresentSheet = YES;
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    progressHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    progressHud.bezelView.backgroundColor = ColorS(COLOR_414141);
    progressHud.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    
    [self.view addSubview:progressHud];

    progressHud.mode = MBProgressHUDModeText;
    progressHud.label.text = title;
    progressHud.label.numberOfLines = 0;
    [progressHud.label sizeToFit];
    [progressHud showAnimated:YES];

    [self performBlock:^{
        [progressHud hideAnimated:YES];
        [progressHud removeFromSuperview];
    } afterDelay:1.5];
}

- (void)presentSuccessSheet:(NSString *)title {
    self.isPresentSheet = YES;
    [MBProgressHUD showSuccess:title toView:self.view];
}

- (void)presentErrorSheet:(NSString *)title {
    self.isPresentSheet = YES;
    [MBProgressHUD showError:title toView:self.view];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isPresentSheet) {
        [self removeOverFlowActivityView];
    }
}

- (void)displayOverFlowActivityView {
    self.isPresentSheet = NO;
    
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    progressHud.bezelView.backgroundColor = ColorS(COLOR_414141);
    progressHud.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    [self.view addSubview:progressHud];
    [self.view bringSubviewToFront:progressHud];
    progressHud.mode = MBProgressHUDModeIndeterminate;
    //_progressHud.delegate = self;
    //_HUD.labelText = cString;
    [progressHud showAnimated:YES];
    [progressHud setTag:9955];
    
}

- (void)removeOverFlowActivityView {
    [[self.view viewWithTag:9955]removeFromSuperview];
}

//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

-(void)setupRefresh:(UIScrollView *)scrollView{
    
    
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onStartRefresh)];
    
    
    scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onStartLoadMore)];
    [scrollView.mj_footer endRefreshingWithNoMoreData];
    
}
-(void)onStartLoadMore{
}

-(void)onStartRefresh{
}

-(void)stopRefresh:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
    [scrollView.mj_footer endRefreshing];
}

//获取建议填报志愿列表
-(void)getVoluntaryTargetBatch:(void(^)(HUZTargetBatchDataModel *batchDataModel))targetBatchBlock {
    [HUZNetWorkTool huz_POST:kUrl_Voluntary_TargetBatch parameters:@{} success:^(id  _Nonnull responseObject) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr intValue] == 0) {
            HUZTargetBatchDataModel *model = [HUZTargetBatchDataModel modelWithJSON:responseObject[@"data"]];
            if (targetBatchBlock) {
                targetBatchBlock(model);
            }
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self presentErrorSheet:error];
    }];
}
@end
