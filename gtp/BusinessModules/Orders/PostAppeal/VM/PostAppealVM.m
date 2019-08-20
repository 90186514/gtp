//
//  YBHomeDataCenter.m
//  YBArchitectureDemo
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "PostAppealVM.h"

@interface PostAppealVM()
@property (strong,nonatomic)NSMutableArray   *listData;

@property (nonatomic,strong) PostAppealModel* model;
@property (nonatomic, strong) id requestParams;
@end

@implementation PostAppealVM

- (void)network_getPostAppealListWithPage:(NSInteger)page WithRequestParams:(id)requestParams success:(void (^)(NSArray * _Nonnull))success failed:(void (^)(void))failed {
    self.requestParams = requestParams;
    _listData = [NSMutableArray array];
    
    
    
    
//    NSString* v =  [YBSystemTool appVersion];
//    NSString* s =  [YBSystemTool appSource];
//    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    
    WS(weakSelf);
//    [[YTSharednetManager sharedNetManager]getNetInfoWithUrl:API_HOMES andType:All andWith:@{@"version":v,@"source":s} andReturn:^(NSDictionary *dic) {
//        NSDictionary* result = dic[@"result"];
//        if ([NSString getDataSuccessed:result]) {
//            weakSelf.model = [PostAdsModel mj_objectWithKeyValues:dic];
            [self assembleApiData:weakSelf.model.result.data];
            success(weakSelf.listData);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeModelReturn" object:nil];
//        }
//        else{
//            NSLog(@".......tttttt");
//        }
//        [SVProgressHUD dismiss];
//    }];
}

- (void)assembleApiData:(PostAppealData*)data{
    [self removeContentWithType:IndexSectionZero];
//    if (data.r !=nil && data.r.arr.count>0) {
        [self.listData addObject:@{
                   kIndexSection: @(IndexSectionZero),
                   kIndexRow: @[@{kTit:@"5896092390458",
                                  kArr:@[@"已付款，商户未及时放行",@"尚未收到款",@"收款账号和用户实名信息不符",@"其他"]}]}];//@[data.r]//test 从self.requestParams取orderNum
//    }
    
    
    [self removeContentWithType:IndexSectionOne];
    
    [self.listData addObject:@{
                                   
                           kIndexSection: @(IndexSectionOne),
                           kIndexInfo:@[@"备注",@""],
                           kIndexRow: @[@{kTit:@"填写更多信息"}]}//data.t.arr
    ];
    
    
    [self sortData];
}
- (void)sortData {
    [self.listData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *number1 = [NSNumber numberWithInteger:[[obj1 objectForKey:kIndexSection] integerValue]];
        NSNumber *number2 = [NSNumber numberWithInteger:[[obj2 objectForKey:kIndexSection] integerValue]];
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending;
    }];
}

- (void)removeContentWithType:(IndexSectionType)type {
    [self.listData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        IndexSectionType contentType = [[(NSDictionary *)obj objectForKey:kIndexSection] integerValue];
        if (contentType == type) {
            *stop = YES;
            [self.listData removeObject:obj];
        }
    }];
}

@end
