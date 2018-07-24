//
//  ZJDatePickerView.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import <UIKit/UIKit.h>

/**
 *
 *  warning： all dates base on GMT.
 *  输入、输出都是GMT（近似等于UTC）标准，选择时候显示的是系统时区标准
 *  比如我们是东八区，输入2018-7-26 11：30：00这是GMT标准，选择时候显示的是系统时区标准，就会是2018-7-26 19：30：00
 *  但是输出还是2018-7-26 11：30：00 也是GMT标准，所以将输出时间转换成字符串就获取到你选择的时候显示的时间，因为这个过程系统默认将GMT标准时间转换为当地时区时间
 *
 */

@protocol ZJDatePickerViewDelegate;


@interface ZJDatePickerView : UIView


@property(nonatomic, weak) id<ZJDatePickerViewDelegate> delegate;

@property (nonatomic, copy) NSString *title;

// init methods.  picker title.  earliest/latest/select date.
- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithMinimumDate:(NSDate *)minDate
                        maximumDate:(NSDate *)maxDate
                         selectDate:(NSDate *)selectDate NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;


/**
 can select earliest date(default 20 years before current date)/latest date(default 20 years after current date)
 
 @param minDate earliest date
 @param maxDate latest date
 @param selectDate default date
 */
- (void)setDatePickerMinDate:(NSDate *)minDate
                     maxDate:(NSDate *)maxDate
                  selectDate:(NSDate *)selectDate;

// show && hide
- (void)show:(BOOL)animated completion:(void(^)(void))completion;
- (void)hide:(BOOL)animated completion:(void(^)(void))completion;

@end


@protocol ZJDatePickerViewDelegate <NSObject>

@optional

// have selected date
- (void)zj_datePickerView:(ZJDatePickerView *)datePickerView didSelectDate:(NSDate *)selectDate;


@end
