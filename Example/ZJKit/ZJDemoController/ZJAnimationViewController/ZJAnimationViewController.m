//
//  ZJAnimationViewController.m
//  ZJKit_Example
//
//  Created by 张炯 on 2018/5/29.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import "ZJAnimationViewController.h"
#import <Masonry/Masonry.h>

@interface ZJAnimationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ZJAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
}

#pragma mark-
#pragma mark- delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"customCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *classStr = [_dataArray[indexPath.row] stringByAppendingString:@"ViewController"];
    UIViewController *viewController = nil;
    viewController = [[NSClassFromString(classStr) alloc] init];
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


#pragma mark-
#pragma mark- Getters && Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"CATransition",@"CABasicAnimation",@"CAKeyFrameAnimation",@"CASpringAnimation",@"CAAnimationGrop",@"UIView Transition",@"FaceBook Pop Animation", nil];
    }
    return _dataArray;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
