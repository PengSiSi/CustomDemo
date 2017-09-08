//
//  DropSelectMenu.m
//  CustomAlertViewDemo
//
//  Created by 思 彭 on 2017/9/8.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "DropSelectMenu.h"
#import <objc/runtime.h>
#import "TitlebackgroundView.h"

#define DEFAULT_COLOR [UIColor colorWithRed:245.0/255.0f green:245.0/255.0f blue:245.0/255.0f alpha:1.0f]

#define COLOR(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]
#define KMaskBackGroundViewColor  [UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:0.1]
#define Kscreen_width  [UIScreen mainScreen].bounds.size.width
#define Kscreen_height [UIScreen mainScreen].bounds.size.height
#define KTitleButtonHeight 40
#define KCellHeight 42
#define KTitleButtonTag 1000

#define OBJCSetObject(object,value)  objc_setAssociatedObject(object,@"title" , value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define OBJCGetObject(object) objc_getAssociatedObject(object, @"title")

@interface DropSelectMenu() <UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *  标题按钮数组
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIView *bottomBarView;

@property (nonatomic) UIButton  *tempButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic) UIView  *maskBackGroundView;

@property (nonatomic) CGFloat selfOriginalHeight ;

@property (nonatomic)NSMutableArray *collectionDataArray;

@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) NSArray *tempTitleArray;
@property (nonatomic,strong)TitlebackgroundView *titleBackView;
@property (nonatomic, strong) UIView *titleBgView;  // titleButton的底部view
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation DropSelectMenu

+ (instancetype)dropSelectMenu {
    return [[DropSelectMenu alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.isShowFirstButtonImage = YES;
        self.selfOriginalHeight = (frame.size.height <= 0 ? 40 : self.selfOriginalHeight);
        self.dropMenuMaxHeight = KCellHeight * 5 + 20;
        [self addSubview:self.maskBackGroundView];
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 8, 42);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, Kscreen_width, 0) collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = COLOR(249, 249, 249);
    self.collectionView.scrollsToTop = NO;
    self.collectionView.layer.borderWidth = 0.3;
    self.collectionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.collectionView registerClass:[DropSelectMenuCell class] forCellWithReuseIdentifier:@"DropSelectMenuCell"];
    [self addSubview:self.collectionView];
}

-  (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.tempTitleArray = titleArray;
    
    NSInteger count = titleArray.count;
    [self.topBarView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttonArray removeAllObjects];
    
    self.titleBackView = [[TitlebackgroundView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, KTitleButtonHeight)];
    self.titleBackView.backgroundColor = [UIColor clearColor];
    
    // 这个颜色也要设置,否则凸出效果有问题
    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.titleBackView.frame.size.width, self.titleBackView.frame.size.height + 10)];
    self.titleBgView = [[UIView alloc]initWithFrame:self.titleBackView.frame];
    self.titleBgView.backgroundColor = COLOR(249, 249, 249);
    
    [self addSubview:self.titleBgView];
    [self.titleBgView addSubview:self.titleBackView];
    
    for (NSInteger index = 0; index < count; index++) {
        
        UIButton *titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.backgroundColor = COLOR(240, 242, 245);
        titleButton.layer.cornerRadius = 5.0f;
        [titleButton setTitle:self.titleArray[index] forState:UIControlStateNormal];
        [titleButton setTitleColor:(self.titleButtonNormalColor == nil ? COLOR(0, 0, 0) : self.titleButtonSelectedColor) forState:UIControlStateNormal];
        [titleButton setTitleColor:(self.titleButtonSelectedColor == nil ? COLOR(250, 66, 76) : self.titleButtonSelectedColor) forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        titleButton.tag = KTitleButtonTag + index ;
        [titleButton addTarget:self action:@selector(titleButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //        if (!self.isShowFirstButtonImage && index == 0) {
        
        //        } else {
        [titleButton setImage:[UIImage imageNamed:@"ic_arrow_down"] forState:UIControlStateNormal];
        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0,titleButton.titleLabel.intrinsicContentSize.width+5, 0, -titleButton.titleLabel.intrinsicContentSize.width-10);
        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -titleButton.imageView.bounds.size.width-15, 0, titleButton.imageView.bounds.size.width+10);
        //        }
        
        [self.titleBackView addSubview:titleButton];
        [self.buttonArray addObject:titleButton];
        
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.maskBackGroundView.frame = CGRectMake(0,0,self.frame.size.width, Kscreen_height - self.frame.origin.y);
    self.topBarView.frame = CGRectMake(0, 0, self.frame.size.width, KTitleButtonHeight);
    self.bottomBarView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.frame.size.width, 44);
    CGFloat buttonWidth = self.bottomBarView.frame.size.width / 2;
    //    self.resetButton.frame = self.bottomBarView.bounds;
    self.selectButton.frame = CGRectMake(0, 0, buttonWidth, 44);
    self.resetButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, 44);
    
    CGFloat width = (self.frame.size.width - 50) / self.buttonArray.count;
    for (UIButton *button in self.buttonArray) {
        NSInteger index = [self.buttonArray indexOfObject:button];
        button.frame= CGRectMake((width * index) + ((index + 1) * 10), 5, width, KTitleButtonHeight - 10);
    }
    
}

