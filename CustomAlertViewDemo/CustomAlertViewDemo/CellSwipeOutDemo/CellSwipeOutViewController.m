//
//  CellSwipeOutViewController.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/8.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "CellSwipeOutViewController.h"
#import <Masonry.h>

@interface CellSwipeOutViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UIButton *addButton/**< 新增按钮*/;

@end

@implementation CellSwipeOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self createAddButton];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
}

- (void)createAddButton {
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_addButton setBackgroundImage:[UIImage imageNamed:@"contacts_gobacktofront"] forState:UIControlStateNormal];
    _addButton.backgroundColor = [UIColor greenColor];
    [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    _addButton.hidden = YES;
    [self.view addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-30);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}

- (void)addAction: (UIButton *)button {
    
}

#pragma mark - 获取tableview的位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > self.view.frame.size.height) {
        _addButton.hidden = NO;
    } else {
        _addButton.hidden = YES;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = [NSString stringWithFormat:@"思思---%ld", indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001f;
}

#pragma mark - 滑动删除

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除。。。");
        
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
    }];
    if (indexPath.row % 2 == 0) {
        
        action0.backgroundColor = [UIColor greenColor];
    } else {
        action0.backgroundColor = [UIColor lightGrayColor];
    }
    
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"默认" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了默认的。。。");
//        
//        // 收回左滑出现的按钮(退出编辑模式)
//        tableView.editing = NO;
//    }];
    
//    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"确定" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了确定的。。。");
//        
//        // 收回左滑出现的按钮(退出编辑模式)
//        tableView.editing = NO;
//    }];

    return @[action0];
}

@end
