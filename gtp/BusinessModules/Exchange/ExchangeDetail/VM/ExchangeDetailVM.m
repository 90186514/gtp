//
//  YBHomeDataCenter.m
//  YBArchitectureDemo
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "ExchangeDetailVM.h"

@interface ExchangeDetailVM()
@property (strong,nonatomic)NSMutableArray   *listData;
@property (strong,nonatomic)NSArray* gridSectionNames;
@property (nonatomic,strong) ExchangeModel* model;
@end

@implementation ExchangeDetailVM

- (void)network_getExchangeDetailListWithPage:(NSInteger)page WithRequestParams:(id)requestParams success:(void (^)(NSArray * _Nonnull))success failed:(void (^)(void))failed {
    
    _listData = [NSMutableArray array];
    
    
    
//    NSString* v =  [YBSystemTool appVersion];
//    NSString* s =  [YBSystemTool appSource];
//    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    
    WS(weakSelf);
//    [[YTSharednetManager sharedNetManager]getNetInfoWithUrl:API_HOMES andType:All andWith:@{@"version":v,@"source":s} andReturn:^(NSDictionary *dic) {
//        NSDictionary* result = dic[@"result"];
//        if ([NSString getDataSuccessed:result]) {
//            weakSelf.model = [PostAdsModel mj_objectWithKeyValues:dic];
            [self assembleApiData:weakSelf.model];
            success(weakSelf.listData);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeModelReturn" object:nil];
//        }
//        else{
//            NSLog(@".......tttttt");
//        }
//        [SVProgressHUD dismiss];
//    }];
}

- (void)assembleApiData:(ExchangeModel*)data{
    [self removeContentWithType:IndexSectionZero];
    NSDictionary* dic0 = @{kImg:@"iconSucc",kTit:@"对方已确认付款",kSubTit:[NSString stringWithFormat:@"%@",@"请确认收到款项后再放行"], kIndexInfo:@{kType:@(ExchangeTypePayed),kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响卖家信誉"]},kIndexSection:@(IndexSectionZero),
                           kIndexRow:
                               @[
                                   @{@"兑换币种：":@"AB/BTC"},
                                   @{@"汇率：":@"1 AB = 0.000001 BTC"},
                                   @{@"兑换数量：":@"100 AB"},
                                   @{@"收到BTC数量：":@"0.003 BTC"}
                                   ]
                           
                           };
    [self.listData addObject:dic0];
    
    [self removeContentWithType:IndexSectionOne];
    NSDictionary* dic1 = @{kImg:@"iconSucc",kTit:@"对方已确认付款",kSubTit:[NSString stringWithFormat:@"%@",@"请确认收到款项后再放行"], kIndexInfo:@{kType:@(ExchangeTypePayed),kTit:[NSString stringWithFormat:@"%@",@"Txid："],kSubTit:[NSString stringWithFormat:@"%@",@"49tojh49GHTGloinadkjsuiyghajskdgh0-0q3894t6"]},kIndexSection:@(IndexSectionOne),
                           kIndexRow:
                               @[
                                   @{@"提交时间：":@"2018-10-19 12:00:12"},
                                   @{@"兑换状态：":@"已汇出"},
                                   @{@"BTC收币地址：":@"11dgadjg38509HFli"},
                                   
                                   ]
                           
                           };
    
    [self.listData addObject:dic1];
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
