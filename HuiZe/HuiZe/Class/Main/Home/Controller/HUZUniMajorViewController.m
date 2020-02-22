//
//  HUZUniMajorViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
// 

#import "HUZUniMajorViewController.h"
#import "HUZUniMajorHeaderView.h"
#import "HUZAllMajorTableView.h"

@interface HUZUniMajorViewController ()

@property (nonatomic,strong) HUZUniMajorHeaderView *uniMajorHeaderView;
@property (nonatomic,strong) HUZAllMajorTableView *allMajorTableView;
@property (nonatomic,strong) HUZAllMajorTableView *specialMajorTableView;
@end

@implementation HUZUniMajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"该校专业详情";
    self.uniMajorHeaderView.infoModel = self.infoModel;
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSegment = @[@"所有专业",@"特色专业"];
    
    /// 所有专业
    self.allMajorTableView = [[HUZAllMajorTableView alloc] init];
    self.allMajorTableView.schoolId = self.infoModel.schoolId;
//    self.allMajorTableView.delegate = self;
//    self.allMajorTableView.dataSource = self;
    self.allMajorTableView.type = HUZAllMajor;
//    self.allMajorTableView.datas = self.infoModel.majorAllHomeVoList; //@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    
    /// 特色专业
    self.specialMajorTableView = [[HUZAllMajorTableView alloc] init];
    self.specialMajorTableView.schoolId = self.infoModel.schoolId;
    self.specialMajorTableView.type = HUZSpecialMajor;
    
//    self.specialMajorTableView.datas = self.infoModel.majorAllHomeVoList;//@[@"1",@"1",@"1"];

    
    [self.segTableView setTableViews:@[self.allMajorTableView,self.specialMajorTableView]];
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.uniMajorHeaderView];

}

#pragma mark - Lazy
- (HUZUniMajorHeaderView *)uniMajorHeaderView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 105 : 90;
    if (!_uniMajorHeaderView) {
        _uniMajorHeaderView = [[HUZUniMajorHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
    }
    return _uniMajorHeaderView;
}
-(void)setInfoModel:(HUZUniInfoGeneralizeDataModel *)infoModel {
    _infoModel = infoModel;
}

@end

