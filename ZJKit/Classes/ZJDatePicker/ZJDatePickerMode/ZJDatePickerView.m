//
//  ZJDatePickerView.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import "ZJDatePickerView.h"

#import "ZJPickerView.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>
#import "ZJCalenderHandle.h"

static CGFloat kZJDateAndTimePickerViewMargin = 5.0f;

static CGFloat kZJDatePickerViewContentHeight = 330.0f;

@interface ZJDatePickerView ()<ZJPickerViewDataSource,ZJPickerViewDelegate,UIGestureRecognizerDelegate>

{
    NSDate *_defaultMinDate;
    NSDate *_defaultSelectDate;
    NSDate *_defaultMaxDate;
    
    NSArray *_years;
    NSArray *_months;
    NSArray *_days;
    
    
    NSInteger _selectYear;
    NSInteger _selectMonth;
    NSInteger _selectDay;
    
}

@property (nonatomic, strong) ZJPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *componentArray;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat labelWidth;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *selectDate;
@property (nonatomic, strong) NSDateComponents *selComponents;
@property (nonatomic, strong) NSDateComponents *minComponents;
@property (nonatomic, strong) NSDateComponents *maxComponents;


@property (nonatomic, strong) NSCalendar *calendar;


@end

@implementation ZJDatePickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.title = title;
        [self setupData];
        [self checkDatesLegality];
        [self setupSubviewsContraints];
        [self setComponentsScrollToCorrectIndex];
    }
    return self;
}

- (instancetype)initWithMinimumDate:(NSDate *)minDate maximumDate:(NSDate *)maxDate selectDate:(NSDate *)selectDate {
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.title = nil;
        [self setupData];
        [self setDatePickerMinDate:minDate maxDate:maxDate selectDate:selectDate];
        [self checkDatesLegality];
        [self setupSubviewsContraints];
        [self setComponentsScrollToCorrectIndex];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _labelWidth = (self.frame.size.width-20-kZJDateAndTimePickerViewMargin*(3+1))/3;
    [self setupTitleLabels];
}


#pragma mark-
#pragma mark- <ZJPickerViewDataSource,ZJPickerViewDelegate>

- (NSInteger)zj_numberOfComponentsInPickerView:(ZJPickerView *)pickerView {
    return self.componentArray.count;
}


- (NSInteger)zj_pickerView:(ZJPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [(NSArray *)self.componentArray[component] count];
}

- (CGFloat)zj_rowHeightForComponentPickerView:(UIPickerView *)pickerView {
    return 37.0;
}


- (nullable NSString *)zj_pickerView:(ZJPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.componentArray[component][row];
}


- (void)zj_pickerView:(ZJPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            _selectYear = [_years[row] integerValue];
            [self regulateSelectDateIfBeyond:NSCalendarUnitYear];
        }
            break;
        case 1:
        {
            _selectMonth = [_months[row] integerValue];
            
            [self regulateSelectDateIfBeyond:NSCalendarUnitMonth];
            
            NSDate *date = [self.calendar dateWithEra:_selectYear/100 year:_selectYear month:_selectMonth day:1 hour:0 minute:0 second:0 nanosecond:0];
            _days = [ZJCalenderHandle dataArrayOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
            [self.componentArray replaceObjectAtIndex:2 withObject:_days];
            
            if (_selectDay>_days.count) {
                _selectDay = _days.count;
            }
            [self.pickerView reloadComponent:2 withSelectRowAtIndex:_selectDay-1];
        }
            break;
        case 2:
        {
            _selectDay = [_days[row] integerValue];
            [self regulateSelectDateIfBeyond:NSCalendarUnitDay];
        }
            break;
        
            
        default:
            break;
    }
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}


#pragma mark-
#pragma mark- Event response

- (void)backgroundTapAction:(UITapGestureRecognizer *)tapGesture {
    [self hide:YES completion:nil];
}

