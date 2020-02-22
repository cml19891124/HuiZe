//
//  HUZCharacterFiltrateView.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef void(^SchoolFiltrateViewBlock)(NSString *selectedTitle,NSString *selectIdArrStr);
typedef void(^FiltrateViewBlock)(NSString *selectedTitle,NSString *selectIdArrStr);
@interface HUZCharacterFiltrateView : HUZView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *scrArray;

@property (strong, nonatomic) NSMutableArray *selectedTitleArray;
@property (nonatomic, strong) NSMutableArray * selectedIDArr;

@property(nonatomic,copy)FiltrateViewBlock sendBlock;
-(void)loadDataWithSectionArr:(NSArray*)sectionArr array:(NSArray*)array;
@end

NS_ASSUME_NONNULL_END
