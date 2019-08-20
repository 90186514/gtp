//
//  MasterETVCell.h
//  TestDemo
//
//  Created by AaltoChen on 16/3/1.
//  Copyright © 2016年 AaltoChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterETVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)itsCellWithTableView:(UITableView *)tableView;
- (void)richElementsInCellWithListData:(NSString*)listModel;
@end
