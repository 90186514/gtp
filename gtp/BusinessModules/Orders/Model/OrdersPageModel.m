//
//  HomeModel.m
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import "OrdersPageModel.h"

@implementation OrdersPageItem : NSObject

@end


@implementation OrdersPageData
+(NSDictionary *)objectClassInArray
{
    return @{
             @"b" : [OrdersPageItem class]
             };
}
@end

@implementation OrdersPageResult

@end

@implementation OrdersPageModel

@end
