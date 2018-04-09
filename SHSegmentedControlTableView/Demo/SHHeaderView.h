//
//  SHHeaderView.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/4/9.
//  Copyright © 2018 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHHeaderView : UIView

@property (nonatomic, copy) void(^scaleHeaderBlock)(CGFloat scaleH);

@end
