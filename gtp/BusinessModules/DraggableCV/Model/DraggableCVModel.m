//
//  DraggableCVModel.m


#import "DraggableCVModel.h"

@implementation DraggableCVModel
- (BOOL)compareOriginData:(NSMutableArray*)oldArr withNewData:(NSMutableArray*)newArr{
    bool bol = false;
    
    //创建俩新的数组
    
    //对array1排序。
    [oldArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){return [obj1 localizedStandardCompare: obj2];}];
  
    //对array2排序。
////    [newArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){return [obj1 localizedStandardCompare: obj2];}];

    
    if (newArr.count == oldArr.count) {
        
        bol = true;
        for (int i = 0; i < oldArr.count; i++) {
            
            id c1 = [oldArr objectAtIndex:i];
            id newc = [newArr objectAtIndex:i];
            
            if (![newc isEqualToString:c1]) {
                bol = false;
                break;
            }
        }
    }
    return bol;
}

- (NSMutableDictionary*)getMazeDatasByX:(NSInteger)x byY:(NSInteger)y{
     NSMutableArray* sections = [NSMutableArray array];
    //    for(int s = 0; s < 3; s++) {
    //        NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:6];
    //        for(int i = 0; i < 6; i++) {
    //            [data addObject:[NSString stringWithFormat:@"%c %@", 65+s, @(i)]];
    //        }
    //        [sections addObject:data];
    //    }
    //
        NSMutableArray* originArr = [NSMutableArray array];
        for (int i=1; i<x*y +1; i++) {
            [originArr addObject:[NSString stringWithFormat:@"%li",(long)i]];
        }
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        NSInteger i;
        NSInteger count = originArr.count;
        for (i = 0; i < count; i ++) {
            int index = arc4random() % (count - i);
            [resultArray addObject:[originArr objectAtIndex:index]];
            [originArr removeObjectAtIndex:index];
            
        }
        [sections  addObjectsFromArray:resultArray];
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:@{kArr:sections}];
    [dic addEntriesFromDictionary:@{kIndexRow:@(x)}];
    [dic addEntriesFromDictionary:@{kIndexSection:@(y)}];
    return dic;
}

- (void)setDataIsForceInit:(BOOL)isForceInit{
    if (isForceInit) {
        
        UserInfoModel *userInfoModel = [UserInfoSingleton sharedUserInfoContext].userInfo;
        userInfoModel.recordedDate = nil;
        [UserInfoManager SetNSUserDefaults:userInfoModel];
        
    }else{
        if (![UserInfoManager GetNSUserDefaults].recordedDate) {
            UserInfoModel *userInfoModel = [UserInfoSingleton sharedUserInfoContext].userInfo;
            userInfoModel.recordedDate = [NSDate date];
            
            [UserInfoManager SetNSUserDefaults:userInfoModel];
        }
    }
}

@end
