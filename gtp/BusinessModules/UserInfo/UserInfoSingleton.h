//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface UserInfoSingleton : NSObject
@property(nonatomic,strong) UserInfoModel *userInfo;
+(UserInfoSingleton*)sharedUserInfoContext;
@end
