//
//  AccountTagView.h
//  gtp
//
//  Created by Lino on 14/05/2020.
//  Copyright © 2020 gtp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountPayView : UIView

- (void)actionBlock:(ActionBlock)block;
+ (CGFloat)cellHeightWithModel;
- (void)richElementsInCellWithModel:(NSArray*)model;
- (void)showInView:(UIView *)contentView;
- (void)disMissView;
@end
