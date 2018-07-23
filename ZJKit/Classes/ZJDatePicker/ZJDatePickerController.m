//
//  ZJDatePickerController.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import "ZJDatePickerController.h"
#import <Masonry/Masonry.h>
#import "ZJDateAndTimePickerView.h"

@interface ZJDatePickerController ()<ZJDateAndTimePickerViewDelegate>

@property (nonatomic, assign) ZJDatePickerMode pickerMode;
@property (nonatomic, strong) ZJDateAndTimePickerView *dateAndTimePickerView;

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
    [self.dateAndTimePickerView show:YES completion:nil];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *curDate = [NSDate date];
    NSDate *endDate = [calender dateByAddingUnit:NSCalendarUnitYear value:20 toDate:curDate options:NSCalendarWrapComponents];
    

}




#pragma mark-
#pragma mark- Private Methods



#pragma mark-
#pragma mark- ZJDateAndTimePickerViewDelegate

- (void)zj_dateAndTimePickerView:(ZJDateAndTimePickerView *)dateAndTimePickerView didSelectDate:(NSDate *)selectDate {
    NSLog(@"========selectDate:%@=======",selectDate);
}


#pragma mark-
#pragma mark- Getters && Setters

- (ZJDateAndTimePickerView *)dateAndTimePickerView {
    if (!_dateAndTimePickerView) {
        _dateAndTimePickerView = [[ZJDateAndTimePickerView alloc] initWithTitle:@"请选择日期"];
        _dateAndTimePickerView.delegate = self;
    }
    return _dateAndTimePickerView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.dateAndTimePickerView];
    [_dateAndTimePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
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
