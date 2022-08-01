//
//  UIColor+Plugin.m
//  demoApp
//
//  Created by xiaokangyan on 2022/8/1.
//

#import "UIColor+Plugin.h"

@implementation UIColor(Plugin)

+ (UIColor *)colorWithRGBHex:(NSInteger)colorHex {
    CGFloat r = ((0xff0000 & colorHex) >> 16) / 255.0;
    CGFloat g = ((0x00ff00 & colorHex) >> 8) / 255.0;
    CGFloat b = (0x0000ff & colorHex) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
