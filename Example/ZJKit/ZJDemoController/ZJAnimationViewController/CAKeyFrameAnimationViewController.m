//
//  CAKeyFrameViewController.m
//  DMAnimation
//
//  Created by 张炯 on 2017/8/4.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CAKeyFrameAnimationViewController.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>

@interface CAKeyFrameAnimationViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIView *movePoint;
@property (nonatomic, strong) CAShapeLayer *myShapeLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIView *rectPoint;


@end

@implementation CAKeyFrameAnimationViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
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

- (void)startAnimation:(UIButton *)button {
    [self layerAnimation];
    [self testMove];//用values作路径
    [self testMove2];//用贝塞尔曲线作路径
}

#pragma mark-
#pragma mark- Private Methods

/**
 （1）values属性
 
 values属性指明整个动画过程中的关键帧点，需要注意的是，起点必须作为values的第一个值。
 
 （2）path属性
 
 作用与values属性一样，同样是用于指定整个动画所经过的路径的。需要注意的是，values与path是互斥的，当values与path同时指定时，path会覆盖values，即values属性将被忽略。
 */
- (void)testMove
{
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x*2-50, 100)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x*2-50, self.view.center.y*2-100)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(50, self.view.center.y*2-100)];
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    
    NSArray *values = @[v1,v2,v3,v4,v5];
    NSArray *keyTimes = @[@(0.0),@(0.1), @(0.5),@(0.6),@(1.0)]; //每一帧用的时间
    
    [self.rectPoint startKeyFrameAnimation:values keyTimes:keyTimes duration:5.0];
    
}


-(void)testMove2{
    
    [self.movePoint startKeyFrameAnimation:_path.CGPath duration:2.0 repeatCount:MAXFLOAT];
}

-(void)layerAnimation
{
    //贝塞尔画圆
    _path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:120 startAngle:0 endAngle:M_PI*2 clockwise:NO];
    
    //初始化shapeLayer
    self.myShapeLayer = [CAShapeLayer layer];
    //_myShapeLayer.frame = _movePoint.bounds;
    
    _myShapeLayer.strokeColor = [UIColor brownColor].CGColor;//边沿线色
    _myShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充色
    
    _myShapeLayer.lineJoin = kCALineJoinMiter;//线拐点的类型
    _myShapeLayer.lineCap = kCALineCapSquare;//线终点
    
    //从贝塞尔曲线获得形状
    _myShapeLayer.path = _path.CGPath;
    
    //线条宽度
    _myShapeLayer.lineWidth = 5.0;
    
    //起始和终止
    _myShapeLayer.strokeStart = 0.0;
    _myShapeLayer.strokeEnd = 1.0;
    
    //将layer添加进图层
    [self.view.layer addSublayer:_myShapeLayer];
}


#pragma mark 动画的代理方法 动画开始的时候调用
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}
#pragma mark 动画结束的时候调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
}


#pragma mark-
#pragma mark- Getters && Setters

- (UIView *)movePoint {
    if (!_movePoint) {
        _movePoint = [[UIView alloc] init];
        _movePoint.backgroundColor = [UIColor redColor];
    }
    return _movePoint;
}

- (UIView *)rectPoint {
    if (!_rectPoint) {
        _rectPoint = [[UIView alloc] init];
        _rectPoint.backgroundColor = [UIColor orangeColor];
    }
    return _rectPoint;
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


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.movePoint];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.rectPoint];

    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(50);
        make.right.mas_equalTo(self.view).mas_offset(-50);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.view).mas_offset(-40);
    }];
    [_movePoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [_rectPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
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
