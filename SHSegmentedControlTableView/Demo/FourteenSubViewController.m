//
//  FourteenSubViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/5/22.
//  Copyright © 2018 angle. All rights reserved.
//

#import "FourteenSubViewController.h"

#import <SHTableView.h>

@interface FourteenSubViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation FourteenSubViewController

- (void)loadView {
    [super loadView];
    
    SHTableView *tableView = [[SHTableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    tableView.tableFooterView = [[UIView alloc] init];
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark -
#pragma mark   ==============UITableViewDataSource==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"addChildViewController--%@", @(indexPath.row)];
    return cell;
}
#pragma mark -
#pragma mark   ==============UITableViewDelegate==============
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"当前点击的cell--%@", @(indexPath.row));
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    SHTableView *tableView = (SHTableView *)self.view;
    if ([tableView isKindOfClass:[SHTableView class]]) {
        [tableView scrollViewDidScroll];
    }
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
