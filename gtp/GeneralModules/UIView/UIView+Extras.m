//
//  UIView+Extension.m
//  MJRefreshExample
//
//  Created by WIQ on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIView+Extras.h"

static const void *leftLittleButtonEventBlockKey = &leftLittleButtonEventBlockKey;
static const void *leftButtonEventBlockKey = &leftButtonEventBlockKey;
static const void *rightButtonEventBlockKey = &rightButtonEventBlockKey;

static const void *funcBtnsKey = &funcBtnsKey;

@implementation UIView (Extras)
/*
 objc_AssociationPolicy参数使用的策略：
 OBJC_ASSOCIATION_ASSIGN;            //assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
 
 OBJC_ASSOCIATION_RETAIN;
 OBJC_ASSOCIATION_COPY;
 */

- (ActionBlock)leftLittleButtonEventBlock {
    return objc_getAssociatedObject(self, leftLittleButtonEventBlockKey);
}

- (void)setLeftLittleButtonEventBlock:(ActionBlock)leftLittleButtonEventBlock {
    objc_setAssociatedObject(self, leftLittleButtonEventBlockKey, leftLittleButtonEventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ActionBlock)leftButtonEventBlock {
    return objc_getAssociatedObject(self, leftButtonEventBlockKey);
}

- (void)setLeftButtonEventBlock:(ActionBlock)leftButtonEventBlock {
    objc_setAssociatedObject(self, leftButtonEventBlockKey, leftButtonEventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (ActionBlock)rightButtonEventBlock {
    return objc_getAssociatedObject(self, rightButtonEventBlockKey);
}

- (void)setRightButtonEventBlock:(ActionBlock)rightButtonEventBlock {
    objc_setAssociatedObject(self, rightButtonEventBlockKey, rightButtonEventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray*)funcBtns {
    return objc_getAssociatedObject(self, funcBtnsKey);
}

- (void)setFuncBtns:(NSMutableArray*)funcBtns {
    objc_setAssociatedObject(self, funcBtnsKey, funcBtns, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(void)removeAllSubViews{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}

- (void)gradientLayerAboveView:(UIView*)view withShallowColor:(UIColor*)shallowC withDeepColor:(UIColor*)deepC isVerticalOrHorizontal:(BOOL)isVertical{
    CAGradientLayer *gradientLayer  = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    if (isVertical){
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }else{
        gradientLayer.startPoint = CGPointMake(0, .5);
        gradientLayer.endPoint = CGPointMake(1, .5);
    }
    gradientLayer.colors = @[(id)shallowC.CGColor, (id)deepC.CGColor];
    gradientLayer.locations = @[@(0.5f) ,@(1.0f)];
    [view.layer insertSublayer:gradientLayer atIndex:0];
    view.layer.masksToBounds = YES;
}

//runtime 底部功能键
- (void)loginRightButtonInSuperView:(UIView*)superView withTitle:(NSString*)title rightButtonEvent:(ActionBlock)rightButtonEventBlock{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.tag = EnumActionTag1;
    [superView addSubview:leftButton];
    
//    [leftButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    [leftButton setTitle:title forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = YES;
    leftButton.titleLabel.font  = kFontSize(17);
    [leftButton setTitleColor:kWhiteColor forState:UIControlStateNormal] ;
    leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [leftButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(MAINSCREEN_WIDTH-95, 0, MAINSCREEN_WIDTH/2, 54+2*36);
//    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:9];
    self.rightButtonEventBlock = rightButtonEventBlock;
}
- (void)goBackButtonInSuperView:(UIView*)superView leftButtonEvent:(ActionBlock)leftButtonEventBlock{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [superView addSubview:leftButton];
    
    [leftButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = YES;
    leftButton.titleLabel.font  = kFontSize(17);
    [leftButton setTitleColor:kWhiteColor forState:UIControlStateNormal] ;
    leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [leftButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(25, 0, MAINSCREEN_WIDTH/2-25, 54+2*36);
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:9];
    self.leftButtonEventBlock = leftButtonEventBlock;
}

- (void)goBackBlackButtonInSuperView:(UIView*)superView leftButtonEvent:(ActionBlock)leftButtonEventBlock{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [superView addSubview:leftButton];
    
    [leftButton setImage:[UIImage imageNamed:@"icon_back_black"] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = YES;
    leftButton.titleLabel.font  = kFontSize(17);
    [leftButton setTitleColor:kBlackColor forState:UIControlStateNormal] ;
    leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [leftButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(25, 0, MAINSCREEN_WIDTH/2-25, 54+2*36);
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:9];
    self.leftButtonEventBlock = leftButtonEventBlock;
}

- (void)goBackEmptyContentButtonInSuperView:(UIView*)superView leftButtonEvent:(ActionBlock)leftButtonEventBlock{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [superView addSubview:leftButton];
    
    [leftButton setImage:[UIImage imageNamed:@"icon_back_black"] forState:UIControlStateNormal];
    [leftButton setTitle:@"" forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = YES;
    leftButton.titleLabel.font  = kFontSize(17);
    [leftButton setTitleColor:kBlackColor forState:UIControlStateNormal] ;
    leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [leftButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(25, 0, MAINSCREEN_WIDTH/2-25, 54+2*36);
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:9];
    self.leftButtonEventBlock = leftButtonEventBlock;
}

- (UIView*)setDataEmptyViewInSuperView:(UIView*)superView withTopMargin:(NSInteger)topMargin withCustomTitle:(NSString*)customTitle{// leftButtonEvent:(ActionBlock)leftButtonEventBlock
    UIView* view = [[UIView alloc]init];
    view.hidden = YES;
    view.userInteractionEnabled = YES;
    view.backgroundColor = kTableViewBackgroundColor;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(superView).offset(0);
        make.top.equalTo(superView.mas_top).offset(topMargin);
//                make.edges.equalTo(superView);
//        make.leading.trailing.equalTo(superView).offset(0);
//        make.centerY.mas_equalTo(superView);
//        make.height.mas_equalTo(118);//保证列表下啦
        //        make.top.equalTo(superView.mas_top).offset(topMargin);
        //        make.bottom.equalTo(superView);
    }];
    
    UIButton* button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.adjustsImageWhenHighlighted = NO;
    button0.titleLabel.numberOfLines = 0;
    button0.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button0.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:button0];
    //    button.backgroundColor = [UIColor redColor];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(view.mas_top);
        make.left.mas_equalTo(view.mas_left);
        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
    }];
    [button0 setAttributedTitle:[NSString attributedStringWithString:customTitle stringColor:HEXCOLOR(0x717171) stringFont:kFontSize(16) subString:@"" subStringColor:HEXCOLOR(0x4C7FFF) subStringFont:kFontSize(13)] forState:UIControlStateNormal];
    [button0 setImage:kIMG(@"icon_dataEmpty") forState:UIControlStateNormal];
    [button0 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:!IS_iPhoneX?17:35];
    //    [button0 addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    self.leftButtonEventBlock = leftButtonEventBlock;
    
    return view;
}

- (UIView*)setDataEmptyViewInSuperView:(UIView*)superView withTopMargin:(NSInteger)topMargin {// leftButtonEvent:(ActionBlock)leftButtonEventBlock
    UIView* view = [[UIView alloc]init];
    view.hidden = YES;
    view.userInteractionEnabled = YES;
    view.backgroundColor = kTableViewBackgroundColor;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.leading.bottom.trailing.equalTo(superView).offset(0);
        make.top.equalTo(superView.mas_top).offset(topMargin);
//        make.centerY.mas_equalTo(superView);
//        make.height.mas_equalTo(118);//保证列表下啦
//        make.top.equalTo(superView.mas_top).offset(topMargin);
//        make.bottom.equalTo(superView);
    }];
    
    UIButton* button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.adjustsImageWhenHighlighted = NO;
    button0.titleLabel.numberOfLines = 0;
    button0.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button0.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:button0];
    //    button.backgroundColor = [UIColor redColor];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(view);
        
        
        make.height.mas_equalTo(200);
        make.top.equalTo(view.mas_top).offset(134);
        //        make.left.mas_equalTo(0);
        //        make.right.mas_equalTo(0);
        make.width.mas_equalTo(177);
        //        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
    }];
    [button0 setAttributedTitle:[NSString attributedStringWithString:@"页面空空如也" stringColor:HEXCOLOR(0x717171) stringFont:kFontSize(16) subString:@"" subStringColor:HEXCOLOR(0x4C7FFF) subStringFont:kFontSize(13)] forState:UIControlStateNormal];
    [button0 setImage:kIMG(@"icon_dataEmpty") forState:UIControlStateNormal];
    [button0 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:35];
//    [button0 addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.leftButtonEventBlock = leftButtonEventBlock;
    
    return view;
}

