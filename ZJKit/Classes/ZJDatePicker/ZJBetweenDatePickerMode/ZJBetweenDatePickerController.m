//
//  ZJBetweenDatePickerController.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/24.
//

#import "ZJBetweenDatePickerController.h"
#import "ZJBetweenDatePickerView.h"
#import <Masonry/Masonry.h>

@interface ZJBetweenDatePickerController ()<ZJBetweenDatePickerViewDelegate>

@property (nonatomic, strong) ZJBetweenDatePickerView *betweenDatePickerView;

@end

@implementation ZJBetweenDatePickerController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"show" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor brownColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(100);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupSubviewsContraints];
}


#pragma mark-
#pragma mark- delegate

- (void)zj_betweenDatePickerView:(ZJBetweenDatePickerView *)betweenDatePickerView didSelectStartDate:(NSDate *)startDate selectEndDate:(NSDate *)endDate {
    NSLog(@"========selectDate:%@=======",startDate);
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [df stringFromDate:startDate];
    NSLog(@"========selectDateString:%@=======",string);
}


#pragma mark-
#pragma mark- Event response

- (void)buttonAction:(UIButton *)button {
    [self.betweenDatePickerView show:YES completion:nil];
}

#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (ZJBetweenDatePickerView *)betweenDatePickerView {
    if (!_betweenDatePickerView) {
        _betweenDatePickerView = [[ZJBetweenDatePickerView alloc] initWithDatePickerMode:0];
//        [_betweenDatePickerView setStartMinDate:[[NSDate date] dateByAddingTimeInterval:-10*365*24*3600] maxDate:[[NSDate date] dateByAddingTimeInterval:10*365*24*3600] selectDate:[NSDate date]];
//        [_betweenDatePickerView setEndMinDate:[[NSDate date] dateByAddingTimeInterval:-30*365*24*3600] maxDate:[[NSDate date] dateByAddingTimeInterval:30*365*24*3600] selectDate:[[NSDate date] dateByAddingTimeInterval:24*3600]];
        _betweenDatePickerView.delegate = self;
    }
    return _betweenDatePickerView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.betweenDatePickerView];
    [_betweenDatePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
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
