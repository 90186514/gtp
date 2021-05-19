//
//  HomeVC.m
//  gt
//
//  Created by WIQ on 2018/11/19.
//  Copyright © 2018 WIQ. All rights reserved.
//
#import "HomeVVC.h"
#import "HomeView.h"

#import "HomeVM.h"

#import "AccountCell.h"
#import "GridCell.h"
#import "HomeOrderCell.h"
#import "HomeSectionHeaderView.h"


#import "PostAdsVC.h"
#import "OrdersVC.h"
#import "DataStatisticsVC.h"
#import "ExchangeVC.h"
#import "OrderDetailVC.h"
@interface HomeVVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, assign) CFAbsoluteTime start;  //刷新数据时的时间

@property (nonatomic, strong) HomeVM *vm;

@end

@implementation HomeVVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self YBGeneral_baseConfig];
    [self initView];
    [self requestHomeListWithPage:1];
    //监听程序进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
//    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    self.navigationController.delegate = self;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)initView {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(void)netwoekingErrorDataRefush{
//    [self  requestHomeListWithPage:1];
}

#pragma mark - public requestData(HomeViewDelegate)

- (void) requestHomeListWithPage:(NSInteger)page {
   kWeakSelf(self);
    [self.vm network_getHomeListWithPage:page success:^(NSArray * _Nonnull dataArray) {
        kStrongSelf(self);
        [self requestHomeListSuccessWithArray:dataArray WithPage:page];
    } failed:^(id model){
        kStrongSelf(self);
//        [self requestHomeListSuccessWithArray:model WithPage:page];
        [self requestHomeListFailed];
    }];
}

#pragma mark - public processData
- (void)requestHomeListSuccessWithArray:(NSArray *)array WithPage:(NSInteger)page{
    //每一次刷新数据时，重置初始时间
    _start = CFAbsoluteTimeGetCurrent();
    self.currentPage = page;
    if (self.currentPage == 1) {
        [self.sections removeAllObjects];
        [self.tableView reloadData];
    }
    if (array.count > 0) {
        [self.sections addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = NO;
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.tableView.mj_footer.hidden = YES;//in 2 ways, footer no request
    }
    [self.tableView.mj_header endRefreshing];
}

- (void)requestHomeListFailed {
    self.currentPage = 0;
//    [self.sections removeAllObjects];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
#pragma mark - Sectons
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}
#pragma mark - Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section >= _sections.count) {
        section = _sections.count - 1;
    }
//    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    return [(_sections[section])[kIndexRow] count];
}

