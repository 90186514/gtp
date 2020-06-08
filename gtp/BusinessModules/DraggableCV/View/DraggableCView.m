//
//  DraggableCView.m

#import "DraggableCView.h"
#import "DraggableCViewFlowLayout.h"
#import "DraggableCVModel.h"
@interface CVCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *titleLab;
@end

@implementation CVCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self ==[super initWithFrame:frame]){
        UILabel *titleLab = [[UILabel alloc]init];
                titleLab.tag = 7003;
                [self.contentView addSubview:titleLab];
        //        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.mas_equalTo(icon.mas_bottom).offset(5);
        //            make.centerX.mas_equalTo(cell.contentView);
        //            make.left.mas_equalTo(3);
        //            make.bottom.mas_equalTo(cell.contentView);
        //        }];
        titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [titleLab setBackgroundColor:UIColor.lightGrayColor];
        [titleLab setTextAlignment:NSTextAlignmentCenter];
        [titleLab setFont:[UIFont systemFontOfSize:18]];
        [titleLab setTextColor:UIColor.whiteColor];
        titleLab.numberOfLines = 0;
        self.titleLab = titleLab;
    }
    return self;
}

- (void)richElementsInCellWithModel:(NSString*)model{
    self.titleLab.text = [NSString stringWithFormat:@"%@",model];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.titleLab.alpha = highlighted ? 0.75f : 1.0f;
    
}

@end

#define kGridCellHeight   (MAINSCREEN_HEIGHT - [YBFrameTool safeAdjustTabBarHeight] - [YBFrameTool safeAdjustNavigationBarHeight] -60)
@interface DraggableCView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *originDatas;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (strong,nonatomic) DraggableCViewFlowLayout *flowLayout;

@property(nonatomic, assign) NSUInteger pageCount;
@property(nonatomic, assign) NSUInteger currentIndex;
@property (strong,nonatomic) UIPageControl * pageControl;
@property (nonatomic, copy) ActionBlock block;
@end
static CGFloat const kPadding            = 3;
@implementation DraggableCView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
//                self.contentView.backgroundColor = UIColor.whiteColor;
//                self.backgroundView = [[UIView alloc] init];
                if(_collectionView)
                {
                    [_collectionView removeFromSuperview];
                    _collectionView = nil;
                }
                
                UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
//                layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//                //设置第一个cell和最后一个cell,与父控件之间的间距
//                layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//                //设置cell行、列的间距
//                [layout setMinimumLineSpacing:0];//row5 -10
//                [layout setMinimumInteritemSpacing:0];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, [DraggableCView cellHeightWithModel]) collectionViewLayout:layout];
                [_collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"gCollectionViewCell"];
                
                [_collectionView setBackgroundColor:UIColor.clearColor];
                //如果row = 5
                _collectionView.scrollEnabled = YES;
//                _collectionView.alwaysBounceHorizontal = YES;
//                _collectionView.showsHorizontalScrollIndicator = NO;
//                _collectionView.contentSize = CGSizeMake(_collectionView.width*2, 0);
                
                [self addSubview:_collectionView];
        
        [self addSubview:self.pageControl];
        self.pageControl.hidden = true;
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom).offset(3);
            make.centerX.mas_equalTo(self.collectionView);
            make.left.equalTo(self.collectionView.mas_left).offset(0);
            make.height.mas_equalTo(37);
        }];
    }
    return self;
}

- (DraggableCViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[DraggableCViewFlowLayout alloc] init];
//        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

//        _flowLayout.itemSize = CGSizeMake((MAINSCREEN_WIDTH-kPadding*7)/6, (MAINSCREEN_WIDTH-kPadding*7)/6);

        //(self.collectionView.frame.size.height-kPadding*7)/6

        //easyError
//        _flowLayout.columns = 6;
//        _flowLayout.rows = 7;
//        _flowLayout.edgeInsets = UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding);
        _flowLayout.minimumLineSpacing = kPadding;
        _flowLayout.minimumInteritemSpacing = kPadding;
        _flowLayout.sectionInset = UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding);
