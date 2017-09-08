//
//  DropSelectMenuViewController.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/8.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "DropSelectMenuViewController.h"
#import "DropSelectMenu.h"

@interface DropSelectMenuViewController ()
@property (nonatomic, strong) DropSelectMenu *menu;
@property (nonatomic, strong) NSMutableDictionary *selectDic; // 最后筛选的字典
@property (nonatomic, assign) NSInteger currentSelectIndex; // 当前选中的标题index
@property (nonatomic, weak) UIButton *confirmButton;  // "确定"按钮

@end

@implementation DropSelectMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectDic = [NSMutableDictionary dictionary];
    self.menu = [DropSelectMenu dropSelectMenu];
    self.menu.isShowFirstButtonImage = NO;
    self.menu.isFirstResetButton = YES;
    self.menu.backgroundColor = [UIColor whiteColor];
    self.menu.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    [self.view addSubview:self.menu];
    
    self.menu.titleArray = @[@"题型", @"难度", @"科目", @"年级"];
    NSMutableDictionary *menuCategoryDict = [@{
                                               
                                               @"type" : @[@"全部", @"选择题",@"单选题",@"判断题",@"简答题",@"单选题"],
                                               
                                               @"difficulty" : @[@"全部",@"偏难",@"中等",@"一般"],
                                               
                                               @"subject" : @[@"语文",@"数学",@"英语",@"物理",@"生物",@"舞曲",@"民谣"],
                                               @"class" : @[@"一年级", @"二年级", @"三年级", @"四年级"]
                                               } mutableCopy];
    
    self.menu.menuDataArray = [@[menuCategoryDict[@"type"],menuCategoryDict[@"difficulty"], menuCategoryDict[@"subject"], menuCategoryDict[@"class"]] mutableCopy];
    
    __weak typeof(self) _weakSelf = self;
    
    [self.menu setHandleSelectButtonBlock:^(NSUInteger selectIndex) {
//        if (selectIndex == 0) {
//            [_weakSelf.menu resetAction];
//            
//        }
        _weakSelf.currentSelectIndex = selectIndex;
        
    }];
    
    [self.menu setHandleSelectDataBlock:^(NSString *selectTitle, NSUInteger selectIndex, NSUInteger selectButtonTag) {
        NSLog(@"选中文字：%@   ======   选中索引：%zd", selectTitle, selectIndex);
        if (self.currentSelectIndex == 0) {
            _weakSelf.selectDic[@"type"] = selectTitle;
        } else if (self.currentSelectIndex == 1) {
            _weakSelf.selectDic[@"difficulty"] = selectTitle;
        } else if (self.currentSelectIndex == 2) {
            _weakSelf.selectDic[@"subject"] = selectTitle;
        } else {
            _weakSelf.selectDic[@"class"] = selectTitle;
        }
    }];
    
    [self setupConfirmButton];
}

- (void)setupConfirmButton {
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    self.confirmButton = button;
    button.frame = CGRectMake(100, 400, 100, 44);
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 0.5;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(confirmButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}


- (void)confirmButtonDidClick: (UIButton *)button {
    
    NSLog(@"selectDic = %@",self.selectDic);
}

@end
