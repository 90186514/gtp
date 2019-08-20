//
//  ModelFilter.h
//  TagUtilViews
//
//  Created by Aalto on 2017/4/22.
//  Copyright © 2017年 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelFilter : NSObject
- (void)filteredSameStringAndAssembleDifferentStringToIndividualArray;
- (void)setFilteredLastStringForSameKey;
- (void)setFilteredAndDescendingSameStringToArrForSameKey;
- (NSInteger) binarySearchArray:(NSArray*)levelActivities withSelectedAmt:(NSInteger)selectedAmt;
@end
