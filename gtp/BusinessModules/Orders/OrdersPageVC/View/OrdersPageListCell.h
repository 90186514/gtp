//
//  SPCell.h
//  LiNiuYang
//
//  Created by WIQ on 2017/7/25.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrdersPageItem;
@interface OrdersPageListCell : UITableViewCell
- (void)actionBlock:(ActionBlock)block;
+(CGFloat)cellHeightWithModel:(id)model;
+(instancetype)cellWith:(UITableView*)tabelView;
- (void)richElementsInCellWithModel:(id)model;
@end
