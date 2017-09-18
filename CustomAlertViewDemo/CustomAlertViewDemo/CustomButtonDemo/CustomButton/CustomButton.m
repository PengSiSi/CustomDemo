//
//  CustomButton.m
//  WisdomClass_teacher
//
//  Created by 思 彭 on 2017/9/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "CustomButton.h"
#import "UIViewExt.h"

// 图片宽度
#define kBtnImgWidth 24

@implementation CustomButton

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    switch (self.type) {
        case LeftTextRightImage: {
            // 调整文字
            self.titleLabel.mj_x = 0;
            self.titleLabel.mj_y = 0;
            // 自适应宽度
            [self.titleLabel sizeToFit];
            self.titleLabel.height = self.height;
            // 调整图片
            self.imageView.mj_x = self.titleLabel.width;
            self.imageView.mj_y = self.titleLabel.mj_y;
            self.imageView.width = self.imageView.width;
            self.imageView.height = self.imageView.width;
            self.imageView.centerY = self.titleLabel.centerY;
            break;
        }
        case LeftImageRightText: {
            // 调整文字
            self.imageView.mj_x = 0;
            self.imageView.mj_y = (self.height - self.imageView.height) / 2;
            // 自适应宽度
            [self.titleLabel sizeToFit];
            self.titleLabel.height = self.height;
            // 调整图片
            self.titleLabel.mj_x = self.imageView.width;
            self.titleLabel.mj_y = 0;
            self.titleLabel.width = self.width - self.imageView.width;
            self.titleLabel.height = self.height;
            break;
        }
        case TopImageBottomText: {
            self.imageView.mj_x = (self.width - self.imageView.width) / 2;
            self.imageView.mj_y = 0;
            self.imageView.width = self.imageView.width;
            self.imageView.height = self.imageView.width;
            self.titleLabel.mj_x = 0;
            self.titleLabel.mj_y = self.imageView.height;
            self.titleLabel.height = (self.height - self.imageView.height) / 2;
            self.titleLabel.width = self.width;
            [self.titleLabel sizeToFit];
            break;
        }
        case TopTextBottomImage: {
            // 调整文字
            self.titleLabel.mj_x = 0;
            self.titleLabel.mj_y = 0;
            self.titleLabel.width = self.width;
            // 调整图片
            self.imageView.mj_x = (self.width - self.imageView.width) / 2;
            self.imageView.mj_y = self.titleLabel.height;
            self.imageView.width = self.imageView.width;
            self.imageView.height = self.imageView.width;
            [self.titleLabel sizeToFit];
            break;
        }
        default:
            break;
    }
}

@end
