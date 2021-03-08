//
//  WKPopUpView.m


#import "WKPopUpView.h"
#import <WebKit/WebKit.h>
#import "NoInputAccessoryView.h"

#define XHHTuanNumViewHight MAINSCREEN_WIDTH * 1423/1125
#define XHHTuanNumViewHight2 MAINSCREEN_WIDTH * 1723/1125
#define XHHTuanNumViewWidth MAINSCREEN_WIDTH

@interface WKPopUpView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *contentView;
@property (nonatomic, strong) WKWebView  *webView;

@property (nonatomic, strong) NSMutableArray* leftLabs;
@property (nonatomic, copy) NSString* model;
@property (nonatomic, copy) ActionBlock block;
@property (nonatomic, assign) CGFloat contentViewHeigth;

@property (nonatomic, strong) NSMutableArray *funcBtns;
@end

@implementation WKPopUpView

- (void)clickright{
    if (self.block) {
        self.block(@2);
    }
}

///// 键盘将要弹起
- (void)keyBoardShow {
    
    if (self.block) {
        self.block(@1);
    }
    [self funAdsButtonClickItem:1];
}

///// 键盘将要隐藏
- (void)keyBoardHidden:(NSNotification *)notification{
    if (self.block) {
        self.block(@0);
    }
    [self funAdsButtonClickItem:0];
}
- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow) name:UIKeyboardWillShowNotification object:nil];
        /// 监听将要隐藏
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        [self setupContent];
    }
    
    return self;
}

- (void)setupContent {
    _leftLabs = [NSMutableArray array];
    
    _funcBtns = [NSMutableArray array];
    self.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT);
    
    self.backgroundColor = COLOR_HEX(0x000000, .6);
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    _contentViewHeigth = XHHTuanNumViewHight;
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, (MAINSCREEN_HEIGHT - _contentViewHeigth)/2, XHHTuanNumViewWidth, _contentViewHeigth)];
        _contentView.layer.cornerRadius = 6;
        _contentView.layer.masksToBounds = YES;
        _contentView.userInteractionEnabled = YES;
//        _contentView.backgroundColor = ColorWithHex(0xf3fdff,1);
        [self addSubview:_contentView];
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
    //    titleLabel.textColor = [UIColor colorWithRed:246.0 green:160. blue:195 alpha:0];
        titleLabel.textColor = [UIColor colorWithRed:81.0f/255.0  green:81.0f/255.0f blue:81.0/255.0f alpha:1];

        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text =@"百搭";
    //    self.navigationItem.titleView = titleLabel;
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(@160);
            make.height.equalTo(@40);
            
        }];
        
        [self.contentView layoutIfNeeded];
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"浏览器打开" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        [button setTitleColor:[UIColor colorWithRed:137.0f/255.0  green:137.0f/255.0f blue:137.0/255.0f alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize: 12];
        button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;
    //    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        button.tag = 2;
        [button addTarget:self action:@selector(clickright) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.rightBarButtonItem = buttonItem;
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(titleLabel);
            make.left.equalTo(titleLabel).offset(5);
            
        }];
        
        
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.mas_equalTo(self.contentView);
//            make.top.mas_equalTo(titleLabel.bottom);
            make.top.mas_equalTo(self.contentView).offset(40);
        }];
        
        [[NoInputAccessoryView new]removeInputAccessoryViewFromWKWebView:self.webView];
    }
}


- (void)actionBlock:(ActionBlock)block
{
    self.block = block;
}

- (void)funAdsButtonClickItem:(NSInteger)tag{
    
    
//    if (self.block) {
//        self.block(@(btn.tag));
//    }
//    [self disMissView];
    switch (tag) {
        case 1:
        {
            [self changeContentViewFrame:CGRectMake(0, MAINSCREEN_HEIGHT - XHHTuanNumViewHight2, MAINSCREEN_WIDTH, XHHTuanNumViewHight2)];
            [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-75);
            }];
        }
            break;
        case 0:
        {
            [self changeContentViewFrame:CGRectMake(0, MAINSCREEN_HEIGHT - XHHTuanNumViewHight, MAINSCREEN_WIDTH, XHHTuanNumViewHight)];
            [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
        }
            break;
        default:
            break;
    }
}

- (void)richElementsInViewWithModel:(NSString*)model{
    if (!model) {
        return;
    }
    self.model = model;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model]];
    [self.webView loadRequest:request];
}

- (void)showInApplicationKeyWindow{
    [self showInView:[[UIApplication sharedApplication] delegate].window];
    
    //    [popupView showInView:self.view];
    //
    //    [popupView showInView:[UIApplication sharedApplication].keyWindow];
    //
    //    [[UIApplication sharedApplication].keyWindow addSubview:popupView];
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, MAINSCREEN_HEIGHT, XHHTuanNumViewWidth, _contentViewHeigth)];
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.alpha = 1.0;
        
//        [weakSelf.contentView setFrame:CGRectMake((SCREEN_WIDTH - XHHTuanNumViewWidth)/2, (SCREENHEIGHT - weakSelf.contentViewHeigth)/2,XHHTuanNumViewWidth,weakSelf.contentViewHeigth)];
        [weakSelf.contentView setFrame:CGRectMake(0, MAINSCREEN_HEIGHT - XHHTuanNumViewHight, MAINSCREEN_WIDTH, XHHTuanNumViewHight)];
        
    } completion:nil];
}

- (void)changeContentViewFrame:(CGRect)frame{
    __weak __typeof(self)weakSelf = self;
    [_contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, (MAINSCREEN_HEIGHT - _contentViewHeigth)/2, XHHTuanNumViewWidth, _contentViewHeigth)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         weakSelf.alpha = 1.0;
                         
                         [weakSelf.contentView setFrame:frame];
        
        
                     }
                     completion:^(BOOL finished){
                         
//                         [weakSelf removeFromSuperview];
//                         [weakSelf.contentView removeFromSuperview];
                         
                     }];
}
//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    __weak __typeof(self)weakSelf = self;
    [_contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, (MAINSCREEN_HEIGHT - _contentViewHeigth)/2, XHHTuanNumViewWidth, _contentViewHeigth)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         weakSelf.alpha = 0.0;
                         
                         [weakSelf.contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, MAINSCREEN_HEIGHT, XHHTuanNumViewWidth, weakSelf.contentViewHeigth)];
                     }
                     completion:^(BOOL finished){
                         
                         [weakSelf removeFromSuperview];
                         [weakSelf.contentView removeFromSuperview];
                         
                     }];
    
}

@end

