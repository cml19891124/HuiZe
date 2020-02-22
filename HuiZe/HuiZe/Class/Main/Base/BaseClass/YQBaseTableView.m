//
//  YQBaseTableView.m
//  Pension
//
//  Created by tbb on 2019/5/30.
//  Copyright © 2019  YIQI. All rights reserved.
//

#import "YQBaseTableView.h"

@implementation YQBaseTableView

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 0.00;
        self.estimatedSectionFooterHeight = 0.00;
        self.estimatedSectionHeaderHeight = 0.00;
        self.backgroundColor = UIColor.whiteColor;
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}

@end
