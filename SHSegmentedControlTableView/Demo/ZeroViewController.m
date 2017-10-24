//
//  ZeroViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/23.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "ZeroViewController.h"

#import "TestOneTableView.h"

@interface ZeroViewController ()<SHSegTableViewDelegate>

@property (nonatomic, strong) SHSegmentedControlTableView *segTableView;

@property (nonatomic, strong) SHSegmentControl *segmentControl;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation ZeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //-----------------------------------------------------------------
    TestOneTableView *tab1 = [[TestOneTableView alloc] init];
    tab1.num = 15;
    tab1.label = @"一";
    MJRefreshAutoNormalFooter *mj_footer1 = [[MJRefreshAutoNormalFooter alloc] init];
    __weak __typeof(&*mj_footer1)weakMj_footer1 = mj_footer1;
    [mj_footer1 setRefreshingBlock:^{
        tab1.num += 2;
        [weakMj_footer1 endRefreshing];
    }];
    [tab1 setMj_footer:mj_footer1];
    //-----------------------------------------------------------------
    TestOneTableView *tab2 = [[TestOneTableView alloc] init];
    tab2.num = 5;
    tab2.label = @"二";
    //-----------------------------------------------------------------
    TestOneTableView *tab3 = [[TestOneTableView alloc] init];
    tab3.num = 30;
    tab3.label = @"三";
    MJRefreshAutoNormalFooter *mj_footer3 = [[MJRefreshAutoNormalFooter alloc] init];
    __weak __typeof(&*mj_footer1)weakMj_footer3 = mj_footer3;
    [mj_footer3 setRefreshingBlock:^{
        if (tab3.num >= 2) {
            tab3.num -= 2;
        }
        if (tab3.num == 0) {
            [weakMj_footer3 endRefreshingWithNoMoreData];
        }else {
            [weakMj_footer3 endRefreshing];
        }
    }];
    [tab3 setMj_footer:mj_footer3];
    //-----------------------------------------------------------------
    [self.segTableView setTableViews:@[tab1,tab2,tab3]];
    [self.view addSubview:self.segTableView];
}
#pragma mark -
#pragma mark   ==============SHSegTableViewDelegate==============
- (void)segTableViewDidScrollY:(CGFloat)offsetY {
    
}
- (void)segTableViewDidScroll:(UIScrollView *)tableView {
    
}
- (void)segTableViewDidScrollSub:(UIScrollView *)subTableView {
    
}
- (void)segTableViewDidScrollProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    if (progress == 1) {
        self.segmentControl.index = targetIndex;
    }
}
#pragma mark -
#pragma mark   ==============UI-lazy==============
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.backgroundColor = [UIColor purpleColor];
    }
    return _headerView;
}
- (SHSegmentControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) items:@[@"分栏一",@"分栏二",@"分栏三"]];
        [_segmentControl reloadViews];
        __weak __typeof(&*self)weakSelf = self;
        _segmentControl.curClick = ^(NSInteger index) {
            [weakSelf.segTableView setSegmentSelectIndex:index];
        };
    }
    return _segmentControl;
}
- (SHSegmentedControlTableView *)segTableView {
    if (!_segTableView) {
        _segTableView = [[SHSegmentedControlTableView alloc] initWithFrame:self.view.bounds];
        _segTableView.delegateCell = self;
        [_segTableView setTopView:self.headerView];
        [_segTableView setBarView:self.segmentControl];
    }
    return _segTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
