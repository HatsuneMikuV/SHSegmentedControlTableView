//
//  SHTableView.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 处理手势代理事件
 */
@protocol SHTableViewDelegate <NSObject>

- (void)SHTableViewScrollViewDidScroll:(UIScrollView *)scrollView;

@end


/**
 容器内容视图，处理手势
 */
@interface SHTableView : UITableView

@property (nonatomic, weak) id<SHTableViewDelegate> delegateSHTableView;

/**
 用于重设delegate后，必须实现scrollViewDidScroll:代理事件
 并回调给自身处理滑动手势
 */
- (void)scrollViewDidScroll;

@end

/**
 主容器，处理手势
 */
@interface SHMAINTableView : UITableView

@end
