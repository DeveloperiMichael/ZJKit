//
//  ZJDateAndTimePickerView.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import <UIKit/UIKit.h>


/**
 *
 *
 *  warning： all dates base on GMT.
 *
 */

@protocol ZJDateAndTimePickerViewDelegate;


@interface ZJDateAndTimePickerView : UIView


@property(nonatomic, weak) id<ZJDateAndTimePickerViewDelegate> delegate;

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


@protocol ZJDateAndTimePickerViewDelegate <NSObject>

@optional

// have selected date
- (void)zj_dateAndTimePickerView:(ZJDateAndTimePickerView *)dateAndTimePickerView didSelectDate:(NSDate *)selectDate;

@end

