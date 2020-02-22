//
//  HUZDressUniView.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^HUZDressUniViewBlock)(int category,int address, int keyone, int schoolPrivate, int schoolType);

@interface HUZDressUniView : HUZView
@property (nonatomic, assign) NSInteger type;//1.从本省高校进来
-(void)loadData:(NSMutableArray *)dataProvince;
@property (nonatomic,strong) NSMutableArray *dataProvince;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)HUZDressUniViewBlock sendBlock;

- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
