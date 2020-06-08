//
//  DraggableCVC.m


#import "DraggableCVC.h"
#import "DraggableCView.h"
#import "DraggableCVModel.h"
@interface DraggableCVC ()
@property (nonatomic, strong) NSMutableArray *funcBtns;
@property (nonatomic, strong) NSMutableArray *verticalFuncBtns;
@property (nonatomic, strong) NSDictionary *dicXY;
@property (nonatomic, strong) DraggableCView* accountTagView;
@end

@implementation DraggableCVC
+ (instancetype)pushFromVC:(UIViewController *)rootVC
{
    DraggableCVC *vc = [[DraggableCVC alloc] init];
    [rootVC.navigationController pushViewController:vc animated:true];
    return vc;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self YBGeneral_baseConfig];
    _funcBtns = [NSMutableArray arrayWithCapacity:2];
    _verticalFuncBtns = [NSMutableArray arrayWithCapacity:2];
    self.dicXY = @{@(2):@(3)};
    
    UIButton *saftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saftBtn.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, [YBFrameTool safeAdjustNavigationBarHeight]);
    saftBtn.titleLabel.font = kFontSize(17);
    [saftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saftBtn.backgroundColor = [UIColor lightGrayColor];
    [saftBtn setTitle:[NSString currentDataStringWithFormatString:[NSString ymSeparatedBySlashFormatString]] forState:UIControlStateNormal];
    saftBtn.tag = 9;
    saftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    saftBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.view addSubview:saftBtn];
    saftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 15, 0);
    
    NSArray* subtitleArray =@[
        @{@"难度系数":@""},
        @{@"重新开始":@""}
        ];
    for (int i = 0; i < subtitleArray.count; i++) {
        NSDictionary* dic = subtitleArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  i;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font = kFontSize(15);
//                button.layer.masksToBounds = YES;
//                button.layer.cornerRadius = 6;
//                button.layer.borderWidth = 1;
        
        [button setTitle:dic.allKeys[0] forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        //        [button addTarget:self action:@selector(funAdsButtonClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [_funcBtns addObject:button];
//            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    }
    
    [_funcBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:82 leadSpacing:13 tailSpacing:13];
    
    [_funcBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(saftBtn.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];

    UIButton* fbtn1 = _funcBtns[1];
    [fbtn1 setBackgroundImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
    fbtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [fbtn1 setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    [fbtn1 addTarget:self action:@selector(layoutPathView) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray* vsubtitleArray =@[
    @{@" 5* 8 ":@"selectedPot"},
    @{@" 6* 10 ":@"unSelectedPot"}
    ];
    for (int i = 0; i < 2; i++) {
        NSDictionary* dic = vsubtitleArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  i;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font = kFontSize(15);
        
        [button setTitle:dic.allKeys[0] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dic.allValues[0]] forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [button addTarget:self action:@selector(funAdsButtonClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [_verticalFuncBtns addObject:button];
    }
    
    UIButton* fbtn0 = _funcBtns[0];
    
    UIButton* vbtn0 = _verticalFuncBtns[0];
    vbtn0.selected = YES;
    [_verticalFuncBtns mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:[YBFrameTool safeAdjustNavigationBarHeight] tailSpacing:MAINSCREEN_HEIGHT-[YBFrameTool safeAdjustNavigationBarHeight]-60];
    
    [_verticalFuncBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fbtn0.mas_right);
//        make.height.equalTo(@30);
        make.width.equalTo(@90);
    }];
    
    [self richElementsInViewWithModel:nil];
    
    [self layoutPathView];
}

- (void)layoutPathView{
    if (self.accountTagView) {
        [self.accountTagView removeFromSuperview];
    }
    self.accountTagView = [[DraggableCView alloc]init];
        [self.view addSubview:self.accountTagView];
        self.accountTagView.alpha = 1.0;
        self.accountTagView.userInteractionEnabled = true;
        [self.accountTagView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo([YBFrameTool safeAdjustNavigationBarHeight]+60);//60
         
                make.left.right.equalTo(self.view).offset(0);
                make.height.mas_equalTo([DraggableCView cellHeightWithModel]);
            }];
//        [self.accountTagView showInView:self.view];
        [self.accountTagView actionBlock:^(NSDictionary* data) {
    //        [self.accountTagView disMissView];
            if ([UserInfoManager GetNSUserDefaults].recordedDate){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜您🌹" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
                NSString* message = [NSString stringWithFormat:@"用了%@通关",[NSString currentDateComparePastDate:[UserInfoManager GetNSUserDefaults].recordedDate]];
                    
                [alert addAction:[UIAlertAction actionWithTitle:@"再来一局" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [self layoutPathView];
                }]];
                
                alert.message = message;
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    
    [self richElementsInPathViewWithModel:nil];
}

- (void)richElementsInViewWithModel:(id)model{
    UIButton* titleBtn = [self.view viewWithTag:9];
    [titleBtn setTitle:@"把列表上的数字按照顺序排列好，即可获胜！" forState:UIControlStateNormal];
}

- (void)richElementsInPathViewWithModel:(id)model{
     
    NSInteger x = [self.dicXY.allKeys[0] intValue];
    NSInteger y = [self.dicXY.allValues[0] intValue];
    [self.accountTagView richElementsInCellWithModel:[[DraggableCVModel new]getMazeDatasByX:x byY:y]];
}
- (void)funAdsButtonClickItem:(UIButton*)btn{
    UIButton* button = btn ;
    NSString* btnTit = btn.selected?button.titleLabel.text:@"";
    button.selected = !button.selected;
    if (button.selected) {
        
        for (UIButton *btn in self.verticalFuncBtns) {
            btn.selected = NO;
            [btn setImage:[UIImage imageNamed:@"unSelectedPot"] forState:UIControlStateNormal];
            
            if (btn.tag == button.tag) {
                btn.selected = YES;
                [btn setImage:[UIImage imageNamed:@"selectedPot"] forState:UIControlStateNormal];
            }
        }

        btnTit = button.titleLabel.text;
        
    } else {
        
        
    }
    
    if (btn.tag == EnumActionTag0) {
        self.dicXY = @{@(5):@(8)};
    }else if (btn.tag == EnumActionTag1){
         self.dicXY = @{@(6):@(10)};
    }
    [self layoutPathView];
}
@end
