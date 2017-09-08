//
//  FilterViewController.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/7.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController (){
    
    NSArray *arrList;
    UIButton *_sureBtn;
    UIButton *_resetBtn;
}

@property (nonatomic, strong) UITableView * menuTableView;//一级页面Table
@property (nonatomic, strong) NSIndexPath *selectedIndexPath; // 当前选择的indexPath

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"筛选";
    arrList = [NSArray arrayWithObjects:@"大家好",@"你们好",@"他们好",@"哈哈",@"嘻嘻",@"嘎嘎", nil];
    [self createTable];
}

- (void)createTable{
    
    UITableView *myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 48) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.rowHeight = 44;
    [self.view addSubview:myTable];
    //重置
    _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetBtn.frame = CGRectMake(0, kSBHeight - 48, kSidebarWidth*0.5, 48);
    _resetBtn.backgroundColor = [UIColor lightGrayColor];
    [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    _resetBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetBtn];
    //确定选择
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(kSidebarWidth*0.5, kSBHeight - 48, kSidebarWidth*0.5, 48);
    _sureBtn.backgroundColor = [UIColor greenColor];
    [_sureBtn setTitle:@"选择" forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrList.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",arrList[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndexPath = indexPath;
    self.clickCell(arrList[indexPath.row], indexPath.row);
    self.tap();
}

//重置
- (void)resetAction{
    //重置搜索条件
    [self.menuTableView reloadData];
}
//确定选择
- (void)sureAction{
    
    self.tap();
}

@end
