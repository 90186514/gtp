//
//  PHTagView.h
//  TagUtilViews
//
//  Created by AaltoChen on 16/8/23.
//  Copyright © 2016年 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "PHLockClick.h"
@interface PHRectTagView : UIView
@property (nonatomic,strong) PHLockClick *aLockList;
+(UIView *)creatBtnWithFrame:(CGRect)frame isFixedBtnWidth:(BOOL)isFixed withTitleArray:(NSArray*)titleArray;
- (instancetype)initBtnWithFrame:(CGRect)frame isFixedBtnWidth:(BOOL)isFixed withTitleArray:(NSArray*)titleArray;
@property (nonatomic, strong) NSMutableArray *btns;

@property (copy, nonatomic) void(^clickSectionBlock)(NSInteger sec, NSString* btnTit);
@end
