//
//  HomeModel.m
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import "PageModel.h"

@implementation PageItem : NSObject

@end


@implementation PageData
+(NSDictionary *)objectClassInArray
{
    return @{
             @"b" : [PageItem class]
             };
}
@end

@implementation PageResult

@end

@implementation PageModel

@end
