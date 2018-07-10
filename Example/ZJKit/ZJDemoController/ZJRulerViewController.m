//
//  ZJRulerViewController.m
//  ZJKit_Example
//
//  Created by 张炯 on 2018/6/7.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import "ZJRulerViewController.h"
#import <ZJKit/ZJKit.h>
#import <Masonry/Masonry.h>

@interface ZJRulerViewController ()

@end

@implementation ZJRulerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZJRulerView *rulerView = [[ZJRulerView alloc] init];
    rulerView.rulerScale = 1;
    rulerView.rulerCount = 50;
    rulerView.decimalType = ZJRulerDecimalTypeOnePoint;
    rulerView.currentIndex = 50;
    [self.view addSubview:rulerView];
     
     [rulerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.left.right.mas_equalTo(self.view);
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
