//
//  HUZSearchHistoryView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchHistoryView.h"

@interface HUZSearchHistoryView ()

@property (nonatomic,assign) CGFloat toLeft;
@property (nonatomic,assign) CGFloat toTop;


@end

@implementation HUZSearchHistoryView


- (void)initView{
    
}

- (void)setData{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.toLeft = AutoDistance(27);
    self.toTop = AutoDistance(49);
    
    UILabel *labHistory = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    labHistory.frame = CGRectMake(self.toLeft, AutoDistance(24), AutoDistance(60), AutoDistance(17));
    labHistory.text = @"历史搜索";
    [self addSubview:labHistory];
    
    NSMutableArray *searchHistoty = HUZUserCenterManager.searchHistory;
//    NSArray *searchHistoty = @[@"日语",@"计算机",@"清华大学",@"北京大学",@"麻省理工大学工程学院",@"广州大学",@"深大",@"中山大学"];
    for (int i = 0; i < searchHistoty.count; i ++) {
        NSString *searchStr = searchHistoty[i];
        CGFloat searchStrW = [searchStr jk_widthWithFont:FontS(FONT_12) constrainedToHeight:AutoDistance(17)];
        CGFloat btnW = searchStrW + AutoDistance(24);
        CGFloat btnH = AutoDistance(27);
        CGFloat spaceH = AutoDistance(18);  //列间距
        CGFloat spaceV = AutoDistance(8);   //行间距
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.toLeft, self.toTop, btnW , btnH);
        [btn setTitle:searchStr forState:UIControlStateNormal];
        [btn setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
        [btn setBackgroundColor:ColorS(COLOR_BG_E9E9E9)];
        [btn.titleLabel setFont:FontS(FONT_12)];
        ViewRadius(btn, 2);
        [self addSubview:btn];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        self.toLeft = self.toLeft + btnW + spaceH;
        if (i < searchHistoty.count - 1) {
            NSString *nextSearchStr = searchHistoty[i + 1];
            CGFloat nextSearchStrW = [nextSearchStr jk_widthWithFont:FontS(FONT_12) constrainedToHeight:AutoDistance(17)];
            if (self.toLeft + spaceH + nextSearchStrW + AutoDistance(27) > HUZSCREEN_WIDTH) {
                self.toLeft = AutoDistance(27);
                self.toTop = self.toTop + btnH + spaceV;
            }
        }
    }
}

- (CGFloat)cacluateHeight{
    return self.toTop + 20;
}

- (void)click:(UIButton *)sender{
    if(self.searchHistoryViewBlock) {
        self.searchHistoryViewBlock(sender.titleLabel.text);
    }
    
}

@end
