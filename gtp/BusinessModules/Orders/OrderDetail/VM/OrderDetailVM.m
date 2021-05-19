//
//  YBHomeDataCenter.m
//  YBArchitectureDemo
//
//  Created by WIQ on 2018/11/19.
//  Copyright © 2018 WIQ. All rights reserved.
//

#import "OrderDetailVM.h"

@interface OrderDetailVM()
@property (strong,nonatomic)NSMutableArray   *listData;
@property (strong,nonatomic)NSArray* gridSectionNames;
@property (nonatomic,strong) OrderDetailModel* model;
@end

@implementation OrderDetailVM

- (void)network_getOrderDetailListWithPage:(NSInteger)page WithRequestParams:(id)requestParams success:(void (^)(NSArray * _Nonnull))success failed:(void (^)(void))failed {
    
    _listData = [NSMutableArray array];
    
    
    
//    NSString* v =  [YBSystemTool appVersion];
//    NSString* s =  [YBSystemTool appSource];
//    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    
    WS(weakSelf);
//    [[YTSharednetManager sharedNetManager]getNetInfoWithUrl:API_HOMES andType:All andWith:@{@"version":v,@"source":s} andReturn:^(NSDictionary *dic) {
//        NSDictionary* result = dic[@"result"];
//        if ([NSString getDataSuccessed:result]) {
//            weakSelf.model = [PostAdsModel mj_objectWithKeyValues:dic];
    [self assembleApiData:requestParams];//test
//            [self assembleApiData:weakSelf.model.result.data];
            success(weakSelf.listData);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeModelReturn" object:nil];
//        }
//        else{
//            NSLog(@".......tttttt");
//        }
//        [SVProgressHUD dismiss];
//    }];
}

- (void)assembleApiData:(NSDictionary*)data{//OrderDetailData*
    NSDictionary* dic1 = @{kType:@([data[kType] integerValue]),kImg:@"iconSucc",kTit:@"对方已好了靓靓🐟",kSubTit:[NSString stringWithFormat:@"%@",@"请好了收到🐟项后再symbolic"], kIndexSection:@{kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响SL家信誉"]},
                           kIndexRow:
                               @[
                                   @{@"🌹号：":@"498653498670"},
                                   @{@"🌹TUMO：":@"85900"},
                                   @{@"暨起：":@"100 KKL = 1 AB"},
                                   @{@"数量：":@"590 AB"},
                                   @{@"🌹时间：":@"2018-10-19 12:00:12"}
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
