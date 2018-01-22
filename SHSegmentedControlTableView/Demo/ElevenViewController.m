//
//  ElevenViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/1/22.
//  Copyright © 2018年 angle. All rights reserved.
//

#import "ElevenViewController.h"

#import "SHSegmentedScrollView.h"

@interface ElevenViewController ()<UITableViewDataSource,UITableViewDelegate,SHSegmentedScrollViewDelegate>

@property (nonatomic, strong) SHSegmentedScrollView *segScrollView;

@property (nonatomic, strong) SHSegmentControl *segmentControl;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation ElevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *views = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 3; index++) {
        UITableView *table = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.tag = 2018 + index;
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.allowsSelection = NO;
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"cell%ld",index]];
            [tableView setTableFooterView:[UIView new]];
            tableView;
        });
        [views addObject:table];
    }
    
    [self.segScrollView setTableViews:views];
    
    [self.view addSubview:self.segScrollView];
    
}
#pragma mark -
#pragma mark   ==============UITableViewDataSource==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 2018) {
        return 30;
    }else if (tableView.tag == 2019){
        return 5;
    }else {
        return 15;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 2018) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        cell.textLabel.text = [NSString stringWithFormat:@"00000----%ld",indexPath.row];
        return cell;
    }else if (tableView.tag == 2019){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.textLabel.text = [NSString stringWithFormat:@"11111----%ld",indexPath.row];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.textLabel.text = [NSString stringWithFormat:@"22222----%ld",indexPath.row];
        return cell;
    }
}
#pragma mark -
#pragma mark   ==============SHSegmentedScrollViewDelegate==============
- (void)scrollViewDidScrollIndex:(NSInteger)index {
    if (index != self.segmentControl.selectIndex) {
        [self.segmentControl setSegmentSelectedIndex:index];
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
        _segmentControl.titleSelectColor = [UIColor redColor];
        [_segmentControl reloadViews];
        __weak __typeof(&*self)weakSelf = self;
        _segmentControl.curClick = ^(NSInteger index) {
            [weakSelf.segScrollView setSegmentSelectIndex:index];
        };
    }
    return _segmentControl;
}
- (SHSegmentedScrollView *)segScrollView {
    if (!_segScrollView) {
        CGFloat nacHeight = 44 + [UIApplication sharedApplication].statusBarFrame.size.height;
        _segScrollView = [[SHSegmentedScrollView alloc] initWithFrame:CGRectMake(0, nacHeight, SCREEN_WIDTH, SCREEN_HEIGHT - nacHeight)];
        _segScrollView.delegateCell = self;
        [_segScrollView setTopView:self.headerView];
        [_segScrollView setBarView:self.segmentControl];
    }
    return _segScrollView;
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
