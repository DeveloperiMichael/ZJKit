//
//  ZJDateAndTimePickerView.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import "ZJDateAndTimePickerView.h"
#import "ZJPickerView.h"
#import <Masonry/Masonry.h>
#import <ZJKit/ZJKit.h>
#import "ZJCalenderHandle.h"

static CGFloat kZJDateAndTimePickerViewMargin = 5.0f;

@interface ZJDateAndTimePickerView ()<ZJPickerViewDataSource,ZJPickerViewDelegate,UIGestureRecognizerDelegate>

{
    NSDate *_defaultMinDate;
    NSDate *_defaultSelectDate;
    NSDate *_defaultMaxDate;
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



@end

@implementation ZJDateAndTimePickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.title = title;
        [self setupData];
        [self checkDatesLegality];
        [self setupSubviewsContraints];
         [self setupCalender];
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
        [self setupCalender];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _labelWidth = (self.frame.size.width-20-kZJDateAndTimePickerViewMargin*(5+1))/5;
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
    NSLog(@"===didSelectRowAtIndex:%ld==inComponent:%ld===",row,component);
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
    if ([_delegate respondsToSelector:@selector(zj_dateAndTimePickerView:didSelectDate:)]) {
        [_delegate zj_dateAndTimePickerView:self didSelectDate:nil];
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
}

- (void)checkDatesLegality {
    BOOL legality;
    NSDate *laterDate = [self.selectDate laterDate:self.minDate];
    NSDate *ealierDate = [self.selectDate earlierDate:self.maxDate];
    legality = [laterDate isEqualToDate:ealierDate];
    NSAssert(legality, @"<ZJDateAndTimePickerView>:please check setting dates");
}

- (void)setupCalender {
    //nscal
}

#pragma mark-
#pragma mark- Public Methods

- (void)show:(BOOL)animated completion:(void(^)(void))completion {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1.0;
            self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -330.0);
        }];
    } else {
        self.alpha = 1.0;
        self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -330.0);
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

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
    NSArray *array1 =  @[@"A-0",@"A-1",@"A-2",@"A-3",@"A-4",@"A-5",@"A-6",@"A-7",@"A-8",@"A-9",@"A-10",@"A-11",@"A-12"];
    NSArray *array2 = @[@"B-0",@"B-1",@"B-2",@"B-3",@"B-4",@"B-5",@"B-6",@"B-7",@"B-8",@"B-9"];
    NSArray *array3 = @[@"C-0",@"C-1",@"C-2",@"C-3",@"C-4",@"C-5",@"C-6",@"C-7",@"C-8",@"C-9",@"C-10",@"C-11",@"C-12",@"C-13",@"C-14",@"C-15",@"C-16",@"C-17",@"C-18",@"C-19"];
    NSArray *array4 = @[@"B-0",@"B-1",@"B-2",@"B-3",@"B-4",@"B-5",@"B-6",@"B-7",@"B-8",@"B-9"];
    NSArray *array5 = @[@"C-0",@"C-1",@"C-2",@"C-3",@"C-4",@"C-5",@"C-6",@"C-7",@"C-8",@"C-9",@"C-10",@"C-11",@"C-12",@"C-13",@"C-14",@"C-15",@"C-16",@"C-17",@"C-18",@"C-19"];
    
    self.componentArray = [NSMutableArray arrayWithObjects:array1,array2,array3,array4,array5,nil];
    
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
        make.height.mas_equalTo(330.0);
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
    
    NSArray *dateArray = @[@"年",@"月",@"日",@"时",@"分"];
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
