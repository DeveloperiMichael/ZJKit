//
//  ZJGCDTestViewController.m
//  ZJKit_Example
//
//  Created by 张炯 on 2018/6/29.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import "ZJGCDTestViewController.h"
#import <ZJKit/ZJKit.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZJWebImage.h"

@interface ZJGCDTestViewController ()

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ZJGCDTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"press" forState:UIControlStateNormal];
    button.backgroundColor = [ZJColor zj_colorC1];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-40);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(60);
    }];
    
    self.textField = [[UITextField alloc] init];
    self.textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(60);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(60);
    }];
    [self.textField addTarget:self action:@selector(textFieldEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
}

- (void)textFieldEndEditing:(UITextField *)textField {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(60);
        }];
    });
    
    
}



- (void)buttonAction {
    
    [self gcd_downloadWebImage];
}

//barrier
- (void)testDispatch_barrier {
    dispatch_queue_t queue = dispatch_queue_create("thread", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"test1");
    });
    dispatch_async(queue, ^{
        NSLog(@"test2");
    });
    dispatch_sync(queue, ^{
        NSLog(@"test3");
    });
    
    dispatch_barrier_sync(queue, ^{    ///分界线在这里 请注意是同步的
        sleep(1);
        for (int i = 0; i<50; i++) {
            if (i == 10 ) {
                NSLog(@"point1");
            }else if(i == 20){
                NSLog(@"point2");
            }else if(i == 40){
                NSLog(@"point3");
            }
        }
    });
    NSLog(@"hello");
    dispatch_async(queue, ^{
        NSLog(@"test4");
    });
    NSLog(@"world");
    dispatch_async(queue, ^{
        NSLog(@"test5");
    });
    dispatch_async(queue, ^{
        NSLog(@"test6");
    });
}

//崩溃、顺序不可控  线程安全相关
- (void)testThreadSafe {
    __block NSMutableArray *array = [NSMutableArray array];
    
    //有序执行 线程安全
    for (int i=0; i<100; i++) {
        dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        });
    }
    
//    顺序不可控 线程不安全
//    for (int i=0; i<100; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [array addObject:[NSString stringWithFormat:@"%d",i]];
//        });
//    }
    
    sleep(1.0);
    
    NSLog(@"======array:%@=====",array);
    
}


- (void)gcd_downloadWebImage {
    //reset UI
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }];
    [self.imageArray removeAllObjects];
    
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = 500+i;
        imageView.backgroundColor = [UIColor brownColor];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(100+i*145);
            make.width.mas_equalTo(192);
            make.height.mas_equalTo(120);
        }];
        
        NSString *urlStirng;
        
        switch (i) {
            case 0:
                urlStirng = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530606814475&di=fb9ee7919ecaef0645e641d3b7fd6590&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F038025357ebd1e5a84a0d304f6b9c4a.jpg";
                break;
            case 1:
                urlStirng = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2593714302,2044077513&fm=27&gp=0.jpg";
                break;
            case 2:
                urlStirng = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530606932066&di=712743a4e3024f52a2fbd9868ea80652&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F59783baf6219d.jpg";
                break;
            default:
                break;
        }
        
        dispatch_group_enter(self.group);
        
        ZJWebImage *webImage = [[ZJWebImage alloc] initWithImageUrl:urlStirng finishedDownloadImage:^(UIImage *image, NSError *error) {
            dispatch_group_leave(self.group);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadImage];
            });
            
        }];
        
        [self.imageArray addObject:webImage];
        
    }
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        
        ZJAlert *alert = [[ZJAlert alloc] initWithTitle:@"图片缓存" message:@"所有图片缓存完成" cancelTitle:nil cancelBlock:nil otherTitle:@"知道了" otherBlock:^{
            
        } alertStyle:ZJAlertStyleAlert fromViewController:self];
        [alert showAlert];
        
    });
}

- (void)reloadImage {
    for (int i=500; i<503; i++) {
        UIImageView *imageView = [self.view viewWithTag:i];
        ZJWebImage *webImage = self.imageArray[i-500];
        imageView.image = webImage.image;
    }
}



- (dispatch_group_t)group {
    if (!_group) {
        _group = dispatch_group_create();
    }
    return _group;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
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
