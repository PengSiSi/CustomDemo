//
//  ViewController.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/6.
//  Copyright © 2017年 思 彭. All rights reserved.

// 实现自定义AlertView

#import "ViewController.h"
#import "CustomAlertView.h"
#import "FilterViewController.h"
#import "DropSelectMenuViewController.h"
#import "CellSwipeOutViewController.h"

#import <RESideMenu.h>

#define WEAK_SELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define ScreenBounds [[UIScreen mainScreen] bounds]     //屏幕frame
#define ScreenFullWidth [[UIScreen mainScreen] bounds].size.width     //屏幕宽度

@interface ViewController ()

@property (nonatomic, weak) UIView *upView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) FilterViewController *slidebarVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// alertView
- (IBAction)clickAction:(id)sender {
    
    NSLog(@"弹出");
    CustomAlertView *alertView = [[CustomAlertView alloc]initWithTitle:@"" titleColor:nil titleBackgroundColor:[UIColor whiteColor]];
    // 添加子布局
    [alertView addContentView:[self addSubView]];
    // 添加按钮
    [alertView setButtonTitles:@[ @"取消", @"确定" ]];
    // 添加按钮点击事件
    [alertView setOnButtonClickHandle:^(CustomAlertView *alertView, NSInteger buttonIndex) {
        
        
        if (buttonIndex == 0) {
            NSLog(@"点击取消");
        } else if (buttonIndex == 1) {
            NSLog(@"点击确定");
        }
        // 关闭
        [alertView dismiss];
    }];
    
    // 显示
    [alertView show];
}

// 自定义alertView的contentView
- (UIView *)addSubView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 60)];
    NSArray *titleArray = @[@"A", @"B", @"C"];
    NSArray *imageArray = @[@"ic_article_collect_select", @"ic_delicious_select", @"ic_feed_like_selected"];
    CGFloat width = (view.frame.size.width - 40) / titleArray.count;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake((i * width) + (i * 10), 0, width, 50);
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+10 ,-button.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(-10, 0.0,0.0, -button.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }
    // 设置自定义的的view上面的弧度
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    return view;
}

// 侧边栏
- (IBAction)rightSlideAction:(id)sender {
    
  // 自定义实现
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth, ScreenBounds.size.height)];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    self.upView = view;
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(100, 0, ScreenFullWidth-100, ScreenBounds.size.height)];
    window.windowLevel = UIWindowLevelNormal;
    window.hidden = NO;
    [window makeKeyAndVisible];
    self.window = window;
    
    WEAK_SELF(weakSelf)
    
    FilterViewController *up = [[FilterViewController alloc] init];
    up.tap = ^{
        weakSelf.window.hidden = YES;//少这句话的就会有问题
        [weakSelf.window resignKeyWindow];
        [weakSelf.upView removeFromSuperview];
        
        weakSelf.window  = nil;
        weakSelf.upView = nil;
    };
    up.clickCell = ^(NSString *chooseStr, NSInteger index){
        NSLog(@"chooseStr = %@", chooseStr);
    };
    // 先设置slider的frame,实现右侧滑出的效果
    up.view.frame = CGRectMake(ScreenBounds.size.width, 0, ScreenBounds.size.width, ScreenBounds.size.height);
    [UIView animateWithDuration:.35 animations:^{
        up.view.frame = window.bounds;
        window.rootViewController = up;
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}

// alertView的选择
- (void)selectAction: (UIButton *)button {
    NSLog(@"%@",button.currentTitle);
}

// 侧边栏的隐藏
- (void)tapAction{
    
    [self.window resignKeyWindow];
    [self.upView removeFromSuperview];
    self.window  = nil;
    self.upView = nil;
}

- (IBAction)pushDropSelectMenuViewDemo:(id)sender {
    
    DropSelectMenuViewController *dropSelectMenuVc = [[DropSelectMenuViewController alloc]init];
    [self.navigationController pushViewController:dropSelectMenuVc animated:YES];
}


- (IBAction)CellSwipeOutDemo:(id)sender {
    
    [self.navigationController pushViewController:[CellSwipeOutViewController new] animated:YES];
}

@end
