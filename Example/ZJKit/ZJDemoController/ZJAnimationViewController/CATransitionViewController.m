//
//  CATransitionViewController.m
//  ZJKit_Example
//
//  Created by 张炯 on 2018/5/29.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import "CATransitionViewController.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>

@interface CATransitionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *animationArray;
@property (nonatomic, assign) NSInteger animationType;


@end

@implementation CATransitionViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviewsContraints];
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- SACardViewDataSource




#pragma mark-
#pragma mark- delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.animationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"customCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.animationArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _animationType = indexPath.row;
}

#pragma mark-
#pragma mark- Event response

- (void)startAnimation:(UIButton *)button {
    
    self.topView.hidden = !self.topView.hidden;
    self.bottomView.hidden = !self.bottomView.hidden;
    
    [self.bgView startTransitionAnimationType:_animationType subType:1 duration:1.0];
//    [UIView transitionFromView:self.topView toView:self.bottomView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionCurveEaseInOut completion:nil];
}




#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (UIImageView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc] init];
        _topView.image = [UIImage imageNamed:@"123"];
    }
    return _topView;
}

- (UIImageView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] init];
        _bottomView.hidden = YES;
        _bottomView.image = [UIImage imageNamed:@"456"];
    }
    return _bottomView;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.backgroundColor = [UIColor blueColor];
        [_startButton setTitle:@"StartAnimation" forState:UIControlStateNormal];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_startButton addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor greenColor];
    }
    return _bgView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)animationArray {
    if (!_animationArray) {
        _animationArray = [NSArray arrayWithObjects:
                           @"fade",
                           @"moveIn",
                           @"push",
                           @"reveal",
                           @"cube",
                           @"suckEffect",
                           @"rippleEffect",
                           @"pageCurl",
                           @"pageUnCurl",
                           @"oglFlip",
                           @"cameralrisHollowOpen",
                           @"cameralrisHollowClose",nil];
    }
    return _animationArray;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.bottomView];
    [self.bgView addSubview:self.topView];
    [self.view addSubview:self.startButton];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-340);
    }];
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(50);
        make.right.mas_equalTo(self.view).mas_offset(-50);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.view).mas_offset(-10);
    }];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(20);
        make.width.height.mas_equalTo(240);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bgView);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bgView);
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
