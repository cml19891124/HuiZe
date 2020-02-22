//
//  HUZSchoolAreaFiltrateView.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

#import "HUZProvinceModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SchoolFiltrateViewBlock)(NSString *selectedTitle,NSString *selectIdArrStr);
@interface HUZSchoolAreaFiltrateView : HUZView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *scrArray;

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSMutableArray *selectedTitleArray;
@property (nonatomic, strong) NSMutableArray * selectedIDArr;

@property (nonatomic, copy) NSArray * withSelectedIdsArr;

@property(nonatomic,copy)SchoolFiltrateViewBlock sendBlock;
-(void)loadDataWithSectionArr:(NSArray*)sectionArr array:(NSArray*)array;

@end

NS_ASSUME_NONNULL_END

