//
//  TreasureBoxCell.h
//  SegmentController
//
//  Created by Aalto on 14-6-7.
//  Copyright (c) 2014年 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLSwitch.h"
@interface ACell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UIImageView *imgv_icon;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgv_accessory;

@property(nonatomic,strong)KLSwitch *switchView;

@end
