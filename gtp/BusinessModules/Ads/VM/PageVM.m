//
//  PageVM.m
//  YBArchitectureDemo
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "PageVM.h"
@interface PageVM()
@property (strong,nonatomic)NSMutableArray   *listData;
@property (strong,nonatomic)NSArray* gridSectionNames;
@property (nonatomic,strong) PageModel* model;
@end

@implementation PageVM
- (void)network_getPageListWithPage:(NSInteger)page success:(void (^)(NSArray * _Nonnull))success failed:(void (^)(void))failed {
    
    _listData = [NSMutableArray array];
    
    NSString* v =  [YBSystemTool appVersion];
    NSString* s =  [YBSystemTool appSource];
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    
    WS(weakSelf);
    [[YTSharednetManager sharedNetManager]getNetInfoWithUrl:[ApiConfig getAppApi:ApiType_Homes] andType:LNService andWith:@{@"version":v,@"source":s} andReturn:^(NSDictionary *dic) {
        NSDictionary* result = dic[@"result"];
        if ([NSString getLNDataSuccessed:result]) {
            weakSelf.model = [PageModel mj_objectWithKeyValues:dic];
            [self assembleApiData:weakSelf.model.result.data];
            success(weakSelf.listData);
        }
        [SVProgressHUD dismiss];
    }];
}

- (void)assembleApiData:(PageData*)data{
    if (data.b !=nil && data.b.count>0) {
        [data.b enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PageItem* item = obj;
            [self.listData addObject:@[item]];
        }];
//        [self.listData addObjectsFromArray:data.b];
    }
}
@end
