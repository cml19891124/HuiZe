//
//  HUZMajorListModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorListModel.h"

@implementation HUZMajorListModel

- (instancetype)initWithFirst_index:(NSInteger)first_index second_index:(NSInteger)second_index third_index:(NSInteger)third_index is_show:(BOOL)is_show is_open:(BOOL)is_open content:(NSString *)content majorId:(NSString *)majorId{
    self = [super init];
    if (self) {
        _first_index = first_index;
        _second_index = second_index;
        _third_index = third_index;
        _is_show = is_show;
        _is_open = is_open;
        _content = content;
        _majorId = majorId;
    }
    return self;
}

@end
