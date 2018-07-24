//
//  ZJBetweenDatePickerView.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/24.
//

#import "ZJBetweenDatePickerView.h"
#import <Masonry/Masonry.h>
#import "ZJSubBetweenDatePickerView.h"
#import <ZJKit/ZJKit.h>
#import "ZJCalenderHandle.h"

static CGFloat kZJSubBetweenDatePickerViewHeight = 430.0f;
static CGFloat kZJBetweenDatePickerViewMargin = 5.0f;

static NSString * const kDateFormatYYYYMMDD = @"yyyy-MM-dd";
static NSString * const kDateFormatYYYYMMDDHHmm = @"yyyy-MM-dd HH:mm";
static NSString * const kDateFormatHHmm = @"HH:mm";

@interface ZJBetweenDatePickerView ()<UIGestureRecognizerDelegate,ZJSubBetweenDatePickerViewDelegate>

{
    NSDate *_startMinDate;
    NSDate *_startMaxDate;
    NSDate *_startSelectDate;
    
    NSDate *_endMinDate;
    NSDate *_endMaxDate;
    NSDate *_endSelectDate;
    
}
@property (nonatomic, strong) ZJSubBetweenDatePickerView *startSubBetweenDatePickerView;
@property (nonatomic, strong) ZJSubBetweenDatePickerView *endSubBetweenDatePickerView;
@property (nonatomic, assign) ZJBetweenDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

/** switch start/end view */
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat labelWidth;

/** title view */
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *quickButton;

/** switch start/end view */
@property (nonatomic, strong) UIView *switchView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *endButton;
@property (nonatomic, strong) UIView *lineView;

/** unit view */
@property (nonatomic, strong) UIView *unitView;

@end

@implementation ZJBetweenDatePickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithDatePickerMode:(ZJBetweenDatePickerMode)mode {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.datePickerMode = mode;
        [self setupSubviewsContraints];
        [self setupData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.datePickerMode) {
        case ZJBetweenDateAndTimePickerMode:
        {
            _labelWidth = (self.frame.size.width-20-kZJBetweenDatePickerViewMargin*(5+1))/5;
        }
            break;
        case ZJBetweenOnlyDatePickerMode:
        {
            _labelWidth = (self.frame.size.width-20-kZJBetweenDatePickerViewMargin*(3+1))/3;
        }
            break;
        case ZJBetweenOnlyTimePickerMode:
        {
            _labelWidth = (self.frame.size.width-20-kZJBetweenDatePickerViewMargin*(2+1))/2;
        }
            break;
        default:
            break;
    }
    
    [self setupTitleLabels];
}

#pragma mark-
#pragma mark- delegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark-
#pragma mark- ZJSubBetweenDatePickerViewDelegate

- (void)zj_subBetweenDatePickerView:(ZJSubBetweenDatePickerView *)subBetweenDatePickerView didSelectDate:(NSDate *)selectDate {
    if (subBetweenDatePickerView == _startSubBetweenDatePickerView) {
        _startSelectDate = selectDate;
        NSString *startSelectString = [self.dateFormatter stringFromDate:_startSelectDate];
        [_startButton setTitle:startSelectString forState:UIControlStateNormal];
    } else {
        _endSelectDate = selectDate;
        NSString *endSelectString = [self.dateFormatter stringFromDate:_endSelectDate];
        [_endButton setTitle:endSelectString forState:UIControlStateNormal];
    }
}

#pragma mark-
#pragma mark- Event response

- (void)backgroundTapAction:(UITapGestureRecognizer *)tapGesture {
    [self hide:YES completion:nil];
}

- (void)sureButtonAction:(UIButton *)button {
    [self hide:YES completion:nil];
    
    if ([_delegate respondsToSelector:@selector(zj_betweenDatePickerView:didSelectStartDate:selectEndDate:)]) {
        [_delegate zj_betweenDatePickerView:self didSelectStartDate:_startSelectDate selectEndDate:_endSelectDate];
    }
    
}

- (void)switchButtonAction:(UIButton *)button {
    
    if (button==_startButton) {
        [self startButtonAction];
    }else{
        [self endButtonAction];
    }
    
}

