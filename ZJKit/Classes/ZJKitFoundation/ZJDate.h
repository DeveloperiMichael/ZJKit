//
//  ZJDate.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/16.
//

#import <Foundation/Foundation.h>

@interface ZJDate : NSObject

/**
 判断开始时间、结束时间是否合法
 
 @param startDate 开始时间
 @param endDate 结束时间
 @return 是否合法
 */
+ (BOOL)zj_legalityForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
