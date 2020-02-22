//
//  HUZMajorFiltrateView.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

#import "HUZMajorListDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MajorFiltrateViewBlock)(NSString *selectedArray,NSString *selectedIdArrStr);
@interface HUZMajorFiltrateView : HUZView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *scrArray;

@property (strong, nonatomic) NSMutableArray *selectedTitleArray;
@property (strong, nonatomic) NSMutableArray *selectedIdArray;
@property (strong, nonatomic) NSMutableDictionary *dic;

@property (assign, nonatomic) NSInteger index;
@property(nonatomic,copy)MajorFiltrateViewBlock sendBlock;
-(void)loadDataWithSectionArr:(NSArray*)sectionArr array:(NSArray*)array;

@end

NS_ASSUME_NONNULL_END