- (void)quickButtonAction:(UIButton *)button {
    if (_startButton.selected) {
        [_startButton setTitle:@"开始：不限" forState:UIControlStateNormal];
        _startSelectDate = nil;
        [self endButtonAction];
        
    }else if(_endButton.selected){
        [_endButton setTitle:@"结束：不限" forState:UIControlStateNormal];
         _endSelectDate = nil;
        [self startButtonAction];
    }
    
}

- (void)setShowQuickButton:(BOOL)showQuickButton {
    _showQuickButton = showQuickButton;
    _quickButton.hidden = !_showQuickButton;
}

#pragma mark-
#pragma mark- Public Methods

- (void)show:(BOOL)animated completion:(void(^)(void))completion {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1.0;
            self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -kZJSubBetweenDatePickerViewHeight);
        }];
    } else {
        self.alpha = 1.0;
        self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -kZJSubBetweenDatePickerViewHeight);
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


#pragma mark-
#pragma mark- Private Methods

//- (void)setQuickButtonTitle:(NSString *)quickButtonTitle {
//    _quickButtonTitle = quickButtonTitle;
//    if (_quickButtonTitle.length>0) {
//        [_quickButton setTitle:_quickButtonTitle forState:UIControlStateNormal];
//    }
//
//}

- (void)setupData {
    _startMinDate = [ZJCalenderHandle dateOffset:-20 calendarUnit:NSCalendarUnitYear fromDate:[NSDate date]];
    _startMaxDate = [ZJCalenderHandle dateOffset:20 calendarUnit:NSCalendarUnitYear fromDate:[NSDate date]];
    _startSelectDate = [NSDate date];
    
    _endMinDate = _startMinDate;
    _endMaxDate = _startMaxDate;
    
    switch (self.datePickerMode) {
        case ZJBetweenDateAndTimePickerMode:
        {
             _endSelectDate = [ZJCalenderHandle dateOffset:1 calendarUnit:NSCalendarUnitMinute fromDate:_startSelectDate];
        }
            break;
        case ZJBetweenOnlyDatePickerMode:
        {
            _endSelectDate = [ZJCalenderHandle dateOffset:1 calendarUnit:NSCalendarUnitDay fromDate:_startSelectDate];
        }
            break;
        case ZJBetweenOnlyTimePickerMode:
        {
            _endSelectDate = [ZJCalenderHandle dateOffset:1 calendarUnit:NSCalendarUnitMinute fromDate:_startSelectDate];
        }
            break;
        default:
            break;
    }
   
    [self setupSelectDate:_endSelectDate WithStartState:NO];
    [self setupSelectDate:_startSelectDate WithStartState:YES];
    
    NSString *startSelectString = [self.dateFormatter stringFromDate:_startSelectDate];
    [_startButton setTitle:startSelectString forState:UIControlStateNormal];
    
    NSString *endSelectString = [self.dateFormatter stringFromDate:_endSelectDate];
    [_endButton setTitle:endSelectString forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title.length>0) {
        _titlelabel.text = _title;
    }
}

- (void)setStartMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectDate:(NSDate *)selectDate {
    _startMinDate = minDate;
    _startMaxDate = maxDate;
    _startSelectDate = selectDate;
    [self setupSelectDate:_startSelectDate WithStartState:YES];
}

- (void)setEndMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectDate:(NSDate *)selectDate {
    _endMinDate = minDate;
    _endMaxDate = maxDate;
    _endSelectDate = selectDate;
    [self setupSelectDate:_endSelectDate WithStartState:NO];
}

- (void)startButtonAction {
    _startButton.selected = YES;
    _endButton.selected = NO;
    [_quickButton setTitle:@"不限开始时间" forState:UIControlStateNormal];
    self.endSubBetweenDatePickerView.transform= CGAffineTransformIdentity;
    _startButton.titleLabel.font = [ZJFont zj_font30px:ZJFontTypeBold];
    _endButton.titleLabel.font = [ZJFont zj_font30px:ZJFontTypeRegular];
    [UIView animateWithDuration:0.25 animations:^{
        self.startSubBetweenDatePickerView.transform= CGAffineTransformIdentity;
    }];
}