- (UIView*)setServiceErrorViewInSuperView:(UIView*)superView leftButtonEvent:(ActionBlock)leftButtonEventBlock {
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.hidden = YES;
    view.userInteractionEnabled = YES;
    view.backgroundColor = kTableViewBackgroundColor;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    UIButton* button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.adjustsImageWhenHighlighted = NO;
    button0.titleLabel.numberOfLines = 0;
    button0.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button0.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:button0];
    //    button.backgroundColor = [UIColor redColor];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(view);
        
        
        make.height.mas_equalTo(200);
        make.top.equalTo(view.mas_top).offset(134);
        //        make.left.mas_equalTo(0);
        //        make.right.mas_equalTo(0);
        make.width.mas_equalTo(177);
        //        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
    }];
    [button0 setAttributedTitle:[NSString attributedStringWithString:@"抱歉，服务器开小差了" stringColor:HEXCOLOR(0x717171) stringFont:kFontSize(16) subString:@"" subStringColor:HEXCOLOR(0x4C7FFF) subStringFont:kFontSize(13)] forState:UIControlStateNormal];
    [button0 setImage:kIMG(@"icon_serviceError") forState:UIControlStateNormal];
    [button0 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:35];
    [button0 addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.numberOfLines = 0;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:button];
    
    button.titleLabel.font =
    [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];//kFontSize(15);
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6;
    button.layer.borderWidth = 1;
    button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
    button.backgroundColor = HEXCOLOR(0x4c7fff);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(view);
        
        
        make.height.mas_equalTo(40);
        make.top.equalTo(button0.mas_bottom).offset(72);
        //        make.left.mas_equalTo(0);
        //        make.right.mas_equalTo(0);
        make.width.mas_equalTo(191);
        //        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
    }];
    [button setAttributedTitle:[NSString attributedStringWithString:@"点击重试" stringColor:HEXCOLOR(0xffffff) stringFont:kFontSize(16) subString:@"" subStringColor:HEXCOLOR(0x4C7FFF) subStringFont:kFontSize(13)] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftButtonEventBlock = leftButtonEventBlock;
    
    return view;
}

