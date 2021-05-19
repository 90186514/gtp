//
//  SPCell.h
//  LiNiuYang
//
//  Created by WIQ on 2017/7/25.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WItem;
@interface AccountCell : UITableViewCell
@property (copy, nonatomic) void(^clickPButtonBlock)(WItem* item);
+(CGFloat)cellHeightWithModel;
+(instancetype)cellWith:(UITableView*)tabelView;
- (void)richElementsInCellWithModel:(NSArray*)model;
@end
