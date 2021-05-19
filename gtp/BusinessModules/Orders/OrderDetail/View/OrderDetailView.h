//
//  PostAdsView.h
//  gtp
//
//  Created by WIQ on 2018/12/23.
//  Copyright © 2018 WIQ. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class OrderDetailView;

@protocol OrderDetailViewDelegate <NSObject>

@required

- (void)orderDetailView:(OrderDetailView *)view requestListWithPage:(NSInteger)page;

@end

@interface OrderDetailView : UIView

@property (nonatomic, weak) id<OrderDetailViewDelegate> delegate;

- (void)requestListSuccessWithArray:(NSArray *)array;

- (void)requestListFailed;
- (void)actionBlock:(TwoDataBlock)block;
@end

NS_ASSUME_NONNULL_END
