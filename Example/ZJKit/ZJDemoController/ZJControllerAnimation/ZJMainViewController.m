//
//  ZJMainViewController.m
//  ZJKit_Example
//
//  Created by 张炯 on 2018/6/12.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import "ZJMainViewController.h"
#import "ZJFromViewController.h"
#import "ZJToViewController.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>

@interface ZJMainViewController ()

@property (nonatomic, strong) ZJFromViewController *fromVC;

@property (nonatomic, strong) ZJToViewController *toVC;

@end

@implementation ZJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Transition begin" forState:UIControlStateNormal];
    button.backgroundColor = [ZJColor zj_colorC1];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(beginTransition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.top.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(150);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"Transition back" forState:UIControlStateNormal];
    backButton.backgroundColor = [ZJColor zj_colorC1];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backTransition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.top.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(150);
    }];
    
    
    self.fromVC = [[ZJFromViewController alloc] init];
    self.toVC = [[ZJToViewController alloc] init];

    [self addChildViewController:self.fromVC];
    [self.view addSubview:self.fromVC.view];

    [self.fromVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(button.mas_bottom).mas_offset(10);
    }];
    [self.fromVC willMoveToParentViewController:self];
}


- (void)beginTransition:(UIButton *)button {
   
    [self addChildViewController:self.toVC];
    [self.view addSubview:self.toVC.view];
    [self.toVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(button.mas_bottom).mas_offset(10);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self transitionFromViewController:self.fromVC toViewController:self.toVC duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        
        [weakSelf.view startTransitionAnimationType:ZJTransitionAnimationCube subType:ZJTransitionAnimationFromLeft duration:0.3];
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            [weakSelf.fromVC.view removeFromSuperview];
            [weakSelf.fromVC removeFromParentViewController];
            [weakSelf.toVC didMoveToParentViewController:weakSelf];
        }
        
    }];
}

- (void)backTransition:(UIButton *)button {
    [self addChildViewController:self.fromVC];
    [self.view addSubview:self.fromVC.view];
    [self.fromVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(button.mas_bottom).mas_offset(10);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self transitionFromViewController:self.toVC toViewController:self.fromVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        
        [weakSelf.view startTransitionAnimationType:ZJTransitionAnimationCube subType:ZJTransitionAnimationFromRight duration:0.3];
        
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.toVC.view removeFromSuperview];
            [weakSelf.toVC removeFromParentViewController];
            [weakSelf.fromVC didMoveToParentViewController:weakSelf];
        }
        
    }];
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
