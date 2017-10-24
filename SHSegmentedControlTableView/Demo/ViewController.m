//
//  ViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *controllerArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"样式列表";
    
    self.dataArray = @[@"默认样式",@"涌入放大",@"右上角小标题",@"涌入放大+右上角小标题",@"导航栏透明",@"无头部",@"无bar",@"CollectionView",@"tableView+collectionView",@"下拉刷新",@"上拉加载"];
    self.controllerArray = @[@"OneViewController",@"TwoViewController",@"ThreeViewController",@"FourViewController",@"FiveViewController",@"SixViewController",@"SevenViewController",@"EightViewController",@"NineViewController",@"TenViewController",@"ZeroViewController"];


    [self.view addSubview:self.tableView];
}
#pragma mark -
#pragma mark   ==============UITableViewDataSource==============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark -
#pragma mark   ==============UITableViewDelegate==============
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *controller = [[NSClassFromString(self.controllerArray[indexPath.row]) alloc] init];
    if (controller) {
        controller.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark -
#pragma mark   ==============UI-lazy==============
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:[UIView new]];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
#pragma mark -
#pragma mark   ==============memoryWarning==============
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
