//
//  YBGeneralColor.m
//  YBArchitectureDemo
//
//  Created by 杨波 on 2018/11/19.
//  Copyright © 2018 杨波. All rights reserved.
//

#import "YBGeneralColor.h"

@implementation YBGeneralColor

+ (UIColor *)themeColor {
    return RGBCOLOR(76,127,255);
}

+ (UIColor *)navigationBarColor {
//    return RGBCOLOR(86,129,247);
    return kWhiteColor;
}

+ (UIColor *)navigationBarTitleColor {
    return [UIColor darkTextColor];
}

+ (UIColor *)tabBarTitleNormalColor {
    return [UIColor darkGrayColor];
}

+ (UIColor *)tabBarTitleSelectedColor {
    return COLOR_RGB(86,129,247,1);
}

+ (UIColor *)seperaterColor {
    return [UIColor groupTableViewBackgroundColor];
}

@end