- (UIView*)setNetworkErrorViewInSuperView:(UIView*)superView leftButtonEvent:(ActionBlock)leftButtonEventBlock {
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.hidden = YES;
    view.userInteractionEnabled = YES;
    view.backgroundColor = kTableViewBackgroundColor;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    UIButton* button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.adjustsImageWhenHighlighted = NO;
    button0.titleLabel.numberOfLines = 0;
    button0.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button0.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:button0];
//    button.backgroundColor = [UIColor redColor];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(view);
        
        
        make.height.mas_equalTo(200);
        make.top.equalTo(view.mas_top).offset(134);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
        make.width.mas_equalTo(177);
//        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
    }];
    [button0 setAttributedTitle:[NSString attributedStringWithString:@"网络错误，请重试" stringColor:HEXCOLOR(0x717171) stringFont:kFontSize(16) subString:@"" subStringColor:HEXCOLOR(0x4C7FFF) subStringFont:kFontSize(13)] forState:UIControlStateNormal];
    [button0 setImage:kIMG(@"icon_networkError") forState:UIControlStateNormal];
    [button0 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:35];
    [button0 addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.numberOfLines = 0;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:button];
    
    button.titleLabel.font =
    [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];//kFontSize(15);
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6;
    button.layer.borderWidth = 1;
    button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
    button.backgroundColor = HEXCOLOR(0x4c7fff);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(view);
        
        
        make.height.mas_equalTo(40);
        make.top.equalTo(button0.mas_bottom).offset(72);
        //        make.left.mas_equalTo(0);
        //        make.right.mas_equalTo(0);
        make.width.mas_equalTo(191);
        //        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
    }];
    [button setAttributedTitle:[NSString attributedStringWithString:@"点击重试" stringColor:HEXCOLOR(0xffffff) stringFont:kFontSize(16) subString:@"" subStringColor:HEXCOLOR(0x4C7FFF) subStringFont:kFontSize(13)] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftButtonEventBlock = leftButtonEventBlock;
    
    return view;
}

