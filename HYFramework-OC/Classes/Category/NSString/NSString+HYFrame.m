//
//  NSString+HYFrame.m
//  GJKJAPP
//
//  Created by 臻尚 on 2021/3/22.
//  Copyright © 2021 谭耀焯. All rights reserved.
//

#import "NSString+HYFrame.h"

@implementation NSString (HYFrame)

/**
 * 计算文本宽度
 * @param font 文本控件的字体
 * @return 文本宽度
 */
- (float)widthWithFont:(UIFont *)font
{
    CGSize widthSize = CGSizeMake(MAXFLOAT, font.pointSize);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect textRect = [self boundingRectWithSize:widthSize
                                         options:options
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    return textRect.size.width;
}

/**
 * 计算文本高度
 * @param font 文本控件的字体
 * @param width 限制最大的宽度
 */
- (float)heightWithFont:(UIFont *)font withinWidth:(float)width
{
    CGSize heightSize = CGSizeMake(width, MAXFLOAT);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect textRect = [self boundingRectWithSize:heightSize
                                         options:options
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    return ceil(textRect.size.height);
}


@end
