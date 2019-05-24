//
//  SHSegmentedControlTableView.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "SHSegmentedControlTableView.h"


#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark -
#pragma mark   =======================================================
#pragma mark   ==============SHSegmentedControlTableView==============
@interface SHSegmentedControlTableView()<UITableViewDelegate,UITableViewDataSource,SHTableViewDelegate,SHPageContentViewDelegate>

@property (nonatomic, strong) SHPageContentView *pageContentView;

@property (nonatomic, strong) UIScrollView *childVCScrollView;

@property (nonatomic, assign) NSInteger index;

@end

@implementation SHSegmentedControlTableView

#pragma mark -
#pragma mark   ==============Init==============
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initialization];
        [self setupSubviews];
    }
    return self;
}
- (void)initialization
{
    self.index = 0;
    self.navStyle = SHSegmentedControlNavStyleNone;
}
- (void)setupSubviews
{
    self.tableView = [[SHMAINTableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.editing = NO;
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 0;
    _tableView.rowHeight = self.height;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
}
#pragma mark -
#pragma mark   ==============Public==============
- (void)setSegmentSelectIndex:(NSInteger)selectedIndex {
    self.index = selectedIndex;
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}
#pragma mark -
#pragma mark   ==============set==============
- (void)setTopView:(UIView *)topView {
    _topView = topView;
    [self.tableView setTableHeaderView:topView];
}
- (void)setBarView:(UIView *)barView {
    _barView = barView;
    self.tableView.sectionHeaderHeight = barView.height;
    self.tableView.rowHeight = self.height - self.tableView.sectionHeaderHeight - self.tableView.sectionFooterHeight;
    [self.tableView reloadData];
}
- (void)setFootView:(UIView *)footView {
    _footView = footView;
    self.tableView.sectionFooterHeight = footView.height;
    self.tableView.rowHeight = self.height - self.tableView.sectionHeaderHeight - self.tableView.sectionFooterHeight;
    [self.tableView reloadData];
}
- (void)setTableViews:(NSArray *)tableViews {
    _tableViews = tableViews;
    
    for (SHTableView *tabView in tableViews) {
        tabView.delegateSHTableView = self;
        [tabView reloadData];
    }
    CGFloat contentViewHeight = self.height - self.tableView.sectionHeaderHeight - self.tableView.sectionFooterHeight;
    
    if (self.navStyle == SHSegmentedControlNavStyleNone) {
        contentViewHeight -= (kDevice_Is_iPhoneX ? 88:64);
    }
    self.pageContentView = [[SHPageContentView alloc] initWithFrame:CGRectMake(0, 0, self.width, contentViewHeight) parentView:self childViews:tableViews];
    self.pageContentView.delegatePageContentView = self;
    
    [self.tableView reloadData];
}
#pragma mark -
#pragma mark   ==============数据刷新==============
- (void)setRefreshHeader:(MJRefreshHeader *)refreshHeader {
    _refreshHeader = refreshHeader;
    if (refreshHeader) self.tableView.mj_header = refreshHeader;
}
- (NSInteger)selectedIndex {
    return self.index;
}
#pragma mark -
#pragma mark   ==============get==============
- (CGFloat)offsetY {
    if (self.childVCScrollView.contentOffset.y > 0) {
        return self.tableView.contentOffset.y + self.childVCScrollView.contentOffset.y;
    }
    return self.tableView.contentOffset.y;
}
- (void)reloadData {
    [self.tableView reloadData];
}
#pragma mark -
#pragma mark   ==============UITableViewDataSource==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    [cell.contentView addSubview:self.pageContentView];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.barView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childVCScrollView && _childVCScrollView.contentOffset.y > 0) {
        self.tableView.contentOffset = CGPointMake(0, self.topView.height);
    }
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat navHeight = (kDevice_Is_iPhoneX ? 88:64);
    if (self.navStyle == SHSegmentedControlNavStyleClear) {
        if (offSetY <= self.topView.height - self.barView.height - navHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else  {
            scrollView.contentInset = UIEdgeInsetsMake(navHeight, 0, 0, 0);
        }
    }else if (self.navStyle == SHSegmentedControlNavStyleHide) {
        if (offSetY <= self.topView.height && offSetY >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else if (offSetY >= self.topView.height) {
            scrollView.contentInset = UIEdgeInsetsMake(navHeight, 0, 0, 0);
        }
    }
    if (offSetY < self.topView.height) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pageTitleViewToTop" object:nil];
    }
    if (self.delegateCell && [self.delegateCell respondsToSelector:@selector(segTableViewDidScrollY:)]) {
        if (offSetY >= self.topView.height) {
            offSetY += self.childVCScrollView.contentOffset.y;
        }
        [self.delegateCell segTableViewDidScrollY:offSetY];
    }
    if (self.delegateCell && [self.delegateCell respondsToSelector:@selector(segTableViewDidScroll:)]) {
        [self.delegateCell segTableViewDidScroll:scrollView];
    }
}
#pragma mark -
#pragma mark   ==============SHTableViewDelegate==============
- (void)SHTableViewScrollViewDidScroll:(UIScrollView *)scrollView {
    self.childVCScrollView = scrollView;
    if (self.tableView.contentOffset.y < self.topView.height) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    } else {
        self.tableView.contentOffset = CGPointMake(0, self.topView.height);
        scrollView.showsVerticalScrollIndicator = YES;
    }
    if (self.delegateCell && [self.delegateCell respondsToSelector:@selector(segTableViewDidScrollSub:)]) {
        [self.delegateCell segTableViewDidScrollSub:scrollView];
    }
}
#pragma mark -
#pragma mark   ==============SHPageContentViewDelegate==============
- (void)pageContentView:(SHPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    self.index = targetIndex;
    if (self.delegateCell && [self.delegateCell respondsToSelector:@selector(segTableViewDidScrollProgress:originalIndex:targetIndex:)]) {
        [self.delegateCell segTableViewDidScrollProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    }
}

@end

#pragma mark -
#pragma mark   =======================================================
#pragma mark   ===================SHPageContentView===================

@interface SHPageContentView () <UICollectionViewDataSource, UICollectionViewDelegate>
/// 外界父视图
@property (nonatomic, weak) UIView *parentView;
/// 存储子视图
@property (nonatomic, strong) NSArray *childViews;
/// collectionView
@property (nonatomic, strong) SHTapCollectionView *collectionView;
/// 记录刚开始时的偏移量
@property (nonatomic, assign) NSInteger startOffsetX;
/// 标记按钮是否点击
@property (nonatomic, assign) BOOL isClickBtn;

@end

@implementation SHPageContentView

#pragma mark -
#pragma mark   ==============Init==============
- (instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)parentView childViews:(NSArray *)childViews {
    if (self = [super initWithFrame:frame]) {
        if (parentView == nil) {
            @throw [NSException exceptionWithName:@"SHGPagingView" reason:@"SHGPageContentView 所在父视图必须设置" userInfo:nil];
        }
        self.parentView = parentView;
        if (childViews == nil) {
            @throw [NSException exceptionWithName:@"SHGPagingView" reason:@"SHGPageContentView 子视图必须设置" userInfo:nil];
        }
        self.childViews = childViews;
        
        [self initialization];
        [self setupSubviews];
    }
    return self;
}
+ (instancetype)pageContentViewWithFrame:(CGRect)frame parentView:(UIView *)parentView childViews:(NSArray *)childViews {
    return [[self alloc] initWithFrame:frame parentView:parentView childViews:childViews];
}

- (void)initialization {
    self.isClickBtn = NO;
    self.startOffsetX = 0;
}

- (void)setupSubviews {
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    
    //添加UICollectionView, 用于在Cell中存放控制器的View
    [self addSubview:self.collectionView];
}

- (SHTapCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat collectionViewX = 0;
        CGFloat collectionViewY = 0;
        CGFloat collectionViewW = self.width;
        CGFloat collectionViewH = self.height;
        _collectionView = [[SHTapCollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

#pragma mark -
#pragma mark   ==============UICollectionViewDataSource==============
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *view = self.childViews[indexPath.item];
    view.frame = cell.contentView.frame;
    [cell.contentView addSubview:view];
    return cell;
}

#pragma mark -
#pragma mark   ==============UICollectionViewDelegate==============
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isClickBtn = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isClickBtn == YES) {
        return;
    }
    // 1、定义获取需要的数据
    CGFloat progress = 0;
    NSInteger originalIndex = 0;
    NSInteger targetIndex = 0;
    // 2、判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > self.startOffsetX + 25) { // 左滑
        // 1、计算 progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        // 2、计算 originalIndex
        originalIndex = currentOffsetX / scrollViewW;
        // 3、计算 targetIndex
        targetIndex = originalIndex + 1;
        if (targetIndex >= self.childViews.count) {
            progress = 1;
            targetIndex = originalIndex;
        }
        // 4、如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = originalIndex;
        }
    } else if (currentOffsetX < self.startOffsetX - 25) { // 右滑
        // 1、计算 progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        // 2、计算 targetIndex
        targetIndex = currentOffsetX / scrollViewW;
        // 3、计算 originalIndex
        originalIndex = targetIndex + 1;
        if (originalIndex >= self.childViews.count) {
            originalIndex = self.childViews.count - 1;
        }
    }
    // 3、pageContentViewDelegare; 将 progress／sourceIndex／targetIndex
    if (self.delegatePageContentView && [self.delegatePageContentView respondsToSelector:@selector(pageContentView:progress:originalIndex:targetIndex:)]) {
        [self.delegatePageContentView pageContentView:self progress:progress originalIndex:originalIndex targetIndex:targetIndex];
    }
}

#pragma mark -
#pragma mark   ==============给外界提供的方法，获取 SHPageTitleView 选中按钮的下标==============
- (void)setPageCententViewCurrentIndex:(NSInteger)currentIndex {
    self.isClickBtn = YES;
    CGFloat offsetX = currentIndex * self.collectionView.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

@end

