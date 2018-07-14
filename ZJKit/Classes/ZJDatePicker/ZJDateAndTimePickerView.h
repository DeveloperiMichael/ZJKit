//
//  ZJDateAndTimePickerView.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import <UIKit/UIKit.h>


/**
 
 warning： all dates use GMT.
 
 */

@protocol ZJDateAndTimePickerViewDelegate;


@interface ZJDateAndTimePickerView : UIView


@property(nonatomic, weak) id<ZJDateAndTimePickerViewDelegate> delegate;

@property (nonatomic, copy) NSString *title;

// could select earliest(default 20 years before current date)/latest(default 20 years after current date) date
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
// have selected date.  set/get
@property (nonatomic, strong) NSDate *selectDate;

// init methods.  picker title.  earliest/latest/select date.
- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithMinimumDate:(NSDate *)minDate
                        maximumDate:(NSDate *)maxDate
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

