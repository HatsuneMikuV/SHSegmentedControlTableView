//
//  TestCollectionView.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/23.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "TestCollectionView.h"
@interface TestCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *colors;


@end

@implementation TestCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setNum:(NSInteger)num {
    _num = num;
    [self reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
        self.num = 0;
        self.colors = @[[UIColor brownColor],
                        [UIColor grayColor],
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor cyanColor],
                        [UIColor yellowColor],
                        [UIColor magentaColor],
                        [UIColor orangeColor],
                        [UIColor purpleColor]];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}
#pragma mark -
#pragma mark   ==============UICollectionViewDataSource==============
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.num;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [self.colors objectAtIndex:(arc4random()%self.colors.count)];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld-%ld",indexPath.section,indexPath.item);
}
@end
