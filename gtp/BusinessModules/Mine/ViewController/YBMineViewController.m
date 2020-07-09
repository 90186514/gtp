//
//  YBMineViewController.m
//  YBArchitectureDemo
//
//  Created by 杨波 on 2018/11/19.
//  Copyright © 2018 杨波. All rights reserved.
//

#import "YBMineViewController.h"
#import "JXCategoryTitleView.h"
#import <JXCategoryView/JXCategoryView.h>
@interface YBMineViewController ()< UINavigationControllerDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) UIView                *titleView;
@property (nonatomic, strong) JXCategoryTitleView                *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *listVCArray;
@end

@implementation YBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self YBGeneral_baseConfig];
    
    [self.view addSubview:self.titleView];
    
    [self.titleView addSubview:self.categoryView];
//    self.titleView.backgroundColor = [UIColor greenColor];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);//[YBFrameTool statusBarHeight]
        make.height.mas_equalTo(44.0f);
    }];
    
    self.listVCArray = [NSMutableArray array];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView);
        make.centerX.equalTo(self.titleView);
        make.height.equalTo(self.titleView);
        make.left.equalTo(self.titleView);
    }];

    self.scrollView = [[UIScrollView alloc] init];
    [self.view  insertSubview:self.scrollView atIndex:0];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        //-[YBFrameTool safeAdjustTabBarHeight]
    }];

    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //FIXME:如果和自定义UIScrollView联动，删除纯UIScrollView示例
    self.categoryView.contentScrollView = self.scrollView;

    [self reloadSubData];
}
/**
重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
*/
- (void)reloadSubData {
    NSArray *titles = @[@"AA", @"BB", @"CC"];
    for (UIViewController *vc in self.listVCArray) {
        [vc.view removeFromSuperview];
    }
    [self.listVCArray removeAllObjects];

    
    [self.view layoutIfNeeded];
    
    [self.scrollView layoutIfNeeded];
    
    for (int i=0; i<titles.count - 1; i++) {
        BaseVC *listVC = [[BaseVC alloc] init];
        listVC.view.backgroundColor = [UIColor orangeColor];
        listVC.view.frame = CGRectMake(i*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self addChildViewController:listVC];
        [self.listVCArray addObject:listVC];
        [self.scrollView addSubview:listVC.view];
    }
    
    BaseVC *rightVC = [[BaseVC alloc] init];
    rightVC.view.frame = CGRectMake(2*self.scrollView.bounds.size.width, CGRectGetMaxY(self.titleView.frame), self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    rightVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:rightVC];
    [self.listVCArray addObject:rightVC];
    [self.scrollView addSubview:rightVC.view];
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*titles.count, self.scrollView.bounds.size.height);

    //触发首次加载
//    [self.listVCArray.firstObject loadDataForFirst];

    self.categoryView.defaultSelectedIndex = 1;
    self.categoryView.titles = titles;
    [self.categoryView reloadData];
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
//    [self.listVCArray[index] loadDataForFirst];
}
//正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio{
    
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] init];
        _categoryView.delegate = self;
        _categoryView.titleColor = [UIColor lightGrayColor];
        _categoryView.titleSelectedColor = [UIColor whiteColor];
        _categoryView.titleFont = [UIFont boldSystemFontOfSize:16.0f];
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:18.0f];
        _categoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor whiteColor];
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [UIView new];
    }
    return _titleView;
}

- (void)dealloc {
    // 点击返回 或 侧滑返回
    //NSLog(@"playerVC dealloc");
}
@end
