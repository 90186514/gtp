//
//  PageVM.m
//  YBArchitectureDemo
//
//  Created by WIQ on 2018/11/19.
//  Copyright © 2018 WIQ. All rights reserved.
//

#import "OrdersPageVM.h"
#import "OrdersPageModel.h"
@interface OrdersPageVM()
@property (strong,nonatomic)NSMutableArray   *listData;
@property (strong,nonatomic)NSArray* gridSectionNames;
@property (nonatomic,strong) OrdersPageModel* model;
@end

@implementation OrdersPageVM
- (void)network_getOrdersPageListWithPage:(NSInteger)page success:(void (^)(NSArray * _Nonnull))success failed:(void (^)(void))failed {
    
    _listData = [NSMutableArray array];
    
//    NSString* v =  [YBSystemTool appVersion];
//    NSString* s =  [YBSystemTool appSource];
//    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
//
//
    WS(weakSelf);
//    [[YTSharednetManager sharedNetManager]getNetInfoWithUrl:API_HOMES andType:All andWith:@{@"version":v,@"source":s} andReturn:^(NSDictionary *dic) {
//        NSDictionary* result = dic[@"result"];
//        if ([NSString getDataSuccessed:result]) {
//            weakSelf.model = [OrdersPageModel mj_objectWithKeyValues:dic];
            [self assembleApiData:weakSelf.model.result.data];
            success(weakSelf.listData);
//        }
//        [SVProgressHUD dismiss];
//    }];
}

- (void)assembleApiData:(OrdersPageData*)data{
//    if (data.b !=nil && data.b.count>0) {
//        [data.b enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            OrdersPageItem* item = obj;
//            [self.listData addObject:@[item]];
//        }];
////        [self.listData addObjectsFromArray:data.b];
//    }
    NSDictionary* dic0 = @{kType:@(OrderTypeFinished),kImg:@"iconSucc",kTit:@"对方已好了靓靓🐟",kSubTit:[NSString stringWithFormat:@"%@",@"已完成"], kIndexSection:@{kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响SL家信誉"]},
                           kIndexRow:
                               @[
                                   @{@"🌹号：":@"498653498670"},
                                   @{@"🌹TUMO：":@"5900"},
                                   @{@"暨起：":@"100 KKL = 1 AB"},
                                   @{@"数量：":@"590 AB"},
                                   @{@"🌹时间：":@"2018-10-19 12:00:12"}
                                   ]
                           
                           };
    NSDictionary* dic1 = @{kType:@(OrderTypeWaitPay),kImg:@"iconSucc",kTit:@"对方已好了靓靓🐟",kSubTit:[NSString stringWithFormat:@"%@",@"等待可可方靓靓🐟"], kIndexSection:@{kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响SL家信誉"]},
                           kIndexRow:
                               @[
                                   @{@"🌹号：":@"498653498670"},
                                   @{@"🌹TUMO：":@"5900"},
                                   @{@"暨起：":@"100 KKL = 1 AB"},
                                   @{@"数量：":@"590 AB"},
                                   @{@"🌹时间：":@"2018-10-19 12:00:12"}
                                   ]
                           
                           };
    NSDictionary* dic2 = @{kType:@(OrderTypeCancel),kImg:@"iconSucc",kTit:@"对方已好了靓靓🐟",kSubTit:[NSString stringWithFormat:@"%@",@"已取消"], kIndexSection:@{kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响SL家信誉"]},
                           kIndexRow:
                               @[
                                   @{@"🌹号：":@"498653498670"},
                                   @{@"🌹TUMO：":@"5900"},
                                   @{@"暨起：":@"100 KKL = 1 AB"},
                                   @{@"数量：":@"590 AB"},
                                   @{@"🌹时间：":@"2018-10-19 12:00:12"}
                                   ]
                           
                           };
    
    NSDictionary* dic3 = @{kType:@(OrderTypeWaitDistribute),kImg:@"iconSucc",kTit:@"对方已好了靓靓🐟",kSubTit:[NSString stringWithFormat:@"%@",@"待symbolic"], kIndexSection:@{kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响SL家信誉"]},
                           kIndexRow:
                               @[
                                   @{@"🌹号：":@"498653498670"},
                                   @{@"🌹TUMO：":@"5900"},
                                   @{@"暨起：":@"100 KKL = 1 AB"},
                                   @{@"数量：":@"590 AB"},
                                   @{@"🌹时间：":@"2018-10-19 12:00:12"}
                                   ]
                           
                           };
    NSDictionary* dic4 = @{kType:@(OrderTypeAppeal),kImg:@"iconSucc",kTit:@"对方已好了靓靓🐟",kSubTit:[NSString stringWithFormat:@"%@",@"等待可可方靓靓🐟"], kIndexSection:@{kTit:[NSString stringWithFormat:@"%@",@"00:30"],kSubTit:[NSString stringWithFormat:@"%@",@"请在 15 分钟内处理，超时将影响SL家信誉"]},
                           kIndexRow:
                               @[
                                   @{@"🌹号：":@"498653498670"},
                                   @{@"🌹TUMO：":@"5900"},
                                   @{@"暨起：":@"100 KKL = 1 AB"},
                                   @{@"数量：":@"590 AB"},
                                   @{@"🌹时间：":@"2018-10-19 12:00:12"}
                                   ]
                           
                           };
    [self.listData addObjectsFromArray:@[@[dic0],@[dic1],@[dic2],@[dic3],@[dic4]]];
}
@end