//        _flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    }
    return _flowLayout;
}
+(CGFloat)cellHeightWithModel{
    return kGridCellHeight;
}
- (void)richElementsInCellWithModel:(NSDictionary*)model{
    NSInteger x =  [model[kIndexRow]intValue];
    NSInteger y =  [model[kIndexSection]intValue];
    _originDatas = [NSMutableArray arrayWithArray:model[kArr]];
    _data = [NSMutableArray arrayWithArray:model[kArr]];
    _pageCount = _data.count;
    
    //一行显示4个,3行就是12个
    while (_pageCount % 12 != 0) {
        ++_pageCount;
    }
    self.pageControl.numberOfPages = _pageCount / 12.0;
    
    
    self.flowLayout.itemSize = CGSizeMake((MAINSCREEN_WIDTH-kPadding*(x+1))/x, (self.collectionView.frame.size.height-kPadding*(y+1))/y);
    
    _collectionView.collectionViewLayout = self.flowLayout;
//    [_collectionView setHeight:[AccountTagView cellHeightWithModel:model]];
//    _collectionView.pagingEnabled = YES;
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    
    [_collectionView reloadData];
//    dispatch_async(dispatch_get_main_queue(), ^{
    //        NSLog(@"visibleCells===%@",@([self.collectionView visibleCells].count));//60
//        });
    [[DraggableCVModel new] setDataIsForceInit:YES];
//    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
//    [_collectionView addGestureRecognizer:_longPress];
}

- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    
    switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:_longPress.view]];
//                if (!selectIndexPath) {
//                    break;
//                }
                // 找到当前的cell
//                CVCell *cell = (CVCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
//                // 定义cell的时候btn是隐藏的, 在这里设置为NO
//                [cell.btnDelete setHidden:NO];
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            NSIndexPath *toIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:_longPress.view]];
            NSMutableArray *data2 = [_data objectAtIndex:toIndexPath.section];

                NSString *toIndex = [data2 objectAtIndex:toIndexPath.item];
                if ([toIndex isEqualToString: @"A 1"]
            //        &&
            //        [toIndex isEqualToString: @"A 1"]
                    ) {
                    break;
                }
            
                [self.collectionView updateInteractiveMovementTargetPosition:[_longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
                [self.collectionView endInteractiveMovement];
            break;
        }
        default: [self.collectionView cancelInteractiveMovement];
            break;
    }
}
#pragma mark --UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
//    return [[_data objectAtIndex:section] count]; //_pageCount;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
//    return _data.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
//          [collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:CellIdentifier];
//          CVCell *cell = (CVCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
          
    CVCell *cell = (CVCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"gCollectionViewCell" forIndexPath:indexPath];
    
//    NSMutableArray *fourPalaceData = [_data objectAtIndex:indexPath.section];
    [cell richElementsInCellWithModel:[NSString stringWithFormat:@"%@",_data[indexPath.row]]];
    return cell;
}
- (void)actionBlock:(ActionBlock)block
{
    self.block = block;
}
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSArray *object = [_data objectAtIndex:indexPath.section];
    if (![NSString isEmpty:_data[indexPath.row]]) {
        
        NSLog(@"点击了=====%ld",indexPath.row);
//        if (self.block) {
//            self.block(_data[indexPath.row]);
//        }
    }
}
#pragma mark - LXReorderableCollectionViewDataSource methods
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Prevent item from being moved to index 0
//    if (indexPath.section == 0
//        &&indexPath.row == 0) {
//        return NO;
//    }
    
