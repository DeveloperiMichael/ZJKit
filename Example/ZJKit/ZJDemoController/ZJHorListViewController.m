//
//  ZJHorListViewController.m
//  ZJDemo_Example
//
//  Created by 张炯 on 2018/5/14.
//  Copyright © 2018年. All rights reserved.
//

#import "ZJHorListViewController.h"
#import <ZJKit/ZJKit.h>


@interface ZJHorListViewController ()<ZJHorListViewDelegate, ZJHorListViewDataSource>

@property (nonatomic, strong) ZJHorListView *horListView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ZJHorListViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviewsContraints];
    
    self.dataArray = @[@"Do",@"viewDidLoad",@"loading",@"ZJHorListViewController",@"View",@"pragma",@"the",@"ZJHorListViewDataSource",@"@property",@"setupSubviewsContraints",@"Response",@"numberOfItemsInHorListView"];
//    self.dataArray = @[@"viewDidLoad"];
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- ZJHorListViewDelegate, ZJHorListViewDataSource

- (NSInteger)numberOfItemsInHorListView:(ZJHorListView *)horListView {
    return self.dataArray.count;
}

- (NSString *)horListView:(ZJHorListView *)horListView contentForRowAtIndex:(NSInteger)index {
    return self.dataArray[index];
}

- (NSInteger)horListView:(ZJHorListView *)horListView bubbleMaxValueForRowAtIndex:(NSInteger)index {
    return 999;
}

- (NSInteger)horListView:(ZJHorListView *)horListView bubbleValueForRowAtIndex:(NSInteger)index {
    return index;
}

- (void)horListView:(ZJHorListView *)horListView didSelectRowAtIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex {
    
}

#pragma mark-
#pragma mark- delegate




#pragma mark-
#pragma mark- Event response



#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (ZJHorListView *)horListView {
    if (!_horListView) {
        _horListView = [[ZJHorListView alloc] init];
        _horListView.sa_delegate = self;
        _horListView.sa_dataSource = self;
        _horListView.backgroundColor = [UIColor brownColor];
    }
    return _horListView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.horListView];
    [_horListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
}

#pragma mark -
#pragma mark - UIInterfaceOrientation
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