- (void)bottomSingleButtonInSuperView:(UIView*)superView WithButtionTitles:(NSString*)btnTitle withBottomMargin:(NSInteger)bottomMargin isHidenLine:(BOOL)isHidenLine leftButtonEvent:(ActionBlock)leftButtonEventBlock {
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.userInteractionEnabled = YES;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(superView).offset(0);
//        make.bottom.equalTo(superView.mas_bottom).offset([YBSystemTool isIphoneX]? -[YBFrameTool tabBarHeight]-bottomMargin:-bottomMargin);
        make.bottom.equalTo(superView.mas_bottom).offset(-bottomMargin);
        make.height.mas_equalTo(@48.5);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = NO;
    button.tag =  EnumActionTag0;
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.font =
    [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];//kFontSize(15);
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    button.layer.borderWidth = 1;
    button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
    [button setTitle:btnTitle forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    //        [_fucBtns[i] layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    
    [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(line1.mas_bottom).offset(3.5);
        make.leading.equalTo(@24);
        make.trailing.equalTo(@-24);
        make.bottom.equalTo(view.mas_bottom).offset(-3);
        
        make.height.mas_equalTo(@42);
    }];
    
    UIImageView* line1 = [[UIImageView alloc]init];
    line1.backgroundColor = HEXCOLOR(0xe6e6e6);
    line1.hidden = isHidenLine;
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(view).offset(0);
        make.top.equalTo(button.mas_top).offset(-3);
        make.height.mas_equalTo(@.5);
    }];
    
    self.leftButtonEventBlock = leftButtonEventBlock;
}
- (void)bottomSingleButtonInSuperView:(UIView*)superView
                    WithButtionTitles:(NSString*)btnTitle
                      leftButtonEvent:(ActionBlock)leftButtonEventBlock {
    
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.userInteractionEnabled = YES;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(superView).offset(0);
        make.bottom.equalTo(superView.mas_bottom).offset([YBSystemTool isIphoneX]? -[YBFrameTool tabBarHeight]:0);
        
        make.height.mas_equalTo(@48.5);
    }];
    
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO;
        button.tag =  EnumActionTag0;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font =
        [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];//kFontSize(15);
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
        [button setTitle:btnTitle forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
    
        //        [_fucBtns[i] layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    
    [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(line1.mas_bottom).offset(3.5);
        make.leading.equalTo(@24);
        make.trailing.equalTo(@-24);
        make.bottom.equalTo(view.mas_bottom).offset(-3);
        
        make.height.mas_equalTo(@42);
    }];
    
    UIImageView* line1 = [[UIImageView alloc]init];
    line1.backgroundColor = HEXCOLOR(0xe6e6e6);
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(view).offset(0);
        make.top.equalTo(button.mas_top).offset(-3);
        make.height.mas_equalTo(@.5);
    }];
    
    self.leftButtonEventBlock = leftButtonEventBlock;
}

