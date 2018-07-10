//
//  CABasicViewController.m
//  DMAnimation
//
//  Created by 张炯 on 2017/8/3.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CABasicAnimationViewController.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>

@interface CABasicAnimationViewController ()<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>

@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *aniLabel;
@property (nonatomic, strong) NSArray *animationArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *animationType;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation CABasicAnimationViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupSubviewsContraints];
    
    
}

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
    _animationType = _animationArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark-
#pragma mark- Event response


/* CATransform3D Key Paths : (example)transform.rotation.z
 
rotation.x
rotation.y
rotation.z
rotation 旋轉
 
 
scale.x
scale.y
scale.z
scale 缩放
 
translation.x
translation.y
translation.z
translation 平移
 
 
CGPoint Key Paths : (example)position.x
x
y
CGRect Key Paths : (example)bounds.size.width
origin.x
origin.y
origin
size.width
size.height
size
opacity
backgroundColor
cornerRadius
borderWidth
contents
Shadow Key Path:
shadowColor
shadowOffset
shadowOpacity
shadowRadius
*/

- (NSArray *)animationArray {
    if (!_animationArray) {
        _animationArray = [NSArray arrayWithObjects:
                           @"transform.rotation.x",
                           @"transform.rotation.y",
                           @"transform.rotation.z",
                           @"transform.scale.x",
                           @"transform.scale.y",
                           @"transform.scale",
                           @"transform.translation.x",
                           @"transform.translation.y",
                           @"position.x",
                           @"position.y",
                           @"position",
                           @"opacity",
                           @"backgroundColor",
                           @"cornerRadius",
                           @"borderWidth",
                           @"contents",
                           @"shadowColor",
                           @"shadowOffset",
                           @"shadowOpacity",
                           @"shadowRadius",nil];
    }
    return _animationArray;
}

- (void)startAnimation:(UIButton *)button {
    
    id fromValue;
    id toValue;
    
    if ([_animationType hasPrefix:@"transform.rotation"]) {
        //transform.rotation
        fromValue = [NSNumber numberWithFloat:0];
        toValue = [NSNumber numberWithFloat:2*M_PI];
    }else if ([_animationType hasPrefix:@"transform.scale"]) {
        //transform.scale
        fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
        toValue = [NSNumber numberWithFloat:1.5]; // 结束时的倍率
    }else if ([_animationType hasPrefix:@"transform.translation"]) {
        //transform.translation  终点设定
        toValue = [NSNumber numberWithFloat:-200];
    }else if ([_animationType hasPrefix:@"opacity"]) {
        //opacity
        toValue = [NSNumber numberWithFloat:0.2];
    }else if ([_animationType hasPrefix:@"backgroundColor"]) {
        //backgroundColor
        toValue = (__bridge id _Nullable)([UIColor brownColor].CGColor);
    }else if ([_animationType hasPrefix:@"cornerRadius"]) {
        //cornerRadius
        //fromValue = [NSNumber numberWithFloat:0];
        toValue = [NSNumber numberWithFloat:60];
    }else if ([_animationType hasPrefix:@"contents"]) {
        //contents
        toValue = (__bridge id _Nullable)([UIImage imageNamed:@"to"].CGImage);
    }else if ([_animationType hasPrefix:@"borderWidth"]) {
        //borderWidth
        toValue = [NSNumber numberWithFloat:6];
    }else if ([_animationType hasPrefix:@"position"]) {
        //position
        if ([_animationType isEqualToString:@"position"]) {
            toValue = [NSValue valueWithCGPoint:CGPointMake(100, 50)];
        }else{
            toValue = [NSNumber numberWithFloat:100];
        }
    }else if ([_animationType hasPrefix:@"shadowColor"]) {
        //shadowColor
        toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    }else if ([_animationType hasPrefix:@"shadowOffset"]) {
        //shadowOffset
        toValue = [NSNumber numberWithFloat:16];
    }else if ([_animationType hasPrefix:@"shadowOpacity"]) {
        //shadowOpacity
        toValue = [NSNumber numberWithFloat:1.0];
    }else if ([_animationType hasPrefix:@"shadowRadius"]) {
        //shadowRadius
        toValue = [NSNumber numberWithFloat:15];
    }
    
    
    if ([_animationType hasPrefix:@"contents"]||[_animationType hasPrefix:@"cornerRadius"]) {
        [self.imgView startBasicAnimationkeyPath:_animationType fromValue:fromValue toValue:toValue duration:1.0];
    }else{
        [self.animationView startBasicAnimationkeyPath:_animationType fromValue:fromValue toValue:toValue duration:1.0];
    }
    
    

}


#pragma mark-
#pragma mark- Getters && Setters

- (UIView *)animationView {
    if (!_animationView) {
        _animationView = [[UIView alloc] init];
        _animationView.backgroundColor = [UIColor clearColor];
        _animationView.layer.shadowOffset = CGSizeZero;
        _animationView.layer.shadowColor = [UIColor blackColor].CGColor;
        _animationView.layer.shadowOpacity = 1.0;
        _animationView.layer.shadowRadius = 10;
        _animationView.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _animationView;
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

- (UILabel *)aniLabel {
    if (!_aniLabel) {
        _aniLabel = [[UILabel alloc] init];
        _aniLabel.text = @"Animation";
        _aniLabel.textColor = [UIColor whiteColor];
        _aniLabel.font = [UIFont systemFontOfSize:20.0];
        _aniLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _aniLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"from"]];
        _imgView.layer.cornerRadius = 10;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.animationView];
    [self.view addSubview:self.startButton];
    [self.animationView addSubview:self.imgView];
    [self.animationView addSubview:self.aniLabel];
    
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
    
    [_animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(20);
        make.width.height.mas_equalTo(200);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_animationView);
    }];
    [_aniLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_animationView);
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
