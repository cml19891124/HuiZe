//
//  HUZPushUpWindow.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

typedef NS_ENUM(NSInteger,HUZPushUpWindowType){
    HUZPushUpWindowProvince = 1,
    HUZPushUpWindowYear,
};

typedef void(^HUZPushUpWindowBlock)(NSString *hasSelectStr);

NS_ASSUME_NONNULL_BEGIN

@interface HUZPushUpWindow : HUZView

@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,assign) HUZPushUpWindowType type;

/// 选择的城市
@property (nonatomic,strong) NSString *province;
/// 选择的年份
@property (nonatomic,strong) NSString *year;

///show
- (void)showPushUpWindowType:(HUZPushUpWindowType)type withData:(NSArray *)data selectStr:(NSString *)selectStr;

@property (nonatomic,copy) HUZPushUpWindowBlock pushUpWindowBlock;

- (void)dismiss;

@end


NS_ASSUME_NONNULL_END