#pragma mark --------------------  collectionView 数据源  --------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger index = 0;
    if (self.tempButton != nil) {
        index =  self.tempButton.tag - KTitleButtonTag;
    }
    NSInteger count = 0;
    if (self.menuDataArray.count > 0) {
        count = [self.menuDataArray[index] count];
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellD = @"DropSelectMenuCell";
    DropSelectMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellD forIndexPath:indexPath];
    NSUInteger index =  self.tempButton.tag - KTitleButtonTag;
    cell.title = [self.menuDataArray[index] objectAtIndex:indexPath.item];
    
    if ([cell.menuTextLabel.text isEqualToString:OBJCGetObject(self.tempButton)]) {
        cell.isSelected = YES;
        cell.menuTextLabel.textColor = [UIColor colorWithRed:250/255.0 green:66/255.0 blue:76/255.0 alpha:1.0];
    } else {
        cell.isSelected = NO;
        cell.menuTextLabel.textColor = COLOR(0, 0, 0);
    }
    cell.backgroundColor = COLOR(249, 249, 249);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DropSelectMenuCell *cell = (DropSelectMenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = YES;
    
    [self.tempButton setTitle:cell.menuTextLabel.text forState:UIControlStateNormal];
    
    self.tempButton.imageEdgeInsets = UIEdgeInsetsMake(0,self.tempButton.titleLabel.intrinsicContentSize.width+3.5, 0, -self.tempButton.titleLabel.intrinsicContentSize.width-3.5);
    self.tempButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.tempButton.imageView.bounds.size.width-3.5, 0, self.tempButton.imageView.bounds.size.width+3.5);
    
    OBJCSetObject(self.tempButton, cell.menuTextLabel.text);
    
    if (self.handleSelectDataBlock) {
        self.handleSelectDataBlock(cell.menuTextLabel.text, indexPath.row,self.tempButton.tag - KTitleButtonTag);
    }
    
    self.selectedIndexPath = indexPath;
    [self dismiss];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark --------------------  事件  --------------------

// 重置
- (void)resetAction {
    
    [self dismiss];
    self.titleArray = self.tempTitleArray;
}

// 选择
- (void)selectAction{
    
    if (self.handleSelectDataBlock) {
        DropSelectMenuCell *cell = (DropSelectMenuCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
        self.handleSelectDataBlock(cell.menuTextLabel.text, self.selectedIndexPath.row,self.tempButton.tag - KTitleButtonTag);
    }
    [self dismiss];
}

- (void)titleButtonClickAction:(UIButton *)titleButton {
    
    NSUInteger index =  titleButton.tag - KTitleButtonTag;
    
    if (self.handleSelectButtonBlock) {
        self.handleSelectButtonBlock(index);
    }
//    if (self.isFirstResetButton &&  index == 0) {
//        return;
//    }
    
    for (UIButton *button in self.buttonArray) {
        if (button == titleButton) {
            button.selected=!button.selected;
            self.tempButton =button;
            [self changeButtonObject:button TransformAngle:M_PI];
        }else
        {
            button.selected=NO;
            [self changeButtonObject:button TransformAngle:0];
        }
    }
    
    if (titleButton.selected) {
        
        [self changeButtonObject:titleButton TransformAngle:M_PI];
        self.collectionDataArray = self.menuDataArray[index];
        //设置默认选中第一项。
        if ([OBJCGetObject(self.tempButton) length]<1) {
            
            NSString *title = self.collectionDataArray.firstObject;
            OBJCSetObject(self.tempButton, title);
            [self.collectionView reloadData];
        }
        
        if (self.collectionDataArray.count > 0) {
            [self.collectionView reloadData];
            
            CGFloat tableViewHeight =  self.collectionDataArray.count / 2 * KCellHeight + 20> self.dropMenuMaxHeight ? self.dropMenuMaxHeight : self.collectionDataArray.count / 2 * KCellHeight;
            
            [self expandWithViewHeight:tableViewHeight];
            self.bottomBarView.hidden = NO;
        } else {
            [self dismiss];
        }
        
    } else {
        [self dismiss];
    }
}

#pragma mark - 展开菜单
-(void)expandWithViewHeight:(CGFloat )height {
    
    CGRect rect = self.frame;
    rect.size.height = Kscreen_height - self.frame.origin.y;
    self.frame= rect;
    
    [self showSpringAnimationWithDuration:0.3 animations:^{
        // 凸出部分的设置
        self.titleBgView.frame = CGRectMake(0, 0, self.titleBackView.frame.size.width, self.titleBackView.frame.size.height + 10);
        self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, self.frame.size.width, height);
        self.tempButton.backgroundColor = COLOR(249, 249, 249);
        self.titleBackView.showRect = self.tempButton.frame;
        //更新背景绘制
        [self.titleBackView setNeedsDisplay];
    } completion:^{
        self.maskBackGroundView.hidden=NO;
    }];
    
}

