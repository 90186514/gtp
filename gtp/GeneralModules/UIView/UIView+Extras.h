//
//  UIView+Extension.h
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extras)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
- (void)gradientLayerAboveView:(UIView*)view withShallowColor:(UIColor*)shallowC withDeepColor:(UIColor*)deepC isVerticalOrHorizontal:(BOOL)isVertical;
-(void)removeAllSubViews;
@end