- (void)sureButtonAction:(UIButton *)button {
    [self hide:YES completion:nil];
    
    _selectDate = [self.calendar dateWithEra:_selectYear/100 year:_selectYear month:_selectMonth day:_selectDay hour:0 minute:0 second:0 nanosecond:0];
    
    if ([_delegate respondsToSelector:@selector(zj_datePickerView:didSelectDate:)]) {
        [_delegate zj_datePickerView:self didSelectDate:_selectDate];
    }
}

#pragma mark-
#pragma mark- Private Methods

- (void)setupData {
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.alpha = 0.0;
    
    _minDate = _defaultMinDate = [ZJCalenderHandle dateOffset:-20 calendarUnit:NSCalendarUnitYear fromDate:[NSDate date]];
    _maxDate = _defaultMaxDate = [ZJCalenderHandle dateOffset:20 calendarUnit:NSCalendarUnitYear fromDate:[NSDate date]];
    _selectDate = _defaultSelectDate = [NSDate date];
    
    [self setupCalenderUnitData];
    
}

- (void)checkDatesLegality {
    BOOL legality;
    NSDate *laterDate = [self.selectDate laterDate:self.minDate];
    NSDate *ealierDate = [self.selectDate earlierDate:self.maxDate];
    legality = [laterDate isEqualToDate:ealierDate];
    NSAssert(legality, @"<ZJDateAndTimePickerView>:please check setting dates");
}


- (void)setupCalenderUnitData {
    
    _years = [ZJCalenderHandle dateArrayOfUnit:NSCalendarUnitYear fromDate:_minDate toDate:_maxDate];
    _months = [ZJCalenderHandle dateArrayOfUnit:NSCalendarUnitMonth fromDate:_minDate toDate:_maxDate];
    _days = [ZJCalenderHandle dateArrayOfUnit:NSCalendarUnitDay fromDate:_minDate toDate:_maxDate];
    
    self.componentArray = [NSMutableArray arrayWithObjects:_years,_months,_days,nil];
    
    self.selComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_selectDate];
    self.minComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_minDate];
    self.maxComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_maxDate];
    _selectYear = _selComponents.year;
    _selectMonth = _selComponents.month;
    _selectDay = _selComponents.day;
}

- (void)setComponentsScrollToCorrectIndex {
    NSDateComponents *minComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_minDate];
    
    [self.pickerView selectRow:_selectYear-minComponents.year inComponent:0 animated:NO];
    [self.pickerView selectRow:_selectMonth-1 inComponent:1 animated:NO];
    [self.pickerView selectRow:_selectDay-1 inComponent:2 animated:NO];
}

- (void)regulateSelectDateIfBeyond:(NSCalendarUnit)changeUnit {
    switch (changeUnit) {
        case NSCalendarUnitYear:
        {
            NSDate *tempDate = [self.calendar dateWithEra:_selectYear/100 year:_selectYear month:_selectMonth day:_selectDay hour:0 minute:0 second:0 nanosecond:0];
            BOOL legality;
            NSDate *laterDate = [tempDate laterDate:self.minDate];
            NSDate *ealierDate = [tempDate earlierDate:self.maxDate];
            legality = [laterDate isEqualToDate:ealierDate];
            
            if (legality) {
                return;
            }
            
            if (_selectYear==self.minComponents.year||_selectYear==self.maxComponents.year) {
                _selectMonth = (_selectYear==self.minComponents.year)?self.minComponents.month:self.maxComponents.month;
                _selectDay = (_selectYear==self.minComponents.year)?self.minComponents.day:self.maxComponents.day;
                
                [self.pickerView reloadComponent:1 withSelectRowAtIndex:_selectMonth-1];
                [self.pickerView reloadComponent:2 withSelectRowAtIndex:_selectDay-1];
                
            }
            
        }
            break;
        case NSCalendarUnitMonth:
        {
            if (_selectYear==self.minComponents.year&&_selectMonth<self.minComponents.month) {
                _selectMonth = self.minComponents.month;
                [self.pickerView reloadComponent:1 withSelectRowAtIndex:_selectMonth-1];
            }
            
            if (_selectYear==self.maxComponents.year&&_selectMonth>self.maxComponents.month) {
                _selectMonth = self.maxComponents.month;
                [self.pickerView reloadComponent:1 withSelectRowAtIndex:_selectMonth-1];
            }
        }
            break;
        case NSCalendarUnitDay:
        {
            if (_selectYear==self.minComponents.year&&_selectMonth==self.minComponents.month&&_selectDay<self.minComponents.day) {
                _selectDay = self.minComponents.day;
                [self.pickerView reloadComponent:2 withSelectRowAtIndex:_selectDay-1];
            }
            
            if (_selectYear==self.maxComponents.year&&_selectMonth==self.maxComponents.month&&_selectDay>self.maxComponents.day) {
                _selectDay = self.maxComponents.day;
                [self.pickerView reloadComponent:2 withSelectRowAtIndex:_selectDay-1];
            }
        }
            break;
        
            break;
        default:
            break;
    }
}

