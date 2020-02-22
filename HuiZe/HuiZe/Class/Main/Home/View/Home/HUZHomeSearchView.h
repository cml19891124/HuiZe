//
//  HUZHomeSearchView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUZSearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZHomeSearchView : HUZView

@property(nonatomic, assign) CGSize intrinsicContentSize;

@property (nonatomic,strong) UILabel *labCd;
@property (nonatomic,strong) UILabel *labDayNum;
@property (nonatomic,strong) UILabel *labDay;
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIImageView *ivSearch;
@property (nonatomic,strong) UILabel *labKeyword;
@end

NS_ASSUME_NONNULL_END
