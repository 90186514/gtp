//
//  HomeModel.h
//  LiNiuYang
//
//  Created by WIQ on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "UserInfoSingleton.h"
@interface UserInfoManager : NSObject
+(void)SetNSUserDefaults:(UserInfoModel *)userInfo;
+(UserInfoModel *)GetNSUserDefaults;
+(void)DeleteNSUserDefaults;
@end
