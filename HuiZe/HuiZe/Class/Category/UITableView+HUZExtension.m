//
//  UITableView+HUZExtension.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "UITableView+HUZExtension.h"

@implementation UITableView (HUZExtension)
- (void)dz_registerCell:(Class)cls {
    [self dz_registerCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forCellReuseIdentifier:reuseIdentifier];
}

- (void)dz_registerNibCell:(Class)cls {
    [self dz_registerNibCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}


- (void)dz_registerHeaderFooterViewView:(Class)cls{
    [self dz_registerHeaderFooterView:cls forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerHeaderFooterView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}

- (void)dz_registerHeaderFooterViewNibView:(Class)cls{
    [self dz_registerHeaderFooterNibView:cls forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerHeaderFooterNibView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}
@end
