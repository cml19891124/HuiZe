//
//  HUZDebugMacro.h
//  HuiZe
//
//  Created by ZXS Coder on 2019/3/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#ifndef HUZDebugMacro_h
#define HUZDebugMacro_h

// 方法
#ifdef DEBUG

#define HUZLOG(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#define HUZMETHOD_LOG(fmt, ...) NSLog((@"函数名:%s" " 行号:%d " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define HUZLOG(fmt, ...)
#define HUZMETHOD_LOG(fmt, ...)

#endif

#endif /* HUZDebugMacro_h */
