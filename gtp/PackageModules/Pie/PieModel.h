//
//  PieModel.h
//  gtp
//
//  Created by Oma on 2018/12/30.
//  Copyright © 2018 GT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PieModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *descript;
@property (nonatomic,assign)CGFloat count;
@property (nonatomic,assign)CGFloat percent;
@property (nonatomic,strong)UIColor *color;
@end
