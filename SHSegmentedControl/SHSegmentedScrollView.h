//
//  SHSegmentedScrollView.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/1/9.
//  Copyright © 2018年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MJRefresh/MJRefresh.h>

#import "SHSegmentControl.h"

@class SHSegmentedScrollView;

@protocol SHSegmentedScrollViewDelegate <NSObject>

@optional
/** SHSegmentedScrollViewDelegate 的代理方法 */
- (void)scrollViewDidScrollIndex:(NSInteger)index;

@end

@interface SHSegmentedScrollView : UIView

/** 顶部视图 */
@property (nonatomic, strong) UIView *topView;
/** 头部分栏视图 */
@property (nonatomic, strong) UIView *barView;
/** 底部分栏视图 */
@property (nonatomic, strong) UIView *footView;

/** tableView/collectionView/view 数组 */
@property (nonatomic, strong) NSArray *tableViews;

/** SHSegmentedScrollViewDelegate */
@property (nonatomic, weak) id<SHSegmentedScrollViewDelegate> delegateCell;

/** 设置选中的tableView下标 */
- (void)setSegmentSelectIndex:(NSInteger)selectedIndex;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;
/** 刷新数据 （和selectedIndex 配合使用可单一刷新index数据） */
@property (nonatomic, strong) MJRefreshHeader *refreshHeader;

@end
