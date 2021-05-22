//
//  YBHomeDataCenter.m
//  YBArchitectureDemo
//
//  Created by WIQ on 2018/11/19.
//  Copyright © 2018 WIQ. All rights reserved.
//

#import "HomeVM.h"

@interface HomeVM()
@property (strong,nonatomic)NSMutableArray   *listData;
@property (nonatomic,strong) NSMutableArray* footerArr;
@property (nonatomic,strong) HomeModel* model;
@end

@implementation HomeVM
- (void)network_getTrendsListWithPage:(NSInteger)page success:(void (^)(NSArray * _Nonnull))success failed:(void (^)(void))failed {
    
    _listData = [NSMutableArray array];
    
    NSArray* gridSectionNames = @[@"Location",@"Quickening",@"CircleAnimation",@"TagRun",@"ModelFilter",@"WKPopUpView",@"AppListInfo"];
    NSMutableArray* gridParams = [NSMutableArray array];
    
    for (int i=0; i<gridSectionNames.count; i++) {
        
        NSDictionary * param = @{kArr:gridSectionNames[i],
                                 kImg:[NSString stringWithFormat:@"home_grid_%i",i],
                                 kUrl:@""};
        [gridParams addObject:param];
    }
    
    [self removeContentWithType:IndexSectionTwo];
    [self.listData addObject: gridParams];
    success(self.listData);
//    NSString* v =  [YBSystemTool appVersion];
//    NSString* s =  [YBSystemTool appSource];
//    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
//    
//    
//    WS(weakSelf);
//    [[YTSharednetManager sharedNetManager]getNetInfoWithUrl:API_HOMES andType:All andWith:@{@"version":v,@"source":s} andReturn:^(NSDictionary *dic) {
//        NSDictionary* result = dic[@"result"];
//        if ([NSString getDataSuccessed:result]) {
//            weakSelf.model = [HomeModel mj_objectWithKeyValues:dic];
//            [self assembleApiData:weakSelf.model.result.data];
//            success(weakSelf.listData);
//        }
//        [SVProgressHUD dismiss];
//    }];
}

- (void)network_getHomeListWithPage:(NSInteger)page success:(void (^)(NSArray * _Nonnull,NSArray * _Nonnull))success failed:(DataBlock)failed {
    
    _listData = [NSMutableArray array];
    if (page ==1) {
        _footerArr = [NSMutableArray array];
    }
    
    
    NSString* v =  [YBSystemTool appVersion];
    NSString* s =  [YBSystemTool appSource];
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    
    WS(weakSelf);
    [[YTSharednetManager sharedNetManager]getNetInfoWithUrl:[ApiConfig getAppApi:ApiType_Homes] andType:LNService andWith:@{@"version":v,@"source":s} andReturn:^(NSDictionary *dic) {
        NSDictionary* result = dic[@"result"];
        if ([NSString getLNDataSuccessed:result]) {
            weakSelf.model = [HomeModel mj_objectWithKeyValues:dic];
            [self assembleApiData:weakSelf.model.result.data WithPage:page];
            success(weakSelf.listData,weakSelf.model.result.data.returnData.rankinglist);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeModelReturn" object:nil];
        }
        else{
            NSLog(@".......netErr");
            failed(@"netErr");
        }
        [SVProgressHUD dismiss];
    }];
}

- (void)assembleApiData:(HomeData*)data WithPage:(NSInteger)page{
    if (page ==3) {
        return;
    }
    [self removeContentWithType:IndexSectionZero];
//    if (data.returnData !=nil && data.returnData.rankinglist.count>0 &&page==1) {
        [self.listData addObject:@{
                   kIndexSection: @(IndexSectionZero),
                   kIndexRow: @[data.returnData]}];
//    }
    
    [self removeContentWithType:IndexSectionOne];
    NSArray* gridSectionNames = @[@"SLMIA",@"我的🌹",@"数据统计",@"哥哥MIA",@"🐟"];//,@"🐟"
    NSMutableArray* gridParams = [NSMutableArray array];
    NSArray* gridTypes = @[@(EnumActionTag0),@(EnumActionTag1),@(EnumActionTag2),@(EnumActionTag3),@(EnumActionTag4)];//,@(IndexSectionFour)
    for (int i=0; i<gridSectionNames.count; i++) {
        NSDictionary * param = @{kArr:gridSectionNames[i],
                                 kImg:[NSString stringWithFormat:@"home_grid_%i",i],
                                 kType:gridTypes[i]
                                 };
        [gridParams addObject:param];
    }
//    if (page==1){
        [self.listData addObject:@{kIndexSection: @(IndexSectionOne),
                                   
                                   kIndexRow: @[gridParams]}];
//    }
    
    [self removeContentWithType:IndexSectionTwo];
    
    if (data.returnData !=nil && data.returnData.rankinglist.count>0 ) {
        NSMutableArray *times = [NSMutableArray arrayWithCapacity:20];
        for (NSInteger i = 0; i < data.returnData.rankinglist.count; i ++) {
            NSInteger time = arc4random()%3600;
            [times addObject:@(time)];
        }
        [_footerArr addObjectsFromArray:times];//拼接接口分页数据=data.returnData.rankinglist
    }
    [self.listData addObject:@{
            
            kIndexSection: @(IndexSectionTwo),
            kIndexInfo:@[@"待处理🌹",@"icon_bank"],
            kIndexRow: _footerArr}//data.t.arr
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
