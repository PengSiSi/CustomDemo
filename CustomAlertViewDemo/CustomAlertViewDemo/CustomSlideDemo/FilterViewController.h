//
//  FilterViewController.h
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/7.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSlideViewController.h"

@interface FilterViewController : CustomSlideViewController <UITableViewDelegate,UITableViewDataSource>

//在灰色部分点击返回上个页面的block
@property(nonatomic,copy)void(^tap)();
//选中cell后在上个页面显示带回去的值的block
@property(nonatomic,copy)void(^clickCell)(NSString *chooseStr, NSInteger index);


@end
