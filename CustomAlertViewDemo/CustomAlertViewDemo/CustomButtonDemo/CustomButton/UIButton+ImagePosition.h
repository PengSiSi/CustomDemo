//
//  UIButton+ImagePosition.h
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/19.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 图片在左，文字在右
    ImagePositionStyleDefault,
    /// 图片在右，文字在左
    ImagePositionStyleRight,
    /// 图片在上，文字在下
    ImagePositionStyleTop,
    /// 图片在下，文字在上
    ImagePositionStyleBottom,
} ImagePositionStyle;

@interface UIButton (ImagePosition)

/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)imagePositionStyle:(ImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;

@end
