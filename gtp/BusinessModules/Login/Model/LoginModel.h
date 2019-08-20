//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LoginData : NSObject
@property (nonatomic, strong) NSString * userid;
@property (nonatomic, strong) NSString * realname;
@property (nonatomic, strong) NSString * istrpwd;
@property (nonatomic, strong) NSString * valiidnumber;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * safeverifyswitch;
@property (nonatomic, strong) NSString * googlesecret;
@property (nonatomic, strong) NSString * valigooglesecret;

@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * userType;
@end


@interface LoginModel : NSObject
@property (nonatomic, copy) NSString*  servertime;
@property (nonatomic, copy) NSString*  loginname;
@property (nonatomic, strong) LoginData * userinfo;
@property (nonatomic, copy) NSString*  errcode;
@property (nonatomic, copy) NSString*  msg;

@end
