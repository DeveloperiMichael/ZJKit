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
    NSDate *offsetDate = [calender dateByAddingUnit:unit value:offset toDate:fromDate options:NSCalendarWrapComponents];
    return offsetDate;
}

+ (NSArray <NSString *>*)dateArrayOfUnit:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    NSMutableArray *dateArray = [NSMutableArray array];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *fromDateCompoents = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:fromDate];
    NSDateComponents *toDateCompoents = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:toDate];
    
    switch (unit) {
        case NSCalendarUnitYear:
        {
            for (NSInteger i=fromDateCompoents.year; i<=toDateCompoents.year; i++) {
                [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
            }
        }
            break;
        case NSCalendarUnitMonth:
        {
            if (fromDateCompoents.year==toDateCompoents.year) {
                for (NSInteger i=fromDateCompoents.month; i<=toDateCompoents.month; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            } else {
                for (NSInteger i=1; i<=12; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            }
            
        }
            break;
        case NSCalendarUnitDay:
        {
            if (fromDateCompoents.year==toDateCompoents.year&&fromDateCompoents.month==toDateCompoents.month) {
                for (NSInteger i=fromDateCompoents.date; i<=toDateCompoents.date; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            } else {
                NSRange range = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:fromDate];
                for (NSInteger i=1; i<=range.length; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            }
            
        }
            break;
        case NSCalendarUnitHour:
        {
            if (fromDateCompoents.year==toDateCompoents.year&&fromDateCompoents.month==toDateCompoents.month&&fromDateCompoents.day==toDateCompoents.day) {
                for (NSInteger i=fromDateCompoents.hour; i<=toDateCompoents.hour; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            } else {
                for (NSInteger i=0; i<=23; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            }
            
        }
            break;
        case NSCalendarUnitMinute:
        {
            if (fromDateCompoents.year==toDateCompoents.year&&fromDateCompoents.month==toDateCompoents.month&&fromDateCompoents.day==toDateCompoents.day&&fromDateCompoents.hour==toDateCompoents.hour) {
                for (NSInteger i=fromDateCompoents.minute; i<=toDateCompoents.minute; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            } else {
                for (NSInteger i=0; i<=59; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            }
        }
            break;
        case NSCalendarUnitSecond:
        {
            if (fromDateCompoents.year==toDateCompoents.year&&fromDateCompoents.month==toDateCompoents.month&&fromDateCompoents.day==toDateCompoents.day&&fromDateCompoents.hour==toDateCompoents.hour&&fromDateCompoents.minute==toDateCompoents.minute) {
                for (NSInteger i=fromDateCompoents.second; i<=toDateCompoents.second; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            } else {
                for (NSInteger i=0; i<=59; i++) {
                    if (i<10) {
                        [dateArray addObject:[NSString stringWithFormat:@"0%ld",i]];
                    } else {
                        [dateArray addObject:[NSString stringWithFormat:@"%ld",i]];
                    }
                }
            }
        }
            break;
        default:
            break;
    }
    
    return dateArray;
}

+ (NSArray <NSString *>*)daysInMonth:(NSDate *)date {
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSMutableArray *units = [NSMutableArray array];
    NSRange range = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    for (NSInteger i=1; i<=range.length; i++) {
        if (i<10) {
            [units addObject:[NSString stringWithFormat:@"0%ld",i]];
        } else {
            [units addObject:[NSString stringWithFormat:@"%ld",i]];
        }
    }
}

+ (NSArray<NSString *> *)dataArrayOfUnit:(NSCalendarUnit)unit inUnit:(NSCalendarUnit)inUnit forDate:(NSDate *)date {
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSMutableArray *dataArray = [NSMutableArray array];
    NSRange range = [calender rangeOfUnit:unit inUnit:inUnit forDate:date];
    for (NSInteger i=1; i<=range.length; i++) {
        if (i<10) {
            [dataArray addObject:[NSString stringWithFormat:@"0%ld",i]];
        } else {
            [dataArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
    }
    return dataArray;
}

@end
