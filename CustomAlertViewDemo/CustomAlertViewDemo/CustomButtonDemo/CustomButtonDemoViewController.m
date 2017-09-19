//
//  CustomButtonDemoViewController.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "CustomButtonDemoViewController.h"
#import "CustomButton.h"
#import "UIButton+ImagePosition.h"
#import "UIButton+Event.h"

@interface CustomButtonDemoViewController ()

@end

@implementation CustomButtonDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    NSArray *buttonTitleArray = @[@"左文字右图片", @"左图片右文字", @"上图片下文字", @"上文字下图片"];
    for (NSInteger i = 0; i < buttonTitleArray.count; i++) {
        
        // 左边文字,右边图片
        CustomButton *changeButton = [CustomButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            changeButton.type = LeftTextRightImage;
        } else if (i == 1) {
            changeButton.type = LeftImageRightText;
        } else if (i == 2) {
            changeButton.type = TopImageBottomText;
        } else if (i == 3) {
            changeButton.type = TopTextBottomImage;
        }
        changeButton.backgroundColor = [UIColor lightGrayColor];
        [changeButton setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [changeButton setImage:[UIImage imageNamed:@"ic_arrow_down"] forState:UIControlStateNormal];
        [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        changeButton.frame = CGRectMake(100, i * (40 + 100), 150, 40);
        changeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        //    [changeButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changeButton];
    }
    
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.backgroundColor = [UIColor redColor];
    [changeButton setTitle:@"思思" forState:UIControlStateNormal];
    [changeButton setImage:[UIImage imageNamed:@"ic_arrow_down"] forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeButton.frame = CGRectMake(100, 500, 150, 40);
    changeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:changeButton];
    [changeButton addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
    [changeButton imagePositionStyle:ImagePositionStyleBottom spacing:4];
    changeButton.SG_timeInterval = 2;
}

- (void)didClick {
    
    NSLog(@"连续点击啊");
}
@end
