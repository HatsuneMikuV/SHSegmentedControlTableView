//
//  FiveViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/23.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "FiveViewController.h"

#import "TestOneTableView.h"

@interface FiveViewController ()<SHSegTableViewDelegate>

@property (nonatomic, strong) SHSegmentedControlTableView *segTableView;

@property (nonatomic, strong) SHSegmentControl *segmentControl;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation FiveViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_reset];
    CGFloat currentContentOffset = self.segTableView.offsetY;
    if (currentContentOffset > self.headerView.height - 64) {
        [self tableViewScrollSet:2 withOffset:0];
    }else if(currentContentOffset <= 0){
        [self tableViewScrollSet:3 withOffset:0];
    }else{
        [self tableViewScrollSet:1 withOffset:currentContentOffset];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar lt_reset];
    CGFloat currentContentOffset = self.segTableView.offsetY;
    if (currentContentOffset > self.headerView.height - 64) {
        [self tableViewScrollSet:2 withOffset:0];
    }else if(currentContentOffset <= 0){
        [self tableViewScrollSet:3 withOffset:0];
    }else{
        [self tableViewScrollSet:1 withOffset:currentContentOffset];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TestOneTableView *tab1 = [[TestOneTableView alloc] init];
    tab1.num = 15;
    tab1.label = @"一";
    TestOneTableView *tab2 = [[TestOneTableView alloc] init];
    tab2.num = 5;
    tab2.label = @"二";
    TestOneTableView *tab3 = [[TestOneTableView alloc] init];
    tab3.num = 30;
    tab3.label = @"三";
    
    [self.segTableView setTableViews:@[tab1,tab2,tab3]];
    
    [self.view addSubview:self.segTableView];
    
}
- (void)tableViewScrollSet:(NSInteger)type withOffset:(CGFloat)offset {
    if (type == 1) {
        
        CGFloat scrollSet = self.headerView.height - 64;
        
        CGFloat alpha = offset / scrollSet;
        //设置头部视图的模糊效果
        [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
        
        if (alpha == 1.0) {
            self.navigationItem.title = @"导航栏滑动透明";
            [self.navigationController.navigationBar setShadowImage:nil];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        }else{
            self.navigationItem.title = @"";
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }
    }else if (type == 2) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]];
        [self.navigationController.navigationBar setShadowImage:nil];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationItem.title = @"导航栏滑动透明";
    }else if (type == 3) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.0]];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.navigationItem.title = @"";
    }
}
#pragma mark -
#pragma mark   ==============SHSegTableViewDelegate==============
- (void)segTableViewDidScrollY:(CGFloat)offsetY {
    NSInteger type;
    if (offsetY > self.headerView.height - 64) {
        type = 2;
    }else if (offsetY <= 0){
        type = 3;
    }else {
        type = 1;
    }
    [self tableViewScrollSet:type withOffset:offsetY];
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
        _segTableView.isNavClear = YES;
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
