//
//  CustomButton.h
//  WisdomClass_teacher
//
//  Created by 思 彭 on 2017/9/18.
//  Copyright © 2017年 思 彭. All rights reserved.

// 自定义左边文字,右边图片的Button
// 会随着文字多少变化图片跟着变化，需要注意的是：在设置完 Button 的文字之后，要重新设置Button 的中心点位置。

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonType) {
    LeftTextRightImage = 0, // 左边文字,右边图片
    LeftImageRightText, // 左图片,右文字
    TopTextBottomImage, // 上文字,下图片
    TopImageBottomText // 上图片,下文字
};

@interface CustomButton : UIButton

@property (nonatomic, assign) ButtonType type;

@end
