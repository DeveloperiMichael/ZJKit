//
//  UIView+ZJKeyFrameAnimation.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/30.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJKeyFrameAnimation)


/**
 
 主要针对复杂轨迹移动的动画
 
 （1）values属性
 
 values属性指明整个动画过程中的关键帧点，需要注意的是，起点必须作为values的第一个值。
 
 （2）path属性
 
 作用与values属性一样，同样是用于指定整个动画所经过的路径的。需要注意的是，values与path是互斥的，当values与path同时指定时，path会覆盖values，即values属性将被忽略。
 */


- (void)startKeyFrameAnimation:(NSArray <NSValue *> *)values
                      keyTimes:(NSArray <NSNumber *> *)keyTimes
                      duration:(CFTimeInterval)duration;


/** 使用贝塞尔曲线做路径 */
- (void)startKeyFrameAnimation:(CGPathRef)path
                      duration:(CFTimeInterval)duration
                   repeatCount:(float)count;


@end
