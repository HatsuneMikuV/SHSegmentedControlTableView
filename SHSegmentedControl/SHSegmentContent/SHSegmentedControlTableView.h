//
//  SHSegmentedControlTableView.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

#import "SHSegmentControl.h"
#import "SHCollectionView.h"

typedef NS_ENUM(NSInteger, SHSegmentedControlNavStyle) {
    SHSegmentedControlNavStyleNone,             // 导航栏显示
    SHSegmentedControlNavStyleHide,             // 导航栏隐藏
    SHSegmentedControlNavStyleClear,            // 导航栏透明可渐变
    SHSegmentedControlNavStyleMore,
};

@class SHPageContentView, SHSegmentedControlTableView;

@protocol SHSegTableViewDelegate <NSObject>
@optional
/** SHSegTableViewDelegate 的代理方法 */
- (void)segTableViewDidScrollY:(CGFloat)offsetY;
- (void)segTableViewDidScroll:(UIScrollView *)tableView;
- (void)segTableViewDidScrollSub:(UIScrollView *)subTableView;
- (void)segTableViewDidScrollProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

@end

@interface SHSegmentedControlTableView : UIView
/** 主容器 */
@property (nonatomic, strong) SHMAINTableView *tableView;

/** 导航栏样式 (默认SHSegmentedControlNavStyleNone) */
@property (nonatomic, assign) SHSegmentedControlNavStyle navStyle;

/** 顶部视图 */
@property (nonatomic, strong) UIView *topView;
/** 头部分栏视图 */
@property (nonatomic, strong) UIView *barView;
/** 底部分栏视图 */
@property (nonatomic, strong) UIView *footView;

/** 当前位置 */
@property (nonatomic, assign) CGFloat offsetY;

/** tableView/collectionView 数组 */
@property (nonatomic, strong) NSArray *tableViews;

/** SHSegTableViewDelegate */
@property (nonatomic, weak) id<SHSegTableViewDelegate> delegateCell;

/** 设置选中的tableView下标 */
- (void)setSegmentSelectIndex:(NSInteger)selectedIndex;
/** 刷新容器 */
- (void)reloadData;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;
/** 刷新数据 （和selectedIndex 配合使用可单一刷新index数据） */
@property (nonatomic, strong) MJRefreshHeader *refreshHeader;

@end

#pragma mark -
#pragma mark   ==============SHPageContentView==============

@protocol SHPageContentViewDelegate <NSObject>

/** SGPageContentViewDelegate 的代理方法 */
- (void)pageContentView:(SHPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

@end

@interface SHPageContentView : UIView

/**
 对象方法创建 SHPageContentView

 @param frame frame
 @param parentView 当前视图
 @param childViews 子视图个数
 */
- (instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)parentView childViews:(NSArray *)childViews;
/**
 类方法创建 SHPageContentView

 @param frame frame
 @param parentView 当前视图
 @param childViews 子视图个数
 */
+ (instancetype)pageContentViewWithFrame:(CGRect)frame parentView:(UIView *)parentView childViews:(NSArray *)childViews;

/** SGPageContentViewDelegate */
@property (nonatomic, weak) id<SHPageContentViewDelegate> delegatePageContentView;

/** 给外界提供的方法，获取 SGPageTitleView 选中按钮的下标 */
- (void)setPageCententViewCurrentIndex:(NSInteger)currentIndex;

@end

