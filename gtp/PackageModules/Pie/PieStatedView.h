//
//  PieStatedView.h
//  gtp
//
//  Created by Oma on 2018/12/30.
//  Copyright © 2018 GT. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PieView.h"

@interface PieStatedView : UIView
- (void)richEleInView:(id)model;
- (instancetype)initWithFrame:(CGRect)frame withModels:(NSArray <PieModel*>*)ary;


@end