- (void)customDoubleButtonInSuperView:(UIView*)superView WithButtionTitles:(NSArray*)btnTitles leftButtonEvent:(ActionBlock)leftButtonEventBlock rightButtonEvent:(ActionBlock)rightButtonEventBlock{
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.userInteractionEnabled = YES;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(superView).offset(0);
        make.top.equalTo(superView.mas_top).offset([YBFrameTool safeAdjustNavigationBarHeight] +38);
        
        make.height.mas_equalTo(@40);
    }];
    NSMutableArray* funcBtns = [NSMutableArray array];
    
    NSArray* subtitleArray = btnTitles;
    for (int i = 0; i < subtitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  i;
        button.selected = NO;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font = kFontSize(16);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 6;
        button.layer.borderWidth = 0;
        button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
        [button setTitle:subtitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [button addTarget:self action:@selector(funAdsButtonClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [funcBtns addObject:button];
        //        [_fucBtns[i] layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        
//        [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
//        [button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
//
//        [button setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(131, 132, 136)] forState:UIControlStateSelected];
//        [button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateSelected];
    }
//    UIButton* btn1 =_funcBtns.lastObject;
//    btn1.selected = YES;
    UIButton* btn0 =funcBtns.firstObject;
    [btn0 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
    [btn0 setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];


    UIButton* btn1 =funcBtns.lastObject;
    [btn1 setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(131, 132, 136)] forState:UIControlStateNormal];
    [btn1 setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    btn1.selected = YES;
    self.funcBtns = funcBtns;
    [funcBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:12 leadSpacing:24 tailSpacing:24];
    
    [funcBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(0);
        
        make.height.mas_equalTo(view);
    }];
    
//    UIImageView* line1 = [[UIImageView alloc]init];
//    line1.backgroundColor = HEXCOLOR(0xe6e6e6);
//    [view addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.equalTo(view).offset(0);
//        make.top.equalTo(btn0.mas_top).offset(-3);
//        make.height.mas_equalTo(@.5);
//    }];
    
    self.leftButtonEventBlock = leftButtonEventBlock;
    self.rightButtonEventBlock = rightButtonEventBlock;
}

- (void)funAdsButtonClickItem:(UIButton*)btn{
    UIButton* button = btn ;
    NSString* btnTit = btn.selected?button.titleLabel.text:@"";
    button.selected = !button.selected;
    if (button.selected) {
        //单
        for (UIButton *btn in self.funcBtns) {
            btn.selected = NO;
            [btn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
            [btn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
            if (btn.tag == button.tag) {
                btn.selected = YES;
                [btn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(131, 132, 136)] forState:UIControlStateNormal];
                [btn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
                
            }
        }

        btnTit = button.titleLabel.text;
        
    } else {
        //不
//        for (UIButton *btn in _funcBtns) {
//            btn.selected = NO;
//            [btn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
//            [btn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
//        }
//
//        btnTit = @"";
        
    }
    
//    NSLog(@"///////%@,%ld",btnTit,(long)btn.tag);
    if (btn.tag == EnumActionTag0) {
        if (self.leftButtonEventBlock)
        {
            self.leftButtonEventBlock(btn);
        }
    }else if (btn.tag == EnumActionTag1){
        if (self.rightButtonEventBlock)
        {
            self.rightButtonEventBlock(btn);
        }
    }
}

- (void)bottomDoubleButtonInSuperView:(UIView*)superView WithButtionTitles:(NSArray*)btnTitles leftButtonEvent:(ActionBlock)leftButtonEventBlock rightButtonEvent:(ActionBlock)rightButtonEventBlock{
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.userInteractionEnabled = YES;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(superView).offset(0);
        make.bottom.equalTo(superView.mas_bottom).offset([YBSystemTool isIphoneX]? -[YBFrameTool tabBarHeight]:0);
        
        make.height.mas_equalTo(@48.5);
    }];
    NSMutableArray* funcBtns = [NSMutableArray array];
    
    NSArray* subtitleArray = btnTitles;
    for (int i = 0; i < subtitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO;
        button.tag =  i;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font =
        [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];//kFontSize(15);
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
        [button setTitle:subtitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        [funcBtns addObject:button];
        //        [_fucBtns[i] layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    }
    UIButton* bt0 =funcBtns.firstObject;
    [bt0 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xffffff)] forState:UIControlStateNormal];
    [bt0 setTitleColor:HEXCOLOR(0x4c7fff) forState:UIControlStateNormal];
    
    
    
    UIButton* bt1 = funcBtns.lastObject;
    [bt1 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
    [bt1 setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    
    [funcBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:16 tailSpacing:16];
    
    [funcBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-3);
        
        make.height.mas_equalTo(@42);
    }];
    
    UIImageView* line1 = [[UIImageView alloc]init];
    line1.backgroundColor = HEXCOLOR(0xe6e6e6);
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(view).offset(0);
        make.top.equalTo(bt0.mas_top).offset(-3);
        make.height.mas_equalTo(@.5);
    }];
    
    self.leftButtonEventBlock = leftButtonEventBlock;
    self.rightButtonEventBlock = rightButtonEventBlock;
}
- (void)bottomDoubleButtonInSuperView:(UIView*)superView leftButtonEvent:(ActionBlock)leftButtonEventBlock rightButtonEvent:(ActionBlock)rightButtonEventBlock{
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.userInteractionEnabled = YES;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(superView).offset(0);
        make.bottom.equalTo(superView.mas_bottom).offset([YBSystemTool isIphoneX]? -[YBFrameTool tabBarHeight]:0);
        
        make.height.mas_equalTo(@48.5);
    }];
    NSMutableArray* funcBtns = [NSMutableArray array];
    
    NSArray* subtitleArray =@[@"取消",@"确定"];
    for (int i = 0; i < subtitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  i;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font =
        [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];//kFontSize(15);
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
        [button setTitle:subtitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        [funcBtns addObject:button];
        //        [_fucBtns[i] layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    }
    UIButton* bt0 =funcBtns.firstObject;
    [bt0 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xffffff)] forState:UIControlStateNormal];
    [bt0 setTitleColor:HEXCOLOR(0x4c7fff) forState:UIControlStateNormal];
    
    
    
    UIButton* bt1 = funcBtns.lastObject;
    [bt1 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
    [bt1 setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    
    [funcBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:16 tailSpacing:16];
    
    [funcBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-3);
        make.height.mas_equalTo(@42);
    }];
    
    UIImageView* line1 = [[UIImageView alloc]init];
    line1.backgroundColor = HEXCOLOR(0xe6e6e6);
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(view).offset(0);
        make.top.equalTo(bt0.mas_top).offset(-3);
        make.height.mas_equalTo(@.5);
    }];
    
    self.leftButtonEventBlock = leftButtonEventBlock;
    self.rightButtonEventBlock = rightButtonEventBlock;
}

