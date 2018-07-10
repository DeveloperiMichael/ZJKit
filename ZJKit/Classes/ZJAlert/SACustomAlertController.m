//
//  SACustomAlertController.m
//  SACustomAlert
//
//  Created by 汪志刚 on 2017/1/6.
//  Copyright © 2017年 汪志刚. All rights reserved.
//

#import "SACustomAlertController.h"

@interface ZJAlertControllerView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancelItem;
@property (nonatomic, copy) SAClickItemBlock didClickCancelItemBlock;

@end

@implementation ZJAlertControllerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMethod];
    }
    return self;
}

- (void)initMethod {
    
    [self addSubview:self.cancelItem];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat cancelItemHeight = 44.0;
    CGFloat lineViewHeight = 0.5;
    self.cancelItem.frame = CGRectMake(0, height-cancelItemHeight, width, cancelItemHeight);
    self.lineView.frame = CGRectMake(0, height-cancelItemHeight-lineViewHeight, width, lineViewHeight);
}

#pragma mark-
#pragma mark-   action response
- (void)didClickCancelItem:(UIButton *)button {
    if (self.didClickCancelItemBlock) {
        self.didClickCancelItemBlock(button.tag);
    }
}

#pragma mark-
#pragma mark-   setters and getters
- (UIButton *)cancelItem {
    if (!_cancelItem) {
        _cancelItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelItem.tag = 0;
        [_cancelItem setTitle: @"取消" forState:UIControlStateNormal];
        [_cancelItem setBackgroundColor:[UIColor whiteColor]];
        [_cancelItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelItem addTarget:self action:@selector(didClickCancelItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelItem;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0];
    }
    return _lineView;
}

@end

/***************************************************************************************************/

@interface SACustomAlertController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) UIViewController *fromController;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) ZJAlertControllerView *containerView;
@property (nonatomic, copy) SAClickItemBlock cancelBlock;

@end

@implementation SACustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [self setupSubViews];
}

- (void)setupSubViews {
    
    [self.view addGestureRecognizer:self.tap];
    [self.view addSubview:self.containerView];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.containerView.bounds = CGRectMake(0, 0, 260.0, 170.0);
    self.containerView.center = self.view.center;
}

#pragma mark-
#pragma mark-   UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    CGPoint point = [touch locationInView:self.view];
    if (CGRectContainsPoint(self.containerView.frame, point)) {
        return NO;
    }
    return YES;
}

#pragma mark-
#pragma mark-   action response
- (void)presentAlertController {
    
    UIViewController *fromVC = self.fromController.navigationController?:self.fromController;
    [fromVC addChildViewController:self];
    [fromVC.view addSubview:self.view];
    self.view.alpha = 0.4;
    self.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.1 animations:^{
        self.view.transform = CGAffineTransformIdentity;
        self.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissAlertController:(BOOL)animated {
    
    if (!animated) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        return;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.view.alpha = 0.4;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)didTap:(UITapGestureRecognizer *)tap {
    
    [self dismissAlertController:YES];
}

#pragma mark-
#pragma mark-   setter and getter
- (ZJAlertControllerView *)containerView {
    if (!_containerView) {
        _containerView = [ZJAlertControllerView new];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 5.0;
        _containerView.clipsToBounds = YES;
        __weak __typeof(self)weakSelf = self;
        [_containerView setDidClickCancelItemBlock:^BOOL(NSInteger index){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (strongSelf.cancelBlock) {
                strongSelf.cancelBlock(0);
            }
            [strongSelf dismissAlertController:YES];
            return NO;
        }];
    }
    return _containerView;
}

- (UITapGestureRecognizer *)tap {
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        _tap.delegate = self;
    }
    return _tap;
}

- (void)setShouldTouchDismiss:(BOOL)shouldTouchDismiss {
    _shouldTouchDismiss = shouldTouchDismiss;
    self.tap.enabled = shouldTouchDismiss;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
