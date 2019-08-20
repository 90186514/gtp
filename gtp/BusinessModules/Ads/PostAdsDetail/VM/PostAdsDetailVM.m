//
//  YBHomeDataCenter.m
//  YBArchitectureDemo
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "PostAdsDetailVM.h"

@interface PostAdsDetailVM()
@property (strong,nonatomic)NSMutableArray   *listData;

@property (nonatomic,strong) PostAdsDetailModel* model;
@end

@implementation PostAdsDetailVM

- (void)network_getPostAdsDetailListWithPage:(NSInteger)page success:(void (^)(NSArray * _Nonnull))success failed:(void (^)(void))failed {
    
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

- (void)assembleApiData:(PostAdsDetailData*)data{
    NSDictionary* dic1 = @{kType:@(PostAdsDetailTypeSuccess),kImg:@"iconSucc",kTit:@"发布成功",kSubTit:[NSString stringWithFormat:@"%@",@"请确认收到款项后再放行"], kIndexSection:@{kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响卖家信誉"]},
                           kIndexRow:
                               @[
                                   @{@"币种：":@"UG"},
                                   @{@"数量：":@"590 AB"},
                                   @{@"单价：":@"100 CNY = 1 AB"},
                                   @{@"首款方式：":@"支付宝"},
                                   @{@"单笔限额：":@"1000～23000"}
                                   ]
                           };
    
    
    [self.listData addObjectsFromArray:@[dic1]];
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
