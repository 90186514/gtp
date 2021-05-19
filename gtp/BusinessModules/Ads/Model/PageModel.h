//
//  HomeModel.h
//  LiNiuYang
//
//  Created by WIQ on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageItem : NSObject
@property (nonatomic, strong) NSString * sid;
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;

@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * title;
@end

@interface PageData : NSObject
@property (nonatomic, strong) NSArray * b;
+(NSDictionary *)objectClassInArray;
@end

@interface PageResult : NSObject
@property (nonatomic, strong) PageData * data;
@property (nonatomic, copy) NSString*  code;
@property (nonatomic, copy) NSString*  info;
@end


@interface PageModel : NSObject
@property (nonatomic, copy) NSString * info;
@property (nonatomic, strong) PageResult * result;
@end
