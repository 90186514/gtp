//
//  OrderDetailVC.m
//  gt
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "ModifyAdsVC.h"
#import "ModifyAdsView.h"
#import "ModifyAdsVM.h"
#import "PostAdsVC.h"

@interface ModifyAdsVC () <ModifyAdsViewDelegate>
@property (nonatomic, strong) ModifyAdsView *mainView;
@property (nonatomic, strong) ModifyAdsVM *vm;

@end

@implementation ModifyAdsVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self YBGeneral_baseConfig];
    self.title = @"修改广告";
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
//    WS(weakSelf);
    [self.mainView actionBlock: ^(id data) {
        EnumActionTag btnType  = [data integerValue];
        switch (btnType) {
            case EnumActionTag2:
            {
                [PostAdsVC pushFromVC:self requestParams:@(PostAdsTypeEdit) success:^(id data) {
                    
                }];
            }
                break;
            case EnumActionTag3:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认要下架吗？" message:nil preferredStyle:  UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [[YBNaviagtionViewController rootNavigationController] presentViewController:alert animated:true completion:nil];
            }
                break;
                
            default:
                
                break;
        }
    }];
}

#pragma mark - HomeViewDelegate

- (void)modifyAdsView:(ModifyAdsView *)view requestListWithPage:(NSInteger)page {
   kWeakSelf(self);
    [self.vm network_getModifyAdsListWithPage:page success:^(NSArray * _Nonnull dataArray) {
        kStrongSelf(self);
        [self.mainView requestListSuccessWithArray:dataArray];
    } failed:^{
        kStrongSelf(self);
        [self.mainView requestListFailed];
    }];
}

#pragma mark - getter

- (ModifyAdsView *)mainView {
    if (!_mainView) {
        _mainView = [ModifyAdsView new];
        _mainView.delegate = self;
    }
    return _mainView;
}

- (ModifyAdsVM *)vm {
    if (!_vm) {
        _vm = [ModifyAdsVM new];
    }
    return _vm;
}

@end