#pragma mark-
#pragma mark- Public Methods

- (void)show:(BOOL)animated completion:(void(^)(void))completion {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1.0;
            self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -kZJDatePickerViewContentHeight);
        }];
    } else {
        self.alpha = 1.0;
        self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -kZJDatePickerViewContentHeight);
    }
    
    
}

- (void)hide:(BOOL)animated completion:(void(^)(void))completion {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.transform = CGAffineTransformIdentity;
            self.alpha = 0.0;
        }];
    } else {
        self.contentView.transform = CGAffineTransformIdentity;
        self.alpha = 0.0;
    }
    
}

- (void)setDatePickerMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectDate:(NSDate *)selectDate {
    self.minDate = minDate?:_defaultMinDate;
    self.maxDate = maxDate?:_defaultMaxDate;
    self.selectDate = selectDate?:_defaultSelectDate;
    [self checkDatesLegality];
    [self setupCalenderUnitData];
    [self setComponentsScrollToCorrectIndex];
}


#pragma mark-
#pragma mark- Getters && Setters

- (ZJPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[ZJPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView =[[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 10.0;
    }
    return _contentView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [ZJColor zj_colorC9];
    }
    return _titleView;
}

- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.textColor = [ZJColor zj_colorC5];
        _titlelabel.font = [ZJFont zj_font32px:ZJFontTypeBold];
        _titlelabel.text = @"请选择日期";
    }
    return _titlelabel;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[ZJColor zj_colorC3] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [ZJFont zj_font28px:ZJFontTypeRegular];
        _sureButton.backgroundColor = [ZJColor zj_colorC1];
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = 15.0;
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title.length>0) {
        _titlelabel.text = _title;
    }
}

- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
    UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapAction:)];
    backgroundTap.delegate = self;
    [self addGestureRecognizer:backgroundTap];
    
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addSubview:self.titleView];
    [self.titleView addSubview:self.titlelabel];
    [self.titleView addSubview:self.sureButton];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(kZJDatePickerViewContentHeight);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).mas_offset(-35.0);
        make.left.mas_equalTo(self.contentView).mas_offset(10.0);
        make.right.mas_equalTo(self.contentView).mas_offset(-10.0);
        make.height.mas_equalTo(37.0*5);
    }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(50.0);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.titleView).mas_offset(-15.0);
        make.centerY.mas_equalTo(self.titleView.mas_centerY);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(30.0);
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleView).mas_offset(15.0);
        make.right.mas_equalTo(self.sureButton.mas_left);
        make.top.bottom.mas_equalTo(self.titleView);
    }];
    
}

- (void)setupTitleLabels {
    
    for(UIView *view in self.contentView.subviews)
    {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *dateArray = @[@"年",@"月",@"日"];
    for (int i=0; i<dateArray.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [ZJColor zj_colorC7];
        label.font = [ZJFont zj_font30px:ZJFontTypeRegular];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = dateArray[i];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pickerView.mas_left).mas_offset((kZJDateAndTimePickerViewMargin+_labelWidth)*i+kZJDateAndTimePickerViewMargin);
            make.bottom.mas_equalTo(self.pickerView.mas_top);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(_labelWidth);
        }];
    }
}



@end
