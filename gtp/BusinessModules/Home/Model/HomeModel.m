//
//  HomeModel.m
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import "HomeModel.h"
@implementation HomeItem

@end
@implementation HomeBaseInfoList

@end

@implementation BData : NSObject
@end

@implementation RItem : NSObject
@end

@implementation RData : NSObject
+(NSDictionary *)objectClassInArray
{
    return @{
             @"arr" : [RItem class]
             };
}
@end

@implementation WItem : NSObject

@end

@implementation WData : NSObject
+(NSDictionary *)objectClassInArray
{
    return @{
             @"arr" : [WItem class]
             
             };
}
@end

@implementation MallItem : NSObject
@end

@implementation MallData : NSObject
+(NSDictionary *)objectClassInArray{
    return @{
             @"arr" : [MallItem class]
             
             };
}
@end

@implementation ProductItem : NSObject
@end

@implementation ProductData : NSObject
+(NSDictionary *)objectClassInArray
{
    return @{
             @"arr" : [ProductItem class]
             
             };
}
@end

@implementation GardenItem : NSObject
@end

@implementation GardenData : NSObject
+(NSDictionary *)objectClassInArray
{
    return @{
             @"arr" : [GardenItem class]
             
             };
}
@end

@implementation TItem : NSObject
@end

@implementation TData : NSObject
+(NSDictionary *)objectClassInArray
{
    return @{
             @"arr" : [TItem class]
             
             };
}
@end


@implementation HomeData
+(NSDictionary *)objectClassInArray
{
    return @{
             @"itemBaseInfoList" : [HomeBaseInfoList class],
             @"b" : [WItem class]
             
             };
}
@end

@implementation HomeResult

@end

@implementation HomeModel

@end
