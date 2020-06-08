//
//  HomeModel.h
//  LiNiuYang
//
//  Created by WER on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockInModel : NSObject
- (NSMutableArray*)setFilteredData:(NSMutableArray*)outcomeMutArr withSameKey:(NSString*)sameKey;
- (NSMutableArray*)getClickInStatusData;
- (NSMutableArray*)getFlags;
- (void)setDataIsForceInit:(BOOL)isForceInit;

@end
