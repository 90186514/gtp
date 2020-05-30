//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountingModel : NSObject
- (NSMutableArray*)getAccountingAssembledData:(NSArray*)originArr selectedType:(AccountingSelectedType)selectedType withDistinction:(AccountingDistinctionType)distinctionType
withDistinctionTime:(NSString*)distinctionTime withDistinctionBalanceSource:(NSString*)distinctionBalanceSource;

- (NSMutableArray*)getAccountingTagDataWithSelectedType:(AccountingSelectedType)selectedType;


- (NSMutableArray*)getAccountingPayData;

- (void)setAccountingDataIsForceInit:(BOOL)isForceInit;

@end
