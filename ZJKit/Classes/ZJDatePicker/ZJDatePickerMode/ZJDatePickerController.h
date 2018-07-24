//
//  ZJDatePickerController.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZJDatePickerMode) {
    ZJDatePickerModeTime,           // Displays hour, minute 时|分
    ZJDatePickerModeDate,           // Displays month, day, and year 年|月|日
    ZJDatePickerModeDateAndTime,    // Displays date, hour, minute, 年|月|日|时|分
};

@interface ZJDatePickerController : UIViewController

- (instancetype)initWithPickerMode:(ZJDatePickerMode)mode;


@end
