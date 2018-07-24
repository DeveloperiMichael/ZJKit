//
//  ZJDatePickerController.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import "ZJDatePickerController.h"
#import <Masonry/Masonry.h>
#import "ZJDateAndTimePickerView.h"
#import "ZJDatePickerView.h"
#import "ZJBetweenDatePickerController.h"


@interface ZJDatePickerController ()<ZJDateAndTimePickerViewDelegate,ZJDatePickerViewDelegate>

@property (nonatomic, assign) ZJDatePickerMode pickerMode;
@property (nonatomic, strong) ZJDateAndTimePickerView *dateAndTimePickerView;
@property (nonatomic, strong) ZJDatePickerView *datePickerView;
@end

@implementation ZJDatePickerController


- (instancetype)initWithPickerMode:(ZJDatePickerMode)mode {
    self = [super init];
    if (self) {
        self.pickerMode = mode;
    }
    return self;
}

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerMode = ZJDatePickerModeDateAndTime;
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
#pragma mark- Event response

- (void)buttonAction:(UIButton *)button {
    //[self.datePickerView show:YES completion:nil];
    ZJBetweenDatePickerController *vc = [[ZJBetweenDatePickerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark-
#pragma mark- Private Methods



#pragma mark-
#pragma mark- ZJDateAndTimePickerViewDelegate

- (void)zj_dateAndTimePickerView:(ZJDateAndTimePickerView *)dateAndTimePickerView didSelectDate:(NSDate *)selectDate {
    NSLog(@"========selectDate:%@=======",selectDate);
}

- (void)zj_datePickerView:(ZJDatePickerView *)datePickerView didSelectDate:(NSDate *)selectDate {
    NSLog(@"========selectDate:%@=======",selectDate);
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [df stringFromDate:selectDate];
    NSLog(@"========selectDateString:%@=======",selectDate);
}

#pragma mark-
#pragma mark- Getters && Setters

- (ZJDateAndTimePickerView *)dateAndTimePickerView {
    if (!_dateAndTimePickerView) {
        _dateAndTimePickerView = [[ZJDateAndTimePickerView alloc] initWithMinimumDate:[[NSDate date] dateByAddingTimeInterval:-10*365*24*3600] maximumDate:[[NSDate date] dateByAddingTimeInterval:10*365*24*3600] selectDate:[NSDate date]];
        _dateAndTimePickerView.delegate = self;
    }
    return _dateAndTimePickerView;
}

- (ZJDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[ZJDatePickerView alloc] initWithTitle:@"Select Your Date"];
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.datePickerView];
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
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
