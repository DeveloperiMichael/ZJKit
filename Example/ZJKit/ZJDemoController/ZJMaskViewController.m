//
//  ZJMaskViewController.m
//  SAKit_Example
//
//  Created by 张炯 on 2018/4/3.
//  Copyright © 2018年 wuchao110. All rights reserved.
//

#import "ZJMaskViewController.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>

@interface ZJMaskViewController ()

{
    UIView *_bgView;
}

@property (nonatomic, strong)  ZJMaskView *maskView;

@end

@implementation ZJMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bgView = [[UIView alloc]init];
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bgView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(60);
    }];
    button.backgroundColor = [ZJColor zj_colorC1];
    [button setTitle:@"ZJMaskView" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bgView addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(button.mas_bottom).mas_offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(60);
    }];
    button1.backgroundColor = [ZJColor zj_colorC1];
    [button1 setTitle:@"endgeInsets" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    
    _maskView = [[ZJMaskView alloc] initWithShowInView:self.view customView:nil edgeInsets:UIEdgeInsetsMake(300, 100, 300, 100)];
    
}

- (void)buttonAction:(UIButton *)button {
    
    _maskView.edgeInsets = UIEdgeInsetsMake(300, 100, 300, 100);
    [_maskView showAnimated:YES completion:^{
        NSLog(@"showAnimated UIEdgeInsetsMake(300, 100, 300, 100)");
    }];
    

    
}


- (void)button1Action:(UIButton *)button {
    _maskView.edgeInsets = UIEdgeInsetsMake(0, 200, 0, 0);
    [_maskView showAnimated:YES completion:^{
        NSLog(@"showAnimated UIEdgeInsetsMake(100, 100, 100, 100)");
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
