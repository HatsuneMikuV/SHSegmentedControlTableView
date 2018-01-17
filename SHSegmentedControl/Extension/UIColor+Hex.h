//
//  UIColor+Hex.h
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

//随机色
+ (UIColor *)colorArc4random;

//从十六进制字符串获取颜色，
+ (UIColor *)colorWithHexString:(NSString *)color;

//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//渐变色
+ (UIColor *)alw_getColorOfPercent:(CGFloat)percent between:(UIColor *)color1 and:(UIColor *)color2;

@end