//    NSMutableArray *data1 = [_data objectAtIndex:indexPath.section];
//
//    NSString *index = [data1 objectAtIndex:indexPath.item];
//    if ([index isEqualToString: @"A 1"]
////        &&
////        [toIndex isEqualToString: @"A 1"]
//        ) {
//        return NO;
//    }
    
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath{
//    NSMutableArray *data1 = [_data objectAtIndex:fromIndexPath.section];
//
//    NSString *fromIndex = [data1 objectAtIndex:fromIndexPath.item];
//
//    NSMutableArray *data2 = [_data objectAtIndex:toIndexPath.section];
//
//        NSString *toIndex = [data2 objectAtIndex:toIndexPath.item];
//        if ([toIndex isEqualToString: @"A 1"]
//            &&
//            [fromIndex isEqualToString: @"A 0"]
//            ) {
//            return NO;
//        }
        
        return YES;
}
//
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
#pragma mark - LXReorderableCollectionViewDataSource methods
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath willMoveToIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[DraggableCVModel new] setDataIsForceInit:NO];
//    NSMutableArray *data1 = [_data objectAtIndex:sourceIndexPath.section];
//    NSMutableArray *data2 = [_data objectAtIndex:destinationIndexPath.section];
//    NSString *index = [data1 objectAtIndex:sourceIndexPath.item];
//
//    [data1 removeObjectAtIndex:sourceIndexPath.item];
//    [data2 insertObject:index atIndex:destinationIndexPath.item];
    
    NSArray *selectModel = self.data[sourceIndexPath.item];
    [self.data removeObjectAtIndex:sourceIndexPath.item];
    [self.data insertObject:selectModel atIndex:destinationIndexPath.item];
    
//    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:_longPress.view]];
    // 找到当前的cell
//    CVCell *cell = (CVCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
//    [cell.btnDelete setHidden:YES];

    
//    NSLog(@"mmml===%@\n%lu",self.data,(unsigned long)self.data.count);
    if ([[DraggableCVModel new]compareOriginData:_originDatas withNewData:self.data]) {
        if ([UserInfoManager GetNSUserDefaults].recordedDate){
            if (self.block) {
                self.block(@(1));
            }
        }
//        NSLog(@"mmml===win==%@",[NSString currentDateComparePastDate:[UserInfoManager GetNSUserDefaults].currentDate]);
        
    }
//    [self.collectionView reloadData];

}
#pragma mark - LXReorderableCollectionViewDelegateFlowLayout methods
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"will begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"did begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
//     NSLog(@"will end drag");
   
//    [self.collectionView reloadData];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"visibleCells===%@",@([self.collectionView visibleCells].count));//60
//    });
    
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    //获得页码
    CGFloat doublePage = scrollView.contentOffset.x/MAINSCREEN_WIDTH;
    int intPage = (int)(doublePage +0.5);
    //设置页码
    self.pageControl.currentPage= intPage;
    
//    //更新pageControl的值
//    self.pageControl.currentPage = self.currentIndex;
//    //计算每次偏移的x值
//    CGFloat x = MAINSCREEN_WIDTH * self.currentIndex++;
//    [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
//    //重新更新index的值
//    if (self.currentIndex == _pageCount) self.currentIndex = 0;
    
}

- (UIPageControl *)pageControl{
    if(_pageControl==nil){
        _pageControl=[[UIPageControl alloc]init];
        _pageControl.currentPage=0;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor= YBGeneralColor.themeColor;
        [_pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
-(void)clickPageControl{
    //*********
    //根据点击的pageControl的值，来更新scrollview的contentoffset
    CGFloat x = MAINSCREEN_WIDTH * self.pageControl.currentPage;
    [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
    //更新一下currentImageIndex的值
    self.currentIndex = self.pageControl.currentPage;
}

- (void)showInView:(UIView *)contentView {
    //    if (self.accountTagView){
    //        return;
    //    }
    [contentView setNeedsUpdateConstraints];
    [contentView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView).offset(0);
            
        }];
        [contentView layoutIfNeeded];
    } completion:^(BOOL finished){
        self.alpha = 1.0;
    }];
}

- (void)disMissView {
    
    [self.superview setNeedsUpdateConstraints];
    [self.superview updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3f
                     animations:^{
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.superview).offset(-MAINSCREEN_WIDTH);
            
        }];
        [self.superview  layoutIfNeeded];
                     }
     
         completion:^(BOOL finished){
             self.alpha = 0.0;
//            [self.accountTagView removeFromSuperview];
//            self.accountTagView = nil;
         }];
}
@end