#pragma mark - SectonHeader
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section >= _sections.count) {
//        section = _sections.count - 1;
//    }
//
//    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
//    switch (type) {
//        case IndexSectionTwo:
//            return [HomeSectionHeaderView viewHeight];
//            break;
//        default:
            return 0.1f;
//            break;
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if(section >= _sections.count) {
//        section = _sections.count - 1;
//    }
//    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
//
//    switch (type) {
//        case IndexSectionTwo:{
//            NSDictionary* model = (NSDictionary*)(_sections[section]);
//            HomeSectionHeaderView * sectionHeaderView = (HomeSectionHeaderView *)[_tableView dequeueReusableHeaderFooterViewWithIdentifier:HomeSectionHeaderViewReuseIdentifier];
//            [sectionHeaderView richElementsInViewWithModel:model];
//            return  sectionHeaderView;
//        }
//            break;
//
//        default:
            return [UIView new];
//            break;
//    }
}

#pragma mark - SectonFooter
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section >= _sections.count) {
        section = _sections.count - 1;
    }
    
    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    
    switch (type) {
        case IndexSectionZero:
            return 12.f;
            break;
        case IndexSectionOne:
            return [HomeSectionHeaderView viewHeight];
            break;
        case IndexSectionTwo:
            return .1f;
            break;
        default:
            return 0.1f;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section >= _sections.count) {
        section = _sections.count - 1;
    }
    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    
    switch (type) {
        case IndexSectionOne:{
            NSDictionary* model = (NSDictionary*)(_sections[section]);
            HomeSectionHeaderView * sectionHeaderView = (HomeSectionHeaderView *)[_tableView dequeueReusableHeaderFooterViewWithIdentifier:HomeSectionHeaderViewReuseIdentifier];
            [sectionHeaderView richElementsInViewWithModel:model];
            return  sectionHeaderView;
        }
            break;
            
        default:
            return [UIView new];
            break;
            
    }
}
#pragma mark - cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    
    NSInteger section = indexPath.section;
    if(section >= _sections.count)
    section = _sections.count - 1;
    
    IndexSectionType type = [_sections[section][kIndexSection] integerValue];
    id itemData = ((_sections[section])[kIndexRow])[indexPath.row];
    switch (type) {
        case IndexSectionZero:
        {
            AccountCell *cell = [AccountCell cellWith:tableView];
            [cell richElementsInCellWithModel:itemData];
            return cell;
            
        }
            break;
        case IndexSectionOne:
        {
            GridCell *cell = [GridCell cellWith:tableView];
            [cell richElementsInCellWithModel:itemData];
            [cell actionBlock:^(NSDictionary *dataModel) {
                EnumActionTag type = [dataModel[kType] integerValue];
                [self clickEvent:@(type) withData:itemData];
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
            break;
        case IndexSectionTwo:
        {
            HomeOrderCell *cell = [HomeOrderCell cellWith:tableView];
            NSInteger second = [itemData integerValue] - round(CFAbsoluteTimeGetCurrent()-_start);
//            WData* wData = (WData*)itemData;
            [cell richElementsInCellWithModel:second];
            return cell;
            
        }
            break;
        default:{
//            BaseCell *cell = [BaseCell cellWith:tableView];
//            cell.hideSeparatorLine = YES;
//            cell.frame = CGRectZero;
//            return cell;
       static NSString *name=@"defaultCell";
                               
       UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:name];
           
       if (cell==nil) {
           cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
       }
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
       cell.frame = CGRectZero;

       return cell;
        }
            break;
    }
}

#pragma mark - heightForRow
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if(section >= _sections.count)
    section = _sections.count - 1;
    
    IndexSectionType type = [_sections[section][kIndexSection] integerValue];
    id itemData = ((_sections[section])[kIndexRow])[indexPath.row];
    switch (type) {
        case IndexSectionZero:
            return [AccountCell cellHeightWithModel];
            break;
            
        case IndexSectionOne:
            return [GridCell cellHeightWithModel:itemData];
            break;
        case IndexSectionTwo:
        {
            NSInteger second = [itemData integerValue] - round(CFAbsoluteTimeGetCurrent()-_start);
            return [HomeOrderCell cellHeightWithModel:second];
        }
            break;
        default:
            return 0;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if(section >= _sections.count)
        section = _sections.count - 1;
    
    IndexSectionType type = [_sections[section][kIndexSection] integerValue];
    id itemData = ((_sections[section])[kIndexRow])[indexPath.row];
    switch (type) {
        
        case IndexSectionTwo:
        {
            [self clickEvent:@(EnumActionTag4) withData:itemData];
        }
            break;
        default:
            
            break;
    }
}
#pragma mark - clickEvent
- (void)clickEvent:(id) data withData:(id)data2{
    EnumActionTag type = [data integerValue];
    switch (type) {
        case EnumActionTag0:
        {
            [PostAdsVC pushFromVC:self requestParams:@(PostAdsTypeCreate) success:^(id data) {
                
            }];
        }
            break;
        case EnumActionTag1:
        {
            [OrdersVC pushFromVC:self];
        }
            break;
        case EnumActionTag2:
        {
            [DataStatisticsVC pushFromVC:self];
        }
            break;
        case EnumActionTag3:
        {
            [ExchangeVC pushFromVC:self];
        }
            break;
        case EnumActionTag4:
        {
            OrderDetailVC *moreVc = [[OrderDetailVC alloc] init];
            [self.navigationController pushViewController:moreVc animated:YES];
//                [OrderDetailVC pushViewController:self requestParams:data2 success:^(id data) {
//
//                }];
        }
            break;
        default:
            
            break;
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView YBGeneral_configuration];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [HomeSectionHeaderView sectionHeaderViewWith:_tableView];
//        [_tableView registerClass:[HomeSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"HomeSectionHeaderView"];
       kWeakSelf(self);
       [_tableView addMJHeaderWithBlock:^{
                    kStrongSelf(self);
                    self.currentPage = 1;
                    [self requestHomeListWithPage:self.currentPage];
        }];
        
       [_tableView addMJFooterWithBlock:^{
                    kStrongSelf(self);
                    ++self.currentPage;
                    [self requestHomeListWithPage:self.currentPage];
        }];
    }
    return _tableView;
}

- (NSUInteger)currentPage {
    if (!_currentPage) {
        _currentPage = 0;
    }
    return _currentPage;
}

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (HomeVM *)vm {
    if (!_vm) {
        _vm = [HomeVM new];
    }
    return _vm;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
