//
//  UIButton+ImagePosition.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/19.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "UIButton+ImagePosition.h"

@implementation UIButton (ImagePosition)

- (void)imagePositionStyle:(ImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing {
    if (imagePositionStyle == ImagePositionStyleDefault) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
    } else if (imagePositionStyle == ImagePositionStyleRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        CGFloat imageOffset = titleW + 0.5 * spacing;
        CGFloat titleOffset = imageW + 0.5 * spacing;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
    } else if (imagePositionStyle == ImagePositionStyleTop) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - spacing, 0);
    } else if (imagePositionStyle == ImagePositionStyleBottom) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, imageH + spacing, 0);
    }
}

@end
