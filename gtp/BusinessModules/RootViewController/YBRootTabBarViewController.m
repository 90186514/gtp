//
//  YBRootTabBarViewController.m
//  YBArchitectureDemo
//
//  Created by ML on 2018/11/19.
//  Copyright © 2018 ML. All rights reserved.
//

#import "YBRootTabBarViewController.h"
#import "YBNaviagtionViewController.h"
#import "HomeVC.h"
#import "HomeVVC.h"

#import "YBTrendsViewController.h"
#import "YBMsgViewController.h"
#import "YBMineViewController.h"

#import "AdsVC.h"
#import "FaceQRVC.h"

@interface YBRootTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
    //最近一次选择的Index
@property(nonatomic, readonly) NSUInteger lastSelectedIndex;
@property (nonatomic, strong) HomeVC *homeVC;

@property (nonatomic, strong) HomeVVC *homeVVC;
@property (nonatomic, strong) AdsVC *adVC;
@property (nonatomic, strong) YBTrendsViewController *trendsVC;
@property (nonatomic, strong) YBMsgViewController *msgVC;
@property (nonatomic, strong) YBMineViewController *mineVC;
@property (nonatomic, strong) FaceQRVC *fQRVC;
@end

@implementation YBRootTabBarViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.tabBar.translucent = NO;
    self.tabBar.shadowImage = [UIImage new];
    [self configSubViewControllers];
}

#pragma mark - private
- (void)configSubViewControllers {
    self.viewControllers = @[
        [self getViewControllerWithVC:self.homeVVC title:@"首页" normalImage:[UIImage imageNamed:@"icon_home_gray"] selectImage:[UIImage imageNamed:@"icon_home_blue"]],
        [self getViewControllerWithVC:self.adVC title:@"勃勃生机" normalImage:[UIImage imageNamed:@"icon_deal_gray"] selectImage:[UIImage imageNamed:@"icon_deal_blue"]],
        [self getViewControllerWithVC:self.trendsVC title:@"消息" normalImage:[UIImage imageNamed:@"icon_massage_gray"] selectImage:[UIImage imageNamed:@"icon_massage_blue"]],
        [self getViewControllerWithVC:self.mineVC title:@"我的" normalImage:[UIImage imageNamed:@"icon_my_gray"] selectImage:[UIImage imageNamed:@"icon_my_blue"]]];
}

- (UIViewController *)getViewControllerWithVC:(UIViewController *)vc title:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage {
    
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:YBGeneralColor.tabBarTitleSelectedColor} forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:YBGeneralColor.tabBarTitleNormalColor} forState:UIControlStateNormal];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    vc.navigationItem.title = title;
    YBNaviagtionViewController *nav = [[YBNaviagtionViewController alloc] initWithRootViewController:vc];
    return nav;
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    //判断是否相等,不同才设置
    if (self.selectedIndex != selectedIndex  && self.selectedIndex != 1) {
        //设置最近一次
        _lastSelectedIndex = self.selectedIndex;
    }
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}
 
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    if (tabIndex != self.selectedIndex && self.selectedIndex != 1) {
        //设置最近一次变更
        _lastSelectedIndex = self.selectedIndex;
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}
#pragma mark - getter

- (HomeVC *)homeVC {
    if (!_homeVC) {
        _homeVC = [HomeVC new];
    }
    return _homeVC;
}


- (HomeVVC *)homeVVC {
    if (!_homeVVC) {
        _homeVVC = [HomeVVC new];
    }
    return _homeVVC;
}
- (AdsVC *)adVC {
    if (!_adVC) {
        _adVC = [AdsVC new];
    }
    return _adVC;
}

- (FaceQRVC*)fQRVC{
    if (!_fQRVC) {
        _fQRVC = [FaceQRVC new];
    }
    return _fQRVC;
}
- (YBTrendsViewController *)trendsVC {
    if (!_trendsVC) {
        _trendsVC = [YBTrendsViewController new];
    }
    return _trendsVC;
}

- (YBMsgViewController *)msgVC {
    if (!_msgVC) {
        _msgVC = [YBMsgViewController new];
    }
    return _msgVC;
}

- (YBMineViewController *)mineVC {
    if (!_mineVC) {
        _mineVC = [YBMineViewController new];
    }
    return _mineVC;
}

@end
