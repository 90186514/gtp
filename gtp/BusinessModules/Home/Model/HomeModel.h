//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WItem : NSObject
@property (nonatomic, strong) NSString * argValue;
@property (nonatomic, strong) NSString * rankingType;
@property (nonatomic, strong) NSString * argName;
@property (nonatomic, strong) NSString * cover;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subTitle;
@end

@interface WData : NSObject
@property (nonatomic, strong) NSArray * rankinglist;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;
+(NSDictionary *)objectClassInArray;
@end


@interface HomeData : NSObject
@property (nonatomic, strong) NSArray * itemBaseInfoList;
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, strong) WData * returnData;
+(NSDictionary *)objectClassInArray;
@end



@interface HomeResult : NSObject
@property (nonatomic, strong) HomeData * data;
@property (nonatomic, copy) NSString*  code;
@property (nonatomic, copy) NSString*  info;
@end


@interface HomeModel : NSObject
@property (nonatomic, copy) NSString * info;
@property (nonatomic, strong) HomeResult * result;

@end
