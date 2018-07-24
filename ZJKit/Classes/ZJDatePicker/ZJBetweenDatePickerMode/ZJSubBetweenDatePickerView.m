//
//  ZJSubBetweenDatePickerView.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/24.
//

#import "ZJSubBetweenDatePickerView.h"
#import "ZJPickerView.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>
#import "ZJCalenderHandle.h"

static CGFloat kZJSubBetweenDatePickerViewHeight = 185.0f;

@interface ZJSubBetweenDatePickerView ()<ZJPickerViewDataSource,ZJPickerViewDelegate>

{
    NSDate *_defaultMinDate;
    NSDate *_defaultSelectDate;
    NSDate *_defaultMaxDate;
    
    NSArray *_years;
    NSArray *_months;
    NSArray *_days;
    NSArray *_hours;
    NSArray *_minutes;
    
    NSInteger _selectYear;
    NSInteger _selectMonth;
    NSInteger _selectDay;
    NSInteger _selectHour;
    NSInteger _selectMinute;
}

@property (nonatomic, strong) ZJPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *componentArray;

@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *selectDate;
@property (nonatomic, strong) NSDateComponents *selComponents;
@property (nonatomic, strong) NSDateComponents *minComponents;
@property (nonatomic, strong) NSDateComponents *maxComponents;

@property (nonatomic, assign) ZJBetweenDatePickerMode datePickerMode;

@property (nonatomic, strong) NSCalendar *calendar;


@end

@implementation ZJSubBetweenDatePickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithDatePickerMode:(ZJBetweenDatePickerMode)mode {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.datePickerMode = mode;
        [self setupData];
        [self checkDatesLegality];
        [self setupSubviewsContraints];
        [self setComponentsScrollToCorrectIndex];
    }
    return self;
    
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kZJSubBetweenDatePickerViewHeight).priorityHigh();
    }];
}

- (void)addConstraint:(NSLayoutConstraint *)constraint {
    if (constraint.firstAttribute == NSLayoutAttributeHeight) {
        constraint.constant = kZJSubBetweenDatePickerViewHeight;
    }
    [super addConstraint:constraint];
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
    
    if (self.datePickerMode==ZJBetweenDateAndTimePickerMode||self.datePickerMode==ZJBetweenOnlyDatePickerMode) {
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
            case 3:
            {
                _selectHour = [_hours[row] integerValue];
                [self regulateSelectDateIfBeyond:NSCalendarUnitHour];
            }
                break;
            case 4:
            {
                _selectMinute = [_minutes[row] integerValue];
                [self regulateSelectDateIfBeyond:NSCalendarUnitMinute];
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (component) {
            case 0:
            {
                _selectHour = [_hours[row] integerValue];
                [self regulateSelectDateIfBeyond:NSCalendarUnitHour];
            }
                break;
            case 1:
            {
                _selectMinute = [_minutes[row] integerValue];
                [self regulateSelectDateIfBeyond:NSCalendarUnitMinute];
            }
                break;
                
            default:
                break;
        }
    }
    _selectDate = [self.calendar dateWithEra:_selectYear/100 year:_selectYear month:_selectMonth day:_selectDay hour:_selectHour minute:_selectMinute second:0 nanosecond:0];
    if ([_delegate respondsToSelector:@selector(zj_subBetweenDatePickerView:didSelectDate:)]) {
        [_delegate zj_subBetweenDatePickerView:self didSelectDate:_selectDate];
    }
    
}

#pragma mark-
#pragma mark- Private Methods

- (void)setupData {
    
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
    _hours = [ZJCalenderHandle dateArrayOfUnit:NSCalendarUnitHour fromDate:_minDate toDate:_maxDate];
    _minutes = [ZJCalenderHandle dateArrayOfUnit:NSCalendarUnitMinute fromDate:_minDate toDate:_maxDate];
    
    switch (self.datePickerMode) {
        case ZJBetweenDateAndTimePickerMode:
        {
            self.componentArray = [NSMutableArray arrayWithObjects:_years,_months,_days,_hours,_minutes,nil];
        }
            break;
        case ZJBetweenOnlyDatePickerMode:
        {
            self.componentArray = [NSMutableArray arrayWithObjects:_years,_months,_days,nil];
        }
            break;
        case ZJBetweenOnlyTimePickerMode:
        {
            self.componentArray = [NSMutableArray arrayWithObjects:_hours,_minutes,nil];
        }
            break;
        default:
            break;
    }
    
    self.selComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_selectDate];
    self.minComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_minDate];
    self.maxComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_maxDate];
    _selectYear = _selComponents.year;
    _selectMonth = _selComponents.month;
    _selectDay = _selComponents.day;
    _selectHour = _selComponents.hour;
    _selectMinute = _selComponents.minute;
}

