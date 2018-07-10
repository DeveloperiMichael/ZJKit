//
//  SACustomView.m
//  ZJKit
//
//  Created by 张炯 on 2018/4/3.
//

#import "ZJMaskView.h"
#import "ZJKit.h"
#import <Masonry/Masonry.h>

@interface ZJMaskView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, weak) UIView *showInView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *customView;

@end

@implementation ZJMaskView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithShowInView:(UIView *)showInView
                        customView:(UIView *)customView
                        edgeInsets:(UIEdgeInsets)edgeInsets {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        if (!showInView) {
            self.showInView = [[UIApplication sharedApplication] delegate].window;
        }else {
            self.showInView = showInView;
        }
        self.alpha = 0.0;
        _edgeInsets = edgeInsets;
        if (customView) {
            _customView = customView;
        }
        [self setupSubviewsContraints];
    }
    return self;
}

- (instancetype)init {
    return [self initWithShowInView:nil customView:nil edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithShowInView:nil customView:nil edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithShowInView:nil customView:nil edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark-
#pragma mark- Event response

- (void)backgroundViewTaped:(UITapGestureRecognizer *)tapGesture {
    [self hideAnimated:YES completion:nil];
}


#pragma mark-
#pragma mark- Private Methods

- (void)showAnimated:(BOOL)animated completion:(ZJMaskViewDismissBlock)completion {
    [self.showInView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    [self.showInView addSubview:self];
    self.alpha = 0.0;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }else {
        self.alpha = 1.0;
        if (completion) {
            completion();
        }
    }
}

- (void)hideAnimated:(BOOL)animated completion:(ZJMaskViewDismissBlock)completion {
    if (!self.dismiss) {
        self.dismiss = completion;
    }
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (self.superview) {
                [self removeFromSuperview];
            }
            
            if (self.dismiss) {
                self.dismiss();
            }
        }];
    }else {
        self.alpha = 0.0;
        if (self.superview) {
            [self removeFromSuperview];
        }
        
        if (self.dismiss) {
            self.dismiss();
        }
    }
    
    
}


#pragma mark-
#pragma mark- Getters && Setters

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [[ZJColor zj_colorC4] colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTaped:)];
        [_backgroundView addGestureRecognizer:tap];
        
    }
    return _backgroundView;
}


- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 6.0;
    }
    return _contentView;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edgeInsets);
    }];
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.showInView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.contentView];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UIEdgeInsets edgeInsets = _edgeInsets;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edgeInsets);
    }];
    
    if (_customView) {
        [_contentView addSubview:_customView];
        _customView.layer.masksToBounds = YES;
        _customView.layer.cornerRadius = 6.0;
        [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    
}

////Push动画逻辑
//- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    //还是使用截图大法来完成动画，不然还是会有奇妙的bug;
//    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    tempView.frame = fromVC.view.frame;
//    UIView *containerView = [transitionContext containerView];
//    //将将要动画的视图加入containerView
//    [containerView addSubview:toVC.view];
//    [containerView addSubview:tempView];
//    fromVC.view.hidden = YES;
//    [containerView insertSubview:toVC.view atIndex:0];
//    //设置AnchorPoint，并增加3D透视效果
//    [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
//    CATransform3D transfrom3d = CATransform3DIdentity;
//    transfrom3d.m34 = -0.002;
//    containerView.layer.sublayerTransform = transfrom3d;
//    //增加阴影
//    CAGradientLayer *fromGradient = [CAGradientLayer layer];
//    fromGradient.frame = fromVC.view.bounds;
//    fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
//                            (id)[UIColor blackColor].CGColor];
//    fromGradient.startPoint = CGPointMake(0.0, 0.5);
//    fromGradient.endPoint = CGPointMake(0.8, 0.5);
//    UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
//    fromShadow.backgroundColor = [UIColor clearColor];
//    [fromShadow.layer insertSublayer:fromGradient atIndex:1];
//    fromShadow.alpha = 0.0;
//    [tempView addSubview:fromShadow];
//    CAGradientLayer *toGradient = [CAGradientLayer layer];
//    toGradient.frame = fromVC.view.bounds;
//    toGradient.colors = @[(id)[UIColor blackColor].CGColor,
//                          (id)[UIColor blackColor].CGColor];
//    toGradient.startPoint = CGPointMake(0.0, 0.5);
//    toGradient.endPoint = CGPointMake(0.8, 0.5);
//    UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
//    toShadow.backgroundColor = [UIColor clearColor];
//    [toShadow.layer insertSublayer:toGradient atIndex:1];
//    toShadow.alpha = 1.0;
//    [toVC.view addSubview:toShadow];
//    //动画吧
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        //翻转截图视图
//        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
//        //给阴影效果动画
//        fromShadow.alpha = 1.0;
//        toShadow.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        if ([transitionContext transitionWasCancelled]) {
//            //失败后记得移除截图，下次push又会创建
//            [tempView removeFromSuperview];
//            fromVC.view.hidden = NO;
//        }
//    }];
//}
////Pop动画逻辑
//- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *containerView = [transitionContext containerView];
//    //拿到push时候的的截图视图
//    UIView *tempView = containerView.subviews.lastObject;
//    [containerView addSubview:toVC.view];
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        //把截图视图翻转回来
//        tempView.layer.transform = CATransform3DIdentity;
//        fromVC.view.subviews.lastObject.alpha = 1.0;
//        tempView.subviews.lastObject.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        if ([transitionContext transitionWasCancelled]) {
//            [transitionContext completeTransition:NO];
//        }else{
//            [transitionContext completeTransition:YES];
//            [tempView removeFromSuperview];
//            toVC.view.hidden = NO;
//        }
//    }];
//    
//}

@end
