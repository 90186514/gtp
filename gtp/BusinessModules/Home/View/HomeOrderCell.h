//
//  SPCell.h
//  LiNiuYang
//
//  Created by Aalto on 2017/7/25.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WItem;
@interface HomeOrderCell : UITableViewCell
@property (copy, nonatomic) void(^clickPButtonBlock)(WItem* item);
+(CGFloat)cellHeightWithModel:(NSInteger)second;
+(instancetype)cellWith:(UITableView*)tabelView;
- (void)richElementsInCellWithModel:(NSInteger)second;
@end
