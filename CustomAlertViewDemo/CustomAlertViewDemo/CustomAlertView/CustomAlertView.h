//
//  CustomAlertView.h
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/7.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertView;

typedef void (^OnButtonClickHandle)(CustomAlertView *alertView, NSInteger buttonIndex);

@interface CustomAlertView : UIView

@property (nonatomic, copy) NSString *title;                 // 标题颜色
@property (nonatomic, strong) UIColor *titleColor;           // 标题文字
@property (nonatomic, strong) UIColor *titleBackgroundColor; // 标题背景颜色

@property (nonatomic, strong) UIView *dialogView;            // 外层dialog视图
@property (nonatomic, strong) UIView *containerView;         // 自定义的布局（子视图）
@property (nonatomic, strong) NSArray *buttonTitles;         // 按钮标题数组
@property (nonatomic, copy) OnButtonClickHandle onButtonClickHandle; // 按钮点击事件

// 初始化
- (instancetype)init;
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleBackgroundColor:(UIColor *)titleBackgroundColor;

- (void)addContentView: (UIView *)contentView; // 设置自定义的布局
- (void)setOnButtonClickHandle:(OnButtonClickHandle)onButtonClickHandle; // 设置按钮点击事件
- (void)deviceOrientationDidChange: (NSNotification *)notification;      // 设备旋转，横向/竖向改变
- (void)show;    // 显示
- (void)dismiss; // 关闭

@end
