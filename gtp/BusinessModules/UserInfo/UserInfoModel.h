//
//  HomeModel.h
//  LiNiuYang
//
//  Created by WIQ on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject<NSCoding>
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,copy) NSString *paySource;
@property (nonatomic,copy) NSArray *tagArrs;
@property (nonatomic,copy) NSString *currentDay;
@property (nonatomic,copy) NSDate *recordedDate;
@property (nonatomic,copy) NSArray *purseArr;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *cookie;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,copy) NSString *deviceid;
@end
