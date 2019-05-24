//
//  SHHeaderView.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/4/9.
//  Copyright © 2018 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHHeaderView : UIView

/**
 更改头部图片放大，用到外部滑动的距离
 */
@property (nonatomic, copy) void(^scaleHeaderBlock)(CGFloat scaleH);

@end


@interface SHHeaderOneView : UIView


/**
 更改头部高度时，通知外面重新set头部
 */
@property (nonatomic, copy) void(^changeHeightBlock)(void);

@end
