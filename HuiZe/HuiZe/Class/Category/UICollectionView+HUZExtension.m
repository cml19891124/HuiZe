//
//  UICollectionView+HUZExtension.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "UICollectionView+HUZExtension.h"

@implementation UICollectionView (HUZExtension)
- (void)dz_registerCell:(Class)cls {
    [self dz_registerCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)dz_registerNibCell:(Class)cls {
    [self dz_registerNibCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}


- (void)dz_registerView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind{
    [self dz_registerView:cls forSupplementaryViewOfKind:kind forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
}

- (void)dz_registerNibView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind{
    [self dz_registerNibView:cls forSupplementaryViewOfKind:kind forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)dz_registerNibView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
}
@end
