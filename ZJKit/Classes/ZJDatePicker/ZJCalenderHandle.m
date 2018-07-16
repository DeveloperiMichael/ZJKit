//
//  ZJCalenderHandle.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/12.
//

#import "ZJCalenderHandle.h"

@implementation ZJCalenderHandle

+ (NSDate *)dateOffset:(NSInteger)offset calendarUnit:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate {
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *fromComponents = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:fromDate];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    offsetComponents.year = fromComponents.year;
    offsetComponents.month = fromComponents.month;
    offsetComponents.day = fromComponents.day;
    offsetComponents.hour = fromComponents.hour;
    offsetComponents.minute = fromComponents.minute;
    
    switch (unit) {
        case NSCalendarUnitYear:
            offsetComponents.year = fromComponents.year + offset;
            break;
        case NSCalendarUnitMonth:
            offsetComponents.month = fromComponents.month + offset;
            break;
        case NSCalendarUnitDay:
            offsetComponents.day = fromComponents.day + offset;
            break;
        case NSCalendarUnitHour:
            offsetComponents.hour = fromComponents.hour + offset;
            break;
        case NSCalendarUnitMinute:
            offsetComponents.minute = fromComponents.minute + offset;
            break;
        case NSCalendarUnitSecond:
            offsetComponents.second = fromComponents.second + offset;
            break;
        default:
            break;
    }
    
    NSDate *offsetDate = [calender dateFromComponents:offsetComponents];
    
    return offsetDate;


}

@end
