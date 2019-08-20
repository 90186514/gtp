//
//  YBTrendsViewController.m
//  YBArchitectureDemo
//
//  Created by 杨波 on 2018/11/19.
//  Copyright © 2018 杨波. All rights reserved.
//

#import "YBMsgViewController.h"
#import "AViewController.h"
#import "BViewController.h"
@interface YBMsgViewController (){
    AViewController* aVC;
    BViewController* bVC;
}

@end

@implementation YBMsgViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    return;
    aVC=[[AViewController alloc]init];
    bVC=[[BViewController alloc]init];
    NSArray* items=[NSArray arrayWithObjects:aVC,bVC, nil];
    [self setViewControllers:items titles:@[@"A",@"B"]];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSubViewController:)];
    NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
    
    
    NSInteger count=[userDefaults integerForKey:@"count"];
    count++;
    if (count>2) {
        //        if (self.selectedViewControllerIndex==1) {
        //            return;
        //        }
        [self.segmentedControl setSelectedSegmentIndex:1];
        self.selectedViewControllerIndex = 1;
        //        self.navigationController.navigationBar.barTintColor = RGBCOLOR(2, 131, 222);
        //        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else {
        [userDefaults setInteger:count forKey:@"count"];
        [userDefaults synchronize];
        
        //        if (self.selectedViewControllerIndex==0) {
        //            return;
        //        }
        
        [self.segmentedControl setSelectedSegmentIndex:0];
        self.selectedViewControllerIndex = 0;
        //    self.navigationController.navigationBar.barTintColor = RGBCOLOR(253, 112, 164);
        //    self.navigationController.navigationBar.tintColor = [UIColor greenColor];
        
    }
    
}

- (void)addSubViewController:(id)sender
{
    UIViewController *viewController =[[AViewController alloc]init];
    [self pushViewController:viewController title:@"New"];
}

@end
