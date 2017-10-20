//
//  SHTableView.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SHTableViewDelegate <NSObject>

- (void)SHTableViewScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface SHTableView : UITableView

@property (nonatomic, weak) id<SHTableViewDelegate> delegateSHTableView;

@end

@interface SHMAINTableView : UITableView

@end
