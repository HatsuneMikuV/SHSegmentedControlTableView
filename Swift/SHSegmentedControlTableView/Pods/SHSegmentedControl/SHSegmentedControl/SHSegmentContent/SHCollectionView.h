//
//  SHCollectionView.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHTableView.h"

/**
 容器内容视图，处理手势
 */
@interface SHCollectionView : UICollectionView

@property (nonatomic, weak) id<SHTableViewDelegate> delegateSHTableView;

@end

/**
 主容器，处理手势
 */
@interface SHTapCollectionView : UICollectionView

@end
