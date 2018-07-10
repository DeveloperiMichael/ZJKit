//
//  ZJBasePopupViewController.m
//  ZJKit
//
//  Created by 张炯 on 2018/6/1.
//

#import "ZJBasePopupViewController.h"
#import "ZJKit.h"
#import <Masonry/Masonry.h>

@interface ZJBasePopupViewController ()


@property (nonatomic, weak) UIViewController *showFromContrller;

@property (nonatomic, strong) ZJMaskView *maskView;

@end

@implementation ZJBasePopupViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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




#pragma mark-
#pragma mark- Event response



#pragma mark-
#pragma mark- Private Methods

- (void)showFromController:(UIViewController *)fromController animated:(BOOL)animated {
    
    //if (_isShowed || _isAnimating) return;
    if ([fromController isKindOfClass:[UITabBarController class]]) {
        
    }else if ([fromController isKindOfClass:[UINavigationController class]]){
        
    }else if ([fromController isKindOfClass:[UIViewController class]]) {
        if (fromController.navigationController) {
            fromController = fromController.navigationController;
        }
    }
    //当前控制器present出新的控制器，覆盖当前控制器
    fromController.definesPresentationContext = YES;
    self.providesPresentationContextTransitionStyle = YES;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.showFromContrller = fromController;
    [fromController presentViewController:self animated:NO completion:^{

        self.maskView.hidden = !self.maskView.hidden;
        [self.view startTransitionAnimationType:4 subType:2 duration:1.0];
        
    }];
}

- (void)dismiss:(BOOL)animated compeletion:(ZJPopupAnimationBlock)compeletion {
    [self.showFromContrller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-
#pragma mark- Getters && Setters

- (ZJMaskView *)maskView {
    if (!_maskView) {
        _maskView = [[ZJMaskView alloc] initWithShowInView:self.view customView:nil edgeInsets:self.contentInsets];
        _maskView.hidden = YES;
        [_maskView showAnimated:NO completion:nil];
    }
    return _maskView;
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    _maskView.edgeInsets = _contentInsets;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:_maskView];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
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
