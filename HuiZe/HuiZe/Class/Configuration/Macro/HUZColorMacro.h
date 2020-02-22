//
//  HUZColorMacro.h
//  HuiZe
//
//  Created by ZXS Coder on 2019/3/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#ifndef HUZColorMacro_h
#define HUZColorMacro_h

// 颜色
#define HUZRGBA_COLOR(R, G, B, A) [UIColor colorWithRed:(R / 255.0f) green:(G / 255.0f) blue:(B / 255.0f) alpha:A]
#define HUZRGB_COLOR(R, G, B) HUZRGBA_COLOR(R, G, B, 1.0f)
#define HUZAPP_BACKGROUND_COLOR HUZRGBA_COLOR(232, 237, 240, 1.0f)
#define HUZAPP_THEME_COLOR HUZRGBA_COLOR(80, 98, 233, 1.0f)
#define HUZRGBA_RANDOM_COLOR(R, G, B, A) [UIColor colorWithRed:(R / 255.0f) green:(G / 255.0f) blue:(B / 255.0f) alpha:(A / 255.0f)]
#define HUZRANDOM_COLOR HUZRGBA_RANDOM_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif /* HUZColorMacro_h */
