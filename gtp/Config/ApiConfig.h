//
//  ApiConfig.m
//  gtp
//
//  Created by WIQ on 2019/1/3.
//  Copyright © 2019 WIQ. All rights reserved.
//

#ifndef ApiConfig_h
#define ApiConfig_h


#define URL_IP @"http://47.52.45.85:8010/"
//#define URL_IP @"http://18.188.82.157:8010/"
#define LNURL_IP @"http://app.u17.com/v3/appV3_3/ios/phone/"
//请求Cookie接口
#define API_GetCookie @"uuserApi/OKay"

#endif /* ApiConfig_h */

typedef NS_ENUM(NSInteger, ApiType)
{
//    ApiTypeNone = 0,
    ApiType_Login,
    ApiType_Vertify,
    
    ApiType_BTCCheck,
    ApiType_BTCApply,
    ApiType_BTCList,
    
    ApiType_Homes,
};
@interface ApiConfig : NSObject

+ (NSString *)getAppApi:(ApiType)type;

@end