- (void)bottomTripleButtonInSuperView:(UIView*)superView
                leftLittleButtonEvent:(ActionBlock)leftLittleButtonEventBlock
                      leftButtonEvent:(ActionBlock)leftButtonEventBlock
                     rightButtonEvent:(ActionBlock)rightButtonEventBlock{
    
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = kWhiteColor;
    view.userInteractionEnabled = YES;
    [superView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.equalTo(superView).offset(0);
        
        make.bottom.equalTo(superView.mas_bottom).offset([YBSystemTool isIphoneX]? -[YBFrameTool iphoneBottomHeight]:0);
        
//        make.bottom.equalTo(superView.mas_bottom);
        
        make.height.mas_equalTo(@48.5);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.tag =  EnumActionTag2;
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11.0];//kFontSize(15);
    [button setTitleColor:RGBCOLOR(76, 127, 255) forState:UIControlStateNormal];
    [button setTitle:@"联系可可家" forState:UIControlStateNormal];
    [button setImage:kIMG(@"contactOthers") forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.bottom.equalTo(view.mas_bottom).offset(-3);
        
        make.height.mas_equalTo(@48.5);
    }];
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    
//    UIView* verLine = [[UIView alloc]init];
//    verLine.backgroundColor = HEXCOLOR(0x4c7fff);
//    [view addSubview:verLine];
//    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.top.equalTo(line1.mas_bottom).offset(3.5);
//    make.left.equalTo(view).offset(78.5);
//        make.centerY.equalTo(button);
//
//        make.height.mas_equalTo(@20);
//        make.width.mas_equalTo(@1);
//    }];
    
    NSMutableArray* funcBtns = [NSMutableArray array];
    
    NSArray* subtitleArray =@[@"取消🌹",@"已完成靓靓🐟"];
    for (int i = 0; i < subtitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  i;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font =
        [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];//kFontSize(15);
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;
        [button setTitle:subtitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        [funcBtns addObject:button];
        //        [_fucBtns[i] layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    }
    UIButton* bt0 =funcBtns.firstObject;
    [bt0 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xffffff)] forState:UIControlStateNormal];
    [bt0 setTitleColor:HEXCOLOR(0x4c7fff) forState:UIControlStateNormal];

    
    UIButton* bt1 = funcBtns.lastObject;
    [bt1 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateNormal];
    [bt1 setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    
    [funcBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:93 tailSpacing:16];
    
    [funcBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-3);
        make.height.mas_equalTo(@42);
    }];
    
    UIImageView* line1 = [[UIImageView alloc]init];
    line1.backgroundColor = HEXCOLOR(0xe6e6e6);
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(view).offset(0);
        make.top.equalTo(bt0.mas_top).offset(-3);
        make.height.mas_equalTo(@.5);
    }];
    self.leftLittleButtonEventBlock = leftLittleButtonEventBlock;
    self.leftButtonEventBlock = leftButtonEventBlock;
    self.rightButtonEventBlock = rightButtonEventBlock;
}


- (void)clickItem:(UIButton*)button{
    if (button.tag == EnumActionTag0) {
        if (self.leftButtonEventBlock)
        {
            self.leftButtonEventBlock(button);
        }
    }else if (button.tag == EnumActionTag1){
        if (self.rightButtonEventBlock)
        {
            self.rightButtonEventBlock(button);
        }
    }
    else if (button.tag == EnumActionTag2){
        if (self.leftLittleButtonEventBlock)
        {
            self.leftLittleButtonEventBlock(button);
        }
    }
}

@end