- (void)setComponentsScrollToCorrectIndex {
    NSDateComponents *minComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:_minDate];
    
    [self.pickerView selectRow:_selectYear-minComponents.year inComponent:0 animated:NO];
    [self.pickerView selectRow:_selectMonth-1 inComponent:1 animated:NO];
    [self.pickerView selectRow:_selectDay-1 inComponent:2 animated:NO];
    [self.pickerView selectRow:_selectHour inComponent:3 animated:NO];
    [self.pickerView selectRow:_selectMinute inComponent:4 animated:NO];
}

- (void)regulateSelectDateIfBeyond:(NSCalendarUnit)changeUnit {
    switch (changeUnit) {
        case NSCalendarUnitYear:
        {
            NSDate *tempDate = [self.calendar dateWithEra:_selectYear/100 year:_selectYear month:_selectMonth day:_selectDay hour:_selectHour minute:_selectMinute second:0 nanosecond:0];
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
                _selectHour = (_selectYear==self.minComponents.year)?self.minComponents.hour:self.maxComponents.hour;
                _selectMinute = (_selectYear==self.minComponents.year)?self.minComponents.minute:self.maxComponents.minute;
                [self.pickerView reloadComponent:1 withSelectRowAtIndex:_selectMonth-1];
                [self.pickerView reloadComponent:2 withSelectRowAtIndex:_selectDay-1];
                [self.pickerView reloadComponent:3 withSelectRowAtIndex:_selectHour];
                [self.pickerView reloadComponent:4 withSelectRowAtIndex:_selectMinute];
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
        case NSCalendarUnitHour:
        {
            if (_selectYear==self.minComponents.year&&_selectMonth==self.minComponents.month&&_selectDay==self.minComponents.day&&_selectHour<self.minComponents.hour) {
                _selectHour = self.minComponents.hour;
                [self.pickerView reloadComponent:3 withSelectRowAtIndex:_selectHour];
            }
            
            if (_selectYear==self.maxComponents.year&&_selectMonth==self.maxComponents.month&&_selectDay==self.maxComponents.day&&_selectHour>self.maxComponents.hour) {
                _selectHour = self.maxComponents.hour;
                [self.pickerView reloadComponent:3 withSelectRowAtIndex:_selectHour];
            }
        }
            break;
        case NSCalendarUnitMinute:
        {
            if (_selectYear==self.minComponents.year&&_selectMonth==self.minComponents.month&&_selectDay==self.minComponents.day&&_selectHour==self.minComponents.hour&&_selectMinute<self.minComponents.minute) {
                _selectMinute = self.minComponents.minute;
                [self.pickerView reloadComponent:4 withSelectRowAtIndex:_selectMinute];
            }
            
            if (_selectYear==self.maxComponents.year&&_selectMonth==self.maxComponents.month&&_selectDay==self.maxComponents.day&&_selectHour==self.maxComponents.hour&&_selectMinute>self.maxComponents.minute) {
                _selectMinute = self.maxComponents.minute;
                [self.pickerView reloadComponent:4 withSelectRowAtIndex:_selectMinute];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark-
#pragma mark- Public Methods

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

- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}


@end

