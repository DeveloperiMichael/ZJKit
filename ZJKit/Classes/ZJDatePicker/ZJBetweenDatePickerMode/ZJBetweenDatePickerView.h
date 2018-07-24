//
//  ZJBetweenDatePickerView.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/24.
//

#import <UIKit/UIKit.h>
#import "ZJSubBetweenDatePickerView.h"

@protocol ZJBetweenDatePickerViewDelegate;

@interface ZJBetweenDatePickerView : UIView


// use init method
- (instancetype)initWithDatePickerMode:(ZJBetweenDatePickerMode)mode NS_DESIGNATED_INITIALIZER;

// forbid init methods
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

// show && hide
- (void)show:(BOOL)animated completion:(void(^)(void))completion;
- (void)hide:(BOOL)animated completion:(void(^)(void))completion;

@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *quickButtonTitle;
@property (nonatomic, assign) BOOL showQuickButton;
@property(nonatomic, weak) id<ZJBetweenDatePickerViewDelegate> delegate;

/**
 set start earliest date(default 20 years before current date)/latest date(default 20 years after current date)/select date
 */
- (void)setStartMinDate:(NSDate *)minDate
                maxDate:(NSDate *)maxDate
             selectDate:(NSDate *)selectDate;
/**
 set end earliest date(default 20 years before current date)/latest date(default 20 years after current date)/select date
 */
- (void)setEndMinDate:(NSDate *)minDate
              maxDate:(NSDate *)maxDate
           selectDate:(NSDate *)selectDate;

@end



@protocol ZJBetweenDatePickerViewDelegate <NSObject>

@optional
// have selected date
- (void)zj_betweenDatePickerView:(ZJBetweenDatePickerView *)betweenDatePickerView
              didSelectStartDate:(NSDate *)startDate
                   selectEndDate:(NSDate *)endDate;

@end


