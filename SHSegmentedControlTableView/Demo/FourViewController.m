
//
//  FourViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/20.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "FourViewController.h"

#import "TestOneTableView.h"

@interface FourViewController ()<SHSegTableViewDelegate>

@property (nonatomic, strong) SHSegmentedControlTableView *segTableView;

@property (nonatomic, strong) SHSegmentControl *segmentControl;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation FourViewController

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
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.backgroundColor = [UIColor purpleColor];
    }
    return _headerView;
}
- (SHSegmentControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) items:@[@"分栏一",@"分栏二",@"分栏三"]];
        _segmentControl.type = SHSegmentControlTypeWaterSubTitle;
        [_segmentControl reloadViews];
        _segmentControl.reloadSubTitleBlock = ^(UILabel * _Nullable titleLabel, UILabel * _Nullable subLabel) {
            //右侧
//            subLabel.frame = CGRectMake(titleLabel.x + titleLabel.width, titleLabel.centerY - subLabel.height * 0.5, subLabel.width, subLabel.height);
            //左侧
//            subLabel.frame = CGRectMake(titleLabel.x - subLabel.width, titleLabel.centerY - subLabel.height * 0.5, subLabel.width, subLabel.height);
            //上侧
//            subLabel.frame = CGRectMake(titleLabel.centerX - subLabel.width * 0.5, titleLabel.y - subLabel.height, subLabel.width, subLabel.height);
            //下侧
//            subLabel.frame = CGRectMake(titleLabel.centerX - subLabel.width * 0.5, titleLabel.y + titleLabel.height + subLabel.height, subLabel.width, subLabel.height);
        };
        [_segmentControl setItmesSubTitle:@[@"15.5万",@"5000",@"30万"]];
        [_segmentControl setSegmentSelectedIndex:0];
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
