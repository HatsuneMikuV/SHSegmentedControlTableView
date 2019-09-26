//
//  UIView+Extension_sh.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension_sh)
- (void)setSh_x:(CGFloat)sh_x
{
    CGRect frame = self.frame;
    frame.origin.x = sh_x;
    self.frame = frame;
}
- (void)setSh_y:(CGFloat)sh_y
{
    CGRect frame = self.frame;
    frame.origin.y = sh_y;
    self.frame = frame;
}

- (CGFloat)sh_x
{
    return self.frame.origin.x;
}

- (CGFloat)sh_y
{
    return self.frame.origin.y;
}
- (void)setSh_centerX:(CGFloat)sh_centerX
{
    CGPoint center = self.center;
    center.x = sh_centerX;
    self.center = center;
}

- (CGFloat)sh_centerX
{
    return self.center.x;
}
- (void)setSh_centerY:(CGFloat)sh_centerY
{
    CGPoint center = self.center;
    center.y = sh_centerY;
    self.center = center;
}

- (CGFloat)sh_centerY
{
    return self.center.y;
}

- (void)setSh_width:(CGFloat)sh_width
{
    CGRect frame = self.frame;
    frame.size.width = sh_width;
    self.frame = frame;
}

- (void)setSh_height:(CGFloat)sh_height
{
    CGRect frame = self.frame;
    frame.size.height = sh_height;
    self.frame = frame;
}

- (CGFloat)sh_height
{
    return self.frame.size.height;
}

- (CGFloat)sh_width
{
    return self.frame.size.width;
}

- (void)setSh_size:(CGSize)sh_size
{
    CGRect frame = self.frame;
    frame.size = sh_size;
    self.frame = frame;
}

- (CGSize)sh_size
{
    return self.frame.size;
}

- (void)setSh_origin:(CGPoint)sh_origin
{
    CGRect frame = self.frame;
    frame.origin = sh_origin;
    self.frame = frame;
}

- (CGPoint)sh_origin
{
    return self.frame.origin;
}
@end
