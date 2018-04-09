//
//  ThirteenViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/4/9.
//  Copyright © 2018 angle. All rights reserved.
//

#import "ThirteenViewController.h"
#import "TestOneTableView.h"
#import "SHHeaderView.h"

@interface ThirteenViewController ()<SHSegTableViewDelegate>

@property (nonatomic, strong) SHSegmentedControlTableView *segTableView;

@property (nonatomic, strong) SHSegmentControl *segmentControl;

@property (nonatomic, strong) SHHeaderView *headerView;

@end

@implementation ThirteenViewController

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
#pragma mark -
#pragma mark   ==============SHSegTableViewDelegate==============
- (void)segTableViewDidScrollY:(CGFloat)offsetY {
    NSLog(@"%f", offsetY);
    if (offsetY <= 0 && self.headerView.scaleHeaderBlock) {
        self.headerView.scaleHeaderBlock(0 - offsetY);
    }
}
- (void)segTableViewDidScroll:(UIScrollView *)tableView {
    
}
- (void)segTableViewDidScrollSub:(UIScrollView *)subTableView {
    
}
- (void)segTableViewDidScrollProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    if (progress == 1) {
        [self.segmentControl setSegmentSelectedIndex:targetIndex];
    }
}
#pragma mark -
#pragma mark   ==============UI-lazy==============
- (SHHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[SHHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _headerView;
}
- (SHSegmentControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) items:@[@"分栏一",@"分栏二",@"分栏三"]];
        _segmentControl.titleSelectColor = [UIColor redColor];
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
