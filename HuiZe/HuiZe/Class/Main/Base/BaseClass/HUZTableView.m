//
//  HUZTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableView.h"

@implementation HUZTableView


/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
