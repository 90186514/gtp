//
//  ToolMacro.h
//  YBArchitectureDemo
//
//  Created by Aalto on 2018/11/18.
//  Copyright © 2018 Aalto. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h

//NSLog 重定义
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil;
#endif
//版控
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//自读屏宽高
#define MAINSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define MAINSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
//常见颜色
#define kClearColor [UIColor clearColor]
#define kBlackColor [UIColor blackColor]
#define kWhiteColor [UIColor whiteColor]
#define kGrayColor [UIColor grayColor]
#define kOrangeColor [UIColor orangeColor]
//RGB颜色
#define RGBSAMECOLOR(x) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:1]

#define COLOR_RGB(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define RANDOMRGBCOLOR RGBCOLOR((arc4random() % 256), (arc4random() % 256), (arc4random() % 256))
#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//十六进制颜色
#define HEXCOLOR(hexValue)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1]

#define COLOR_HEX(hexValue, al)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:al]

//字体
#define kFontSize(x)  [UIFont systemFontOfSize:x]

//图片
#define kIMG(imgName)    [UIImage imageNamed:imgName]
//异步获取某个队列
#define GET_QUEUE_ASYNC(queue, block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {\
block();\
} else {\
dispatch_async(queue, block);\
}
//获取主队列
#define GET_MAIN_QUEUE_ASYNC(block) GET_QUEUE_ASYNC(dispatch_get_main_queue(), block)
//libUser
#pragma mark - UserDefault
#define SetUserDefaultKeyWithObject(key,object) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
#define SetUserBoolKeyWithObject(key,object) [[NSUserDefaults standardUserDefaults] setBool:object forKey:key]

#define GetUserDefaultWithKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define GetUserDefaultBoolWithKey(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]

#define DeleUserDefaultWithKey(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
#define UserDefaultSynchronize  [[NSUserDefaults standardUserDefaults] synchronize]

#define LRToast(str) [NSString stringWithFormat:@"%@",@#str]


#pragma mark - 强弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define kWeakSelf(type)  __weak typeof(type) weak##type = type

#define kStrongSelf(type)  __strong typeof(type) type = weak##type


#endif /* ToolMacro_h */
