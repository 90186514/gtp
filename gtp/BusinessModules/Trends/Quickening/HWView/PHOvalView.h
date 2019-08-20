//
//  PHOvalView.h
//  TagUtilViews
//
//  Created by AaltoChen on 16/8/26.
//  Copyright © 2016年 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "StyleKitName.h"
@interface PHOvalView : UIView
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) UIBezierPath *circleSmallPath;
@end
