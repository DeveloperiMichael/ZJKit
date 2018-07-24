//
//  ZJCalenderHandle.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import <Foundation/Foundation.h>

@interface ZJCalenderHandle : NSObject


/**
 时间偏移

 @param offset 偏移量
 @param unit 偏移单位 年|月|日|时|分|秒
 @param fromDate 要偏移的时间
 @return 偏移后的时间
 */
+ (NSDate *)dateOffset:(NSInteger)offset
          calendarUnit:(NSCalendarUnit)unit
              fromDate:(NSDate *)fromDate;

/**
 获取两个时间之间 某NSCalendarUnit 的数值

 @param unit 获取数据单位NSCalendarUnit
 @param fromDate 开始时间
 @param toDate 结束时间
 @return 数值集合
 */
+ (NSArray <NSString *>*)dateArrayOfUnit:(NSCalendarUnit)unit
                                fromDate:(NSDate *)fromDate
                                  toDate:(NSDate *)toDate;


+ (NSArray <NSString *>*)dataArrayOfUnit:(NSCalendarUnit)unit
                                  inUnit:(NSCalendarUnit)inUnit
                                 forDate:(NSDate *)date;

@end
