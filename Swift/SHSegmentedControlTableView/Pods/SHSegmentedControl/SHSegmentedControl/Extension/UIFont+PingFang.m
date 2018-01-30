//
//  UIFont+PingFang.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "UIFont+PingFang.h"
#define iOS9           [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0

@implementation UIFont (PingFang)

+ (UIFont *)pingFangSCFontOfSize:(CGFloat)fontSize {
    if (iOS9) {
        return [UIFont fontWithName:@".PingFangSC-Regular" size:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)boldPingFangSCFontOfSize:(CGFloat)fontSize {
    if (iOS9) {
        return [UIFont fontWithName:@".PingFangSC-Medium" size:fontSize];
    }
    return [UIFont boldSystemFontOfSize:fontSize];
}

@end