- (void)endButtonAction {
    _startButton.selected = NO;
    _endButton.selected = YES;
    [_quickButton setTitle:@"不限结束时间" forState:UIControlStateNormal];
    self.startSubBetweenDatePickerView.transform = CGAffineTransformTranslate(self.startSubBetweenDatePickerView.transform, 0, 37*5+35.0);
    _endButton.titleLabel.font = [ZJFont zj_font30px:ZJFontTypeBold];
    _startButton.titleLabel.font = [ZJFont zj_font30px:ZJFontTypeRegular];
    [UIView animateWithDuration:0.25 animations:^{
        self.endSubBetweenDatePickerView.transform = CGAffineTransformTranslate(self.endSubBetweenDatePickerView.transform, 0, -(37*5+35.0));
    }];
}

- (void)setupSelectDate:(NSDate *)selectDate WithStartState:(BOOL)isStartState {
    if (isStartState) {
        [self startButtonAction];
        [self.startSubBetweenDatePickerView setDatePickerMinDate:_startMinDate maxDate:_startMaxDate selectDate:selectDate];
    } else {
        [self endButtonAction];
        [self.endSubBetweenDatePickerView setDatePickerMinDate:_endMinDate maxDate:_endMaxDate selectDate:selectDate];
    }
}

#pragma mark-
#pragma mark- Getters && Setters

- (ZJSubBetweenDatePickerView *)startSubBetweenDatePickerView {
    if (!_startSubBetweenDatePickerView) {
        _startSubBetweenDatePickerView = [[ZJSubBetweenDatePickerView alloc] initWithDatePickerMode:self.datePickerMode];
        _startSubBetweenDatePickerView.delegate = self;
    }
    return _startSubBetweenDatePickerView;
}

- (ZJSubBetweenDatePickerView *)endSubBetweenDatePickerView {
    if (!_endSubBetweenDatePickerView) {
        _endSubBetweenDatePickerView = [[ZJSubBetweenDatePickerView alloc] initWithDatePickerMode:self.datePickerMode];
        _endSubBetweenDatePickerView.delegate = self;
    }
    return _endSubBetweenDatePickerView;
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

- (UIView *)switchView {
    if (!_switchView) {
        _switchView = [[UIView alloc] init];
        _switchView.backgroundColor = [UIColor whiteColor];
    }
    return _switchView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [ZJColor zj_colorC9];
    }
    return _lineView;
}


- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton setTitleColor:[ZJColor zj_colorC5] forState:UIControlStateSelected];
        [_startButton setTitleColor:[ZJColor zj_colorC7] forState:UIControlStateNormal];
        _startButton.titleLabel.font = [ZJFont zj_font30px:ZJFontTypeRegular];
        _startButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_startButton setImage:[UIImage imageNamed:@"dateAndTimestart_selected"] forState:UIControlStateSelected];
        [_startButton setImage:[UIImage imageNamed:@"dateAndTimestart_unselected"] forState:UIControlStateNormal];
        _startButton.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);
        _startButton.titleEdgeInsets = UIEdgeInsetsMake(0, 38, 0, 0);
        _startButton.contentEdgeInsets = UIEdgeInsetsMake(12.5, 0, 0, 0);
        [_startButton addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_startButton setTitle:@"开始：点击此处选择" forState:UIControlStateNormal];
       
    }
    return _startButton;
}

- (UIButton *)endButton {
    if (!_endButton) {
        _endButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endButton setTitleColor:[ZJColor zj_colorC7] forState:UIControlStateNormal];
        [_endButton setTitleColor:[ZJColor zj_colorC5] forState:UIControlStateSelected];
        _endButton.titleLabel.font = [ZJFont zj_font30px:ZJFontTypeRegular];
        _endButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_endButton setImage:[UIImage imageNamed:@"dateAndTimeEnd_unselected"] forState:UIControlStateNormal];
        [_endButton setImage:[UIImage imageNamed:@"dateAndTimeEnd_selected"] forState:UIControlStateSelected];
        
        _endButton.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);
        _endButton.titleEdgeInsets = UIEdgeInsetsMake(0, 38, 0, 0);
        _endButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 12.5, 0);
        [_endButton addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_endButton setTitle:@"结束：点击此处选择" forState:UIControlStateNormal];
    }
    return _endButton;
}

