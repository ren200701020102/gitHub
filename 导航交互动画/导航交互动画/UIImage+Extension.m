//
//  UIImage+Extension.m
//  隐藏导航栏
//
//  Created by 任海平 on 16/7/30.
//  Copyright © 2016年 任海平. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
/**
 *  生成导航栏背景图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage*) navBackImage:(UIColor*)color{
    
    CGFloat width = ScreenWidth;
    CGFloat height = 64;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, YES);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [[color colorWithAlphaComponent:0.4]set];
    
    CGContextFillRect(ctx, CGRectMake(0, 0, width, height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

@end
