//
//  ZJViewController.m
//  ZJKit
//
//  Created by DeveloperiMichael on 05/23/2018.
//  Copyright (c) 2018 DeveloperiMichael. All rights reserved.
//

#import "ZJViewController.h"
#import "CATransitionViewController.h"
#import "CABasicAnimationViewController.h"
#import "CAKeyFrameAnimationViewController.h"
#import <Masonry/Masonry.h>

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
     [self.view addSubview:self.tableView];
    self.title = @"ZJKit";
    
    NSString *listPath = [[NSBundle mainBundle] pathForResource:@"classDataList" ofType:@"plist"];
    self.componentArray = [NSArray arrayWithContentsOfFile:listPath];
    
    
//    CATransitionViewController *v1 = [CATransitionViewController new];
//    v1.tabBarItem.image = [UIImage imageNamed:@"icon_home"];
//    v1.tabBarItem.title = @"篮球";
//    v1.view.backgroundColor = [UIColor orangeColor];
//
//    CABasicAnimationViewController *v2 = [CABasicAnimationViewController new];
//    v2.tabBarItem.image = [UIImage imageNamed:@"icon_basketball"];
//    v2.tabBarItem.title = @"室内";
//    v2.view.backgroundColor = [UIColor greenColor];
//
//    CAKeyFrameAnimationViewController *v3 = [CAKeyFrameAnimationViewController new];
//    v3.tabBarItem.image = [UIImage imageNamed:@"icon_outdoor"];
//    v3.tabBarItem.title = @"户外";
//    v3.view.backgroundColor = [UIColor yellowColor];
//
//    UINavigationController *n1 = [[UINavigationController alloc] initWithRootViewController:v1];
//    UINavigationController *n2 = [[UINavigationController alloc] initWithRootViewController:v2];
//    UINavigationController *n3 = [[UINavigationController alloc] initWithRootViewController:v3];
//
//    NSArray *array = @[n1,n2,n3];
//    self.viewControllers = array;
    
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
        
//        //若你的产品只需兼容8.0以上的系统 如下就行
//        viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        viewController.providesPresentationContextTransitionStyle = YES;
//        viewController.definesPresentationContext = YES;
//        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        //UIModalPresentationOverCurrentContext IOS 8.0 以后才出的方法 所以处理略有不同(很奇怪的是8.0以后的系统 如果这里采用以前的方法 屏幕背景就会在视图加载完成过后的一瞬间变黑)
//        [self presentViewController:viewController animated:YES completion:nil];
        
    }
    
}


@end
