//
//  Master4ViewController.h
//  SegmentController
//
//  Created by Aalto on 14-6-13.
//  Copyright (c) 2014年 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNExpandingButtonBar.h"
#import "AwesomeMenu.h"
#import "RichTextAdjustVC.h"
#import "RichTextAdjustTableVC.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CircleAnimationVC : UIViewController
-(void)createAwesomeMenu;
- (void) onNext;
- (void) onAlert;
- (void) onModal;
+ (instancetype)pushFromVC:(UIViewController *)rootVC;

@end
