//
//  AppDelegate.m
//  gtp
//
//  Created by Aalto on 2018/12/15.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "YBRootTabBarViewController.h"
#import "AccountRootTabBarViewController.h"
#import "LoginVC.h"
#import "LoginModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)initRootUI {
    [self setNetWorkErrInfo];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [YBRootTabBarViewController new];
    return;
    if ([GetUserDefaultWithKey(kIsLogin) boolValue]==YES) {
        _window.rootViewController = [YBRootTabBarViewController new];
    }else{
        LoginVC* logVC = [LoginVC new];
        _window.rootViewController = logVC;
        WS(weakSelf);
        [logVC actionBlock:^(id data) {
            LoginModel* model =data;
            if ([model.userinfo.valigooglesecret integerValue]==1
                &&[model.userinfo.safeverifyswitch integerValue]==1) {
                [VertifyVC pushFromVC:logVC requestParams:data success:^(id data) {
                    NSLog(@"na pw vw%@",data);
                    return ;
                }];
            }
             SetUserBoolKeyWithObject(kIsLogin, YES);
             UserDefaultSynchronize;
             weakSelf.window.rootViewController = [YBRootTabBarViewController new];
        }];
        
    }
    
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initRootUI];
    [[AccountingModel new] setAccountingDataIsForceInit:NO];
//    [UserInfoSingleton sharedUserInfoContext].userInfo= [UserInfoManager GetNSUserDefaults];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    return YES;
}

#pragma mark--设置网络错误回调
-(void)setNetWorkErrInfo{
    [[YTSharednetManager sharedNetManager] setAFNetStatusChangeBlock:^(managerAFNetworkStatus status) {
        NSMutableDictionary *notiDic = [NSMutableDictionary dictionary];
        [notiDic setObject:[NSString stringWithFormat:@"%ld",status] forKey:@"status"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_NetWorkingStatusRefresh object:notiDic];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
