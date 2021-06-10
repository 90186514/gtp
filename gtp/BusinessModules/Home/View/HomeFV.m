
#import "HomeFV.h"

@interface HomeFV ()
@property (nonatomic,copy) NSArray *turnArr;
@property (nonatomic,strong)NSMutableArray *resultArray;
@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic, copy) ActionBlock block;
@property (nonatomic,strong)UIView *bgView;

@end
@implementation HomeFV

- (id)initWithFrame:(CGRect)frame InSuperView:(UIView*)superView withTopMargin:(NSInteger)topMargin{
    if (self == [super initWithFrame:frame]) {
        self.resultArray = [NSMutableArray array];
        
        self.bgView = [[UIView alloc]init];
//        self.bgView.backgroundColor = HEXCOLOR(0x291518);
        self.bgView.userInteractionEnabled = YES;
        [superView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
            make.leading.equalTo(superView).offset(30);
            make.centerX.mas_equalTo(superView);
            make.bottom.mas_equalTo(topMargin);
            make.top.mas_equalTo(superView);
        }];
        
        
        
        
        [self.bgView layoutIfNeeded];
        
    }
        
    
    return self;
}

-(void)richElementsInCellWithModel:(id)model{
    self.turnArr = model;
    
    
    _btns = [NSMutableArray array];
    
    for (int i = 0; i < self.turnArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  i;
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        //            [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgView addSubview:button];
        [_btns addObject:button];
//        [button setAttributedTitle:self.turnArr[i] forState:0];
        
    }
    
    [_btns mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [_btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.mas_equalTo((50/self.turnArr.count));
//        make.width.mas_equalTo(@18);
    }];
    
    

}

- (void)startButtonClick{

}

- (void)actionBlock:(ActionBlock)block
{
    self.block = block;
}
@end
