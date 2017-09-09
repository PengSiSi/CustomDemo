//
//  InputAccessoryViewController.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/8.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "InputAccessoryViewController.h"

@interface InputAccessoryViewController ()

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *customAccessoryView;

@end

@implementation InputAccessoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillShowNotification object:nil];
    
    // 新建一个UITextField，位置及背景颜色随意写的。
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 30)];
    textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textField];
    
    // 自定义的view
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    self.mainView = customView;
    customView.backgroundColor = [UIColor lightGrayColor];
//    textField.inputAccessoryView = customView;
    textField.inputAccessoryView = self.customAccessoryView;
    
    // 往自定义view中添加各种UI控件(以UIButton为例)
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 5, 60, 20)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:btn];
}

// 根据键盘状态，调整_mainView的位置
- (void) changeContentViewPoint:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;  // 得到键盘弹出后的键盘视图所在y坐标
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        
        _mainView.center = CGPointMake(_mainView.center.x, keyBoardEndY - 20 - _mainView.bounds.size.height/2.0);   // keyBoardEndY的坐标包括了状态栏的高度，要减去
        
    }];
}

// 键盘上面的view
- (UIView *)customAccessoryView{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIView alloc]initWithFrame:(CGRect){0, 0, self.view.frame.size.width, 90}];
        _customAccessoryView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        // 输入框
        UITextField *inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        inputTextField.backgroundColor = [UIColor whiteColor];
        [_customAccessoryView addSubview:inputTextField];
        // 发送按钮
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        sendButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        sendButton.layer.borderWidth = 0.5;
        sendButton.backgroundColor = [UIColor whiteColor];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        sendButton.frame = CGRectMake(400 - 100, 60, 60, 20);
        [_customAccessoryView addSubview:sendButton];
    }
    return _customAccessoryView;
}

@end
