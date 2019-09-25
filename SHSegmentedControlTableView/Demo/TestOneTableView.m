//
//  TestOneTableView.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/19.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "TestOneTableView.h"

@interface TestOneTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestOneTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setLabel:(NSString *)label {
    _label = label;
    [self reloadData];
}
- (void)setNum:(NSInteger)num {
    _num = num;
    [self reloadData];
}
- (instancetype)init {
    if (self = [super init]) {
        self.num = 0;
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 45;
        self.tableFooterView = [[UIView alloc] init];
        [self registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld-%ld",self.label,indexPath.section,indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
    }

@end
