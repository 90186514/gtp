//
//  ApiConfig.m
//  gtp
//
//  Created by Aalto on 2019/1/3.
//  Copyright © 2019 Aalto. All rights reserved.
//

#import "ApiConfig.h"

@implementation ApiConfig
+ (NSString *)getAppApi:(ApiType)type{
    NSString *api = nil;
    switch (type)
    {
        case ApiType_Login: api = @"rank/list/ug/usr/pblin.do"; break;
        case ApiType_Vertify: api = @"ug/usr/pbggc.do"; break;
        
        case ApiType_BTCCheck: api = @"ug/btc/pbers.do"; break;
        case ApiType_BTCApply: api = @"ug/btc/pbebs.do"; break;
        case ApiType_BTCList: api = @"ug/btc/pbels.do"; break;
            
            
        case ApiType_Homes: api = @""; break;
            
    }
    return api;
}
@end
