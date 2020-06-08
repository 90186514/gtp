//
//  HomeModel.m
//  LiNiuYang
//
//  Created by WER on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import "ClockInModel.h"

@implementation ClockInModel
- (NSMutableArray*)setFilteredData:(NSMutableArray*)outcomeMutArr withSameKey:(NSString*)sameKey{
    NSMutableArray* attriArrs = [NSMutableArray array];
    [attriArrs addObjectsFromArray:[outcomeMutArr mutableCopy]];
    
    for (int i=0; i<attriArrs.count; i++) {
        NSDictionary* temA = attriArrs[i];
        NSString* AheadKey = sameKey;
        BOOL isContainKAmount = [[temA allKeys] containsObject:sameKey];
        if (!isContainKAmount) {
            continue;
        }
        
//        NSNumber* tempAValue = @([temA[AheadKey]intValue]);
        NSString* tempAValue = [NSString stringWithFormat:@"%@",temA[AheadKey]];


        
        NSMutableArray* Is = [NSMutableArray array];
        
        
        for (int j=i+1; j<attriArrs.count; j++) {
            NSDictionary* temB = attriArrs[j];
            NSString* BheadKey = sameKey;
            BOOL isContainKAmount = [[temB allKeys] containsObject:sameKey];
            if (!isContainKAmount) {
                continue;
            }
//            NSNumber* tempBValue = @([temB[BheadKey]intValue]);
            NSString* tempBValue = [NSString stringWithFormat:@"%@",temB[BheadKey]];
            
            if ( tempBValue.hash ==  tempAValue.hash) {
//                BheadKey.hash ==  AheadKey.hash &&
                
                tempAValue = tempBValue;
                
                NSMutableDictionary* dicHR = [NSMutableDictionary dictionary];
//                [dicHR setObject:tempAValue forKey:AheadKey];
                [dicHR addEntriesFromDictionary:temB];
                [attriArrs replaceObjectAtIndex:i  withObject:dicHR];
                
                [Is  addObject:@(j)];
                
            }
        }
        
        for (NSInteger h =Is.count - 1; h>=0; h--) {
            NSInteger remove = [Is[h] integerValue];
            [attriArrs removeObjectAtIndex:remove];
        }
    }
    
//    NSLog(@"setFilteredLastStringForSameKey%@",attriArrs);
    return attriArrs;


}

- (NSMutableArray*)getClickInStatusData{
    NSArray* incomeArr = @[
        @{@"居住":HEXCOLOR(0xffcc00)},
        @{@"去过":HEXCOLOR(0x0674e5)}
        ,@{@"想去":HEXCOLOR(0xe41bd3)}
    ];
    NSMutableArray* incomeMutArr = [NSMutableArray array];
    for (int i=0; i< incomeArr.count; i++){
        NSDictionary* dic0  = incomeArr[i];
        NSDictionary* dic1 = @{
            kType:@(i),
    //        kTit:[NSString stringWithFormat:@"%@",@"收入"],
            kIndexInfo:[NSString stringWithFormat:@"%@",dic0.allKeys[0]],
            kColor:dic0.allValues[0]
                               
                               };
        [incomeMutArr addObject:dic1];
    }
    return incomeMutArr;
}

- (NSMutableArray*)getFlags{
    NSArray* incomeArr = @[
        @"CN",
        @"JP",
        @"AU",
        @"US",
        @"SN",
        @"MY",
        @"TH",
        @"PH",
        @"KR",//KR = S，KP = N
        @"MM"
    ];
    NSMutableArray* incomeMutArr = [NSMutableArray array];
    for (int i=0; i< incomeArr.count; i++){
//        NSDictionary* dic0  = incomeArr[i];
//        NSDictionary* dic1 = @{
//            kType:@(i),
//    //        kTit:[NSString stringWithFormat:@"%@",@"收入"],
//            kIndexInfo:[NSString stringWithFormat:@"%@",dic0.allKeys[0]],
//            kColor:dic0.allValues[0]
//
//                               };
//        [incomeMutArr addObject:dic1];
        [incomeMutArr addObject:incomeArr[i]];
    }
    return incomeMutArr;
}
- (void)setDataIsForceInit:(BOOL)isForceInit{
    if (isForceInit) {
        
        UserInfoModel *userInfoModel = [UserInfoSingleton sharedUserInfoContext].userInfo;
        userInfoModel.tagArrs = @[];
        userInfoModel.currentDay = [NSString currentDataStringWithFormatString:[NSString ymdSeparatedByPointFormatString]];
        
        
        
        [UserInfoManager SetNSUserDefaults:userInfoModel];
        
    }else{
        if (![UserInfoManager GetNSUserDefaults].tagArrs) {
            UserInfoModel *userInfoModel = [UserInfoSingleton sharedUserInfoContext].userInfo;
            userInfoModel.tagArrs = @[];
            userInfoModel.currentDay = [NSString currentDataStringWithFormatString:[NSString ymdSeparatedByPointFormatString]];
            
            
            
            [UserInfoManager SetNSUserDefaults:userInfoModel];
        }
    }
}
@end
