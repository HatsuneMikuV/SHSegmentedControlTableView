//
//  NineteenViewController.m
//  SHSegmentedControlTableView
//
//  Created by Joe on 2019/6/21.
//  Copyright © 2019 angle. All rights reserved.
//

#import "NineteenViewController.h"

#import "TestOneTableView.h"

@interface NineteenViewController ()<SHSegTableViewDelegate>

@property (nonatomic, strong) SHSegmentedControlTableView *segTableView;

@property (nonatomic, strong) SHSegmentControl *segmentControl;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *toolView;

@end

@implementation NineteenViewController

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
    //预留空间  toolView大小
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KIPhoneXBottom)];
    [tab3 setTableFooterView:footer];
    
    [self.segTableView setTableViews:@[tab1,tab2,tab3]];
    
    [self.view addSubview:self.segTableView];
    
    [self.segTableView addSubview:self.toolView];
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
        [self reloadToolViewShow:(targetIndex == 2)];
    }
}
#pragma mark -
#pragma mark ==============Tools Show==============
- (void)reloadToolViewShow:(BOOL)isShow
{
    if (isShow) {
        [UIView animateWithDuration:0.25 animations:^{
            self.toolView.frame = CGRectMake(0, self.view.sh_height - KIPhoneXBottom, SCREEN_WIDTH, KIPhoneXBottom);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.toolView.frame = CGRectMake(0, self.view.sh_height, SCREEN_WIDTH, KIPhoneXBottom);
        }];
    }
}
#pragma mark -
#pragma mark   ==============UI-lazy==============
- (UIView *)toolView
{
    if (_toolView == nil) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.sh_height, SCREEN_WIDTH, KIPhoneXBottom)];
        _toolView.backgroundColor = UIColor.orangeColor;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(12, 8, SCREEN_WIDTH - 24, KIPhoneTabBar - 16)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"请输入内容";
        [_toolView addSubview:textField];
    }
    return _toolView;
}
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
        _segmentControl.titleSelectColor = [UIColor redColor];
        [_segmentControl reloadViews];
        __weak __typeof(&*self)weakSelf = self;
        _segmentControl.curClick = ^(NSInteger index) {
            [weakSelf.segTableView setSegmentSelectIndex:index];
            [weakSelf reloadToolViewShow:(index == 2)];
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