#pragma mark - 收起菜单
-(void)dismiss {
    for (UIButton *button in self.buttonArray) {
        button.selected=NO;
        [self changeButtonObject:button TransformAngle:0];
    }
    self.bottomBarView.hidden = YES;
    CGRect rect = self.frame;
    rect.size.height = self.selfOriginalHeight;
    self.frame = rect;
    
    [self showSpringAnimationWithDuration:.3 animations:^{
        // 凸出部分的设置
        self.titleBackView.showRect = CGRectMake(0, 0, 0, 0);
        self.tempButton.backgroundColor = COLOR(240, 242, 245);
        self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width,0);
        self.titleBgView.frame = self.titleBackView.frame;
        //更新背景绘制
        [self.titleBackView setNeedsDisplay];
    } completion:^{
        self.maskBackGroundView.hidden=YES;
    }];
    
}

#pragma mark --------------------  动画  --------------------

-(void)changeButtonObject:(UIButton *)button TransformAngle:(CGFloat)angle {
    [UIView animateWithDuration:0.2 animations:^{
        button.imageView.transform =CGAffineTransformMakeRotation(angle);
    } completion:^(BOOL finished) {
    }];
    
}

-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion {
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}



#pragma mark --------------------  懒加载  --------------------

- (NSArray *)tempTitleArray {
    if (!_tempTitleArray) {
        _tempTitleArray = [NSArray array];
    }
    return _tempTitleArray;
}

- (NSMutableArray *)menuDataArray {
    if (!_menuDataArray) {
        _menuDataArray = [NSMutableArray array];
    }
    return _menuDataArray;
}
- (UIView *)topBarView {
    if (!_topBarView) {
        _topBarView = [[UIView alloc]init];
        _topBarView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topBarView];
    }
    return _topBarView;
}
- (UIView *)bottomBarView {
    if (!_bottomBarView) {
        _bottomBarView = [[UIView alloc]init];
        _bottomBarView.backgroundColor = [UIColor whiteColor];
        _bottomBarView.hidden = YES;
        _bottomBarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _bottomBarView.layer.borderWidth = 0.5;
        [self addSubview:_bottomBarView];
    }
    return _bottomBarView;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        _resetButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _resetButton.backgroundColor = COLOR(45, 155, 233);
        [_resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomBarView addSubview:_resetButton];
    }
    return _resetButton;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setTitle:@"选择" forState:UIControlStateNormal];
        _selectButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomBarView addSubview:_selectButton];
    }
    return _selectButton;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
-(UIView *)maskBackGroundView {
    if (!_maskBackGroundView) {
        _maskBackGroundView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, Kscreen_height - self.frame.origin.y)];
        _maskBackGroundView.backgroundColor = KMaskBackGroundViewColor;
        _maskBackGroundView.hidden = YES;
        _maskBackGroundView.userInteractionEnabled=YES;
        _maskBackGroundView.alpha = 0.6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_maskBackGroundView addGestureRecognizer:tap];
    }
    return _maskBackGroundView;
}

@end

@implementation DropSelectMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = COLOR(249, 249, 249);
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.menuTextLabel = [[UILabel alloc]init];
    self.menuTextLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:self.menuTextLabel];
    
    self.menuImageView = [[UIImageView alloc]init];
    self.menuImageView.image = [UIImage imageNamed:@"menu_choose_"];
    [self.contentView addSubview:self.menuImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.menuImageView.frame = CGRectMake(self.contentView.frame.size.width - 15 - 13, (self.contentView.frame.size.height - 10) / 2, 13, 10);
    self.menuTextLabel.frame = CGRectMake(15, (self.contentView.frame.size.height - 14) / 2, self.contentView.frame.size.width - 15 - 13, 14);
    self.menuTextLabel.backgroundColor = COLOR(249, 249, 249);
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.menuTextLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.menuTextLabel.textColor = [UIColor colorWithRed:250/255.0 green:66/255.0 blue:76/255.0 alpha:1.0];
        self.backgroundColor = [UIColor whiteColor];
        self.menuImageView.hidden = NO;
    }else
    {
        self.menuTextLabel.textColor = [UIColor blackColor];
        self.menuImageView.hidden = YES;
        self.backgroundColor=[UIColor whiteColor];
    }
}

@end