- (UIButton *)quickButton {
    if (!_quickButton) {
        _quickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _quickButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        _quickButton.backgroundColor = [UIColor whiteColor];
        [_quickButton setTitleColor:[ZJColor zj_colorC5] forState:UIControlStateNormal];
        _quickButton.titleLabel.font = [ZJFont zj_font28px:ZJFontTypeRegular];
        _quickButton.layer.masksToBounds = YES;
        _quickButton.layer.cornerRadius = 15.0;
        [_quickButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_quickButton addTarget:self action:@selector(quickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_quickButton setTitle:@"不限开始时间" forState:UIControlStateNormal];
    }
    
    return _quickButton;
}

- (UIView *)unitView {
    if (!_unitView) {
        _unitView = [[UIView alloc] init];
    }
    return _unitView;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        switch (self.datePickerMode) {
            case ZJBetweenDateAndTimePickerMode:
            {
                [_dateFormatter setDateFormat:kDateFormatYYYYMMDDHHmm];
            }
                break;
            case ZJBetweenOnlyDatePickerMode:
            {
                [_dateFormatter setDateFormat:kDateFormatYYYYMMDD];
            }
                break;
            case ZJBetweenOnlyTimePickerMode:
            {
                [_dateFormatter setDateFormat:kDateFormatHHmm];
            }
                break;
            default:
                break;
        }
    }
    return _dateFormatter;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
    UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapAction:)];
    backgroundTap.delegate = self;
    [self addGestureRecognizer:backgroundTap];
    
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.alpha = 0.0;
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.startSubBetweenDatePickerView];
    [self.contentView addSubview:self.endSubBetweenDatePickerView];
    [self.contentView addSubview:self.titleView];
    
    [self.titleView addSubview:self.titlelabel];
    [self.titleView addSubview:self.sureButton];
    [self.titleView addSubview:self.quickButton];
    
    [self.contentView addSubview:self.switchView];
    [self.switchView addSubview:self.startButton];
    [self.switchView addSubview:self.endButton];
    [self.contentView addSubview:self.lineView];
    
    [self.contentView addSubview:self.unitView];
    
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(kZJSubBetweenDatePickerViewHeight);
    }];
    [self.startSubBetweenDatePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).mas_offset(-35.0);
        make.left.mas_equalTo(self.contentView).mas_offset(10.0);
        make.right.mas_equalTo(self.contentView).mas_offset(-10.0);
        make.height.mas_equalTo(37.0*5);
    }];
    [self.endSubBetweenDatePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_bottom);
        make.left.right.mas_equalTo(self.startSubBetweenDatePickerView);
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
    [_quickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureButton.mas_left).mas_offset(-10);
        make.height.mas_equalTo(self.sureButton);
        make.centerY.mas_equalTo(self.sureButton);
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleView).mas_offset(15);
        make.top.bottom.mas_equalTo(self.titleView);
        make.right.mas_equalTo(self.quickButton.mas_left).mas_offset(-10);
    }];
    
    [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.switchView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.switchView);
        make.height.mas_equalTo(50);
    }];
    
    [_endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.switchView);
        make.height.mas_equalTo(50);
    }];
    
    [self.unitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.startSubBetweenDatePickerView);
        make.top.mas_equalTo(self.switchView.mas_bottom);
        make.bottom.mas_equalTo(self.startSubBetweenDatePickerView.mas_top);
    }];
}

- (void)setupTitleLabels {
    
    for(UIView *view in self.unitView.subviews)
    {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *dateArray;
    switch (self.datePickerMode) {
        case ZJBetweenDateAndTimePickerMode:
        {
            dateArray = @[@"年",@"月",@"日",@"时",@"分"];
        }
            break;
        case ZJBetweenOnlyDatePickerMode:
        {
            dateArray = @[@"年",@"月",@"日"];
        }
            break;
        case ZJBetweenOnlyTimePickerMode:
        {
            dateArray = @[@"时",@"分"];
        }
            break;
        default:
            break;
    }
    
    for (int i=0; i<dateArray.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [ZJColor zj_colorC7];
        label.font = [ZJFont zj_font30px:ZJFontTypeRegular];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = dateArray[i];
        [self.unitView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.unitView.mas_left).mas_offset((kZJBetweenDatePickerViewMargin+_labelWidth)*i+kZJBetweenDatePickerViewMargin);
            make.bottom.mas_equalTo(self.startSubBetweenDatePickerView.mas_top);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(_labelWidth);
        }];
    }
}

@end
