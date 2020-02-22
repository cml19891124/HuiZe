//
//  HUZVolFillResultController.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolFillResultController.h"
#import "HUZVolFillResultView.h"
#import "HUZMineVolunteerListController.h"

#import "HUZVolunteerService.h"

#import "HUZVolunteerAnalyzeController.h"

@interface HUZVolFillResultController ()
@property (strong, nonatomic) HUZVolFillResultView *result;

@property (strong, nonatomic) HUZIntelligenceFormDataModel *formModel;

@end

@implementation HUZVolFillResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HUZVolFillResultView *result = [[HUZVolFillResultView alloc]initWithFrame:self.view.frame];
    [result.bBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [result.detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [result.volBtn addTarget:self action:@selector(volClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:result];
    self.result = result;

}

- (void)configDatas {
    [super configDatas];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:self.boyAndGirlsId forKey:@"boyAndGirl"]; // 男女比例
    [postDic setObject:[self.majorIds componentsSeparatedByString:@","]?:@[] forKey:@"majorAllIds"]; // 一级专业id
    [postDic setObject:[self.schoolIds componentsSeparatedByString:@","]?:@[] forKey:@"schoolProvinceIds"]; // 学校省份id
    
    HUZWEAK_SELF;
    [self displayOverFlowActivityView];
    [HUZVolunteerService getVolunteerIntelligenceTestFormWithParamters:postDic success:^(HUZIntelligenceFormDataModel *_Nonnull formModel) {
        
        [weakSelf removeOverFlowActivityView];
        
        if (!formModel.data) {
            return ;
        }
        weakSelf.formModel = formModel;
        HUZRationalityNumber *result = formModel.data.rationalityNumber.firstObject;
        weakSelf.result.labResult.text = result.opinion;
        
        HUZOptimizationNumberModel *number = formModel.data.optimizationNumber.firstObject;
        if (number.modify > 0) {
            [weakSelf.result.detailBtn setTitle:@"点击进行优化" forState:UIControlStateNormal];
            HUZRationalityNumber *reasonOpinion = self.formModel.data.rationalityNumber.firstObject;

            weakSelf.result.labAnaly.text = [NSString stringWithFormat:@"此志愿表%@",reasonOpinion.opinion];
        }else{
            [weakSelf.result.detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];

            weakSelf.result.labAnaly.text = [NSString stringWithFormat:@"此志愿表还有:%ld处可进行合理优化", number.modify];

        }

    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)detailClick {

    HUZVolunteerAnalyzeController *analysis = [HUZVolunteerAnalyzeController new];
    HUZRationalityNumber *result = self.formModel.data.rationalityNumber.firstObject;
    if ([result.opinion isEqualToString:@"不合理"]) {
        analysis.reasonable = 0;
    }else if ([result.opinion isEqualToString:@"良好"]){
        analysis.reasonable = 1;
    }else{
        analysis.reasonable = 2;
    }
    
    analysis.formModel = self.formModel;
    [self.navigationController pushViewController:analysis animated:YES];

}

- (void)volClick {
    HUZMineVolunteerListController *vol = [HUZMineVolunteerListController new];
    [self.navigationController pushViewController:vol animated:YES];
}

@end
