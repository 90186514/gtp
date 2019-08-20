//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeItem : NSObject
@property (nonatomic, strong) NSString * approveStatus;
@property (nonatomic, strong) NSString * brand;
@property (nonatomic, strong) NSString * cid;
@property (nonatomic, assign) NSInteger created;
@property (nonatomic, strong) NSString * deliveryRegion;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSString * designCode;
@property (nonatomic, strong) NSString * expressFee;
@property (nonatomic, strong) NSString * factory;
@property (nonatomic, strong) NSString * factoryContact;
@property (nonatomic, strong) NSString * factorySite;
@property (nonatomic, strong) NSString * freightPayer;
@property (nonatomic, assign) BOOL hasInvoice;
@property (nonatomic, assign) BOOL hasWarranty;
@property (nonatomic, strong) NSString * iItemimg;
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, assign) BOOL isOffline;
@property (nonatomic, assign) NSInteger listTime;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSString * prdLicenseNo;
@property (nonatomic, assign) CGFloat  price;
@property (nonatomic, copy) NSString* productDate;
@property (nonatomic, copy) NSString* productValidDate;
@property (nonatomic, strong) NSString * sid;
@property (nonatomic, strong) NSString* size;
@property (nonatomic, strong) NSString * stuffStatus;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString* validThru;
@property (nonatomic, strong) NSString* weight;
@property (nonatomic, strong) NSString * wirelessDesc;
@end

@interface HomeBaseInfoList : NSObject//
@property (nonatomic, strong) NSString * categoryPropMap;
@property (nonatomic, strong) HomeItem * item;
@property (nonatomic, strong) NSString * majorImg;
@property (nonatomic, strong) NSString * totalCount;

@end

@interface BData : NSObject
@property (nonatomic, strong) NSString * sid;
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;
@end

@interface RItem : NSObject
@property (nonatomic, strong) NSString * sid;
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;
@end

@interface RData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
+(NSDictionary *)objectClassInArray;
@end

@interface WItem : NSObject
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

@interface WData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;
+(NSDictionary *)objectClassInArray;
@end

@interface MallItem : NSObject
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;
@end

@interface MallData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
+(NSDictionary *)objectClassInArray;
@end

@interface ProductItem : NSObject
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;
@end

@interface ProductData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
+(NSDictionary *)objectClassInArray;
@end

@interface GardenItem : NSObject
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;
@end

@interface GardenData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
+(NSDictionary *)objectClassInArray;
@end

@interface TItem : NSObject
@property (nonatomic, strong) NSString * sid;
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString * title;

@end

@interface TData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
+(NSDictionary *)objectClassInArray;
@end






@interface HomeData : NSObject
@property (nonatomic, strong) NSArray * itemBaseInfoList;
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, strong) NSArray * b;

@property (nonatomic, strong) WData * r;
@property (nonatomic, strong) WData * w;
@property (nonatomic, strong) WData * t;

@property (nonatomic, strong) WData * banner;
@property (nonatomic, strong) WData * priority;
@property (nonatomic, strong) WData * todayRecommend;
@property (nonatomic, strong) WData* benefit;

@property (nonatomic, strong) WData * product;
@property (nonatomic, strong) WData * sidelineProduct;
@property (nonatomic, strong) WData * garden;
@property (nonatomic, strong) WData * mall;
@property (nonatomic, strong) WData * recommend;
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
