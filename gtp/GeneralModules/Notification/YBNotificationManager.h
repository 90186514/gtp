//
//  YBNotificationManager.h
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>
FOUNDATION_EXTERN NSString * const kNotify_NetWorkingStatusRefresh;

extern NSString* const kIsLogin;
extern NSString* const kUserName;
extern NSString* const kUserPW;
extern NSString* const kUserInfo;

extern NSString* const kPayMethodesInPostAds;
extern NSString* const kFixedAccountsInPostAds;

extern NSString* const kIndexSection;
extern NSString* const kIndexInfo;
extern NSString* const kIndexRow;

extern NSString* const kType ;
extern NSString* const kIsOn ;
extern NSString* const kImg;
extern NSString* const kTit;
extern NSString* const kSubTit;
extern NSString* const kUrl;
extern NSString* const kArr;
extern NSString* const kData;
typedef NS_ENUM(NSUInteger,IndexSectionType){
    IndexSectionZero = 0 ,
    IndexSectionOne ,
    IndexSectionTwo ,
    IndexSectionThree ,
    IndexSectionFour ,
    IndexSectionFive ,
};
typedef NS_ENUM(NSUInteger,EnumActionTag){
    EnumActionTag0 = 0 ,
    EnumActionTag1  ,
    EnumActionTag2  ,
    EnumActionTag3  ,
    EnumActionTag4  ,
    EnumActionTag5  ,
    EnumActionTag6  ,
};

typedef NS_ENUM(NSUInteger,PostAdsType){
    PostAdsTypeCreate = 0 ,
    PostAdsTypeEdit,
};

typedef NS_ENUM(NSUInteger,PostAdsDetailType){
    PostAdsDetailTypeSuccess = 0 ,
    
};

typedef NS_ENUM(NSUInteger,OrderType){
    OrderTypeWaitDistribute = 0 ,
    OrderTypeAppeal ,
    
    OrderTypeCancel,
    OrderTypeTimeOut,
    
    OrderTypeWaitPay ,
    
    OrderTypeFinished ,
};



typedef NS_ENUM(NSUInteger,ExchangeType){
    ExchangeTypeAll = 0,
    
    ExchangeTypeHandling,
    
    ExchangeTypePayed,
    ExchangeTypeBack,
    
    
};


NS_ASSUME_NONNULL_BEGIN

@interface YBNotificationManager : NSObject
@end

NS_ASSUME_NONNULL_END
