//
//  YBHomeDataCenter.m
//  YBArchitectureDemo
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "LoginVM.h"

@interface LoginVM()
@property (strong,nonatomic)NSMutableArray   *listData;

@property (nonatomic,strong) LoginModel* model;
@property (nonatomic, strong) NSDictionary* requestParams;
@end

@implementation LoginVM

- (void)network_getLoginWithRequestParams:(id)requestParams success:(DataBlock)success failed:(DataBlock)failed error:(DataBlock)err {
    self.requestParams = requestParams;
    _listData = [NSMutableArray array];
    
    NSString* n =  self.requestParams.allKeys[0];
    NSString* p =  self.requestParams.allValues[0];
    NSDictionary* proDic =@{@"loginname":n,@"pwd":p};
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    WS(weakSelf);
    [[YTSharednetManager sharedNetManager]postNetInfoWithUrl:[ApiConfig getAppApi:ApiType_Login] andType:All andWith:proDic success:^(NSDictionary *dic) {
        self.model = [LoginModel mj_objectWithKeyValues:dic];
        if ([NSString getDataSuccessed:dic]) {
            success(weakSelf.model);
        }
        else{
            failed(weakSelf.model);
        }
        [YKToastView showToastText:self.model.msg];
        
    } error:^(NSError *error) {
        err(error);
        [YKToastView showToastText:error.description];
    }];
    [SVProgressHUD dismiss];
}
@end
