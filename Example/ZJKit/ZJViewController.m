//
//  ZJViewController.m
//  ZJKit
//
//  Created by DeveloperiMichael on 05/23/2018.
//  Copyright (c) 2018 DeveloperiMichael. All rights reserved.
//

#import "ZJViewController.h"


@interface ZJViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *componentArray;

@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ZJKit";
    
    NSString *listPath = [[NSBundle mainBundle] pathForResource:@"classDataList" ofType:@"plist"];
    self.componentArray = [NSArray arrayWithContentsOfFile:listPath];
    
    [self.view addSubview:self.tableView];
    
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSArray *)componentArray {
    if (!_componentArray) {
        _componentArray = [NSArray array];
    }
    return _componentArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.componentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SAViewControler.cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *classDict = self.componentArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = classDict[@"titleName"];
    cell.textLabel.textColor =  [UIColor colorWithRed:46/255.0 green:111/255.0 blue:230/255.0 alpha:1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *classDict = self.componentArray[indexPath.row];
    
    UIViewController *viewController = nil;
    viewController = [[NSClassFromString(classDict[@"className"]) alloc] init];
    if (viewController) {
        viewController.title = classDict[@"titleName"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}


@end
