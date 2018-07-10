//
//  UIView+ZJKeyFrameAnimation.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/30.
//

#import "UIView+ZJKeyFrameAnimation.h"
static NSString * const kZJKeyFrameAnimationKey = @"com.zjouer.www.ZJKeyFrameAnimation.position.key";

@implementation UIView (ZJKeyFrameAnimation)


- (void)startKeyFrameAnimation:(NSArray <NSValue *> *)values
                      keyTimes:(NSArray <NSNumber *> *)keyTimes
                      duration:(CFTimeInterval)duration {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    //CAKeyframeAnimation 可以有两个属性来执行动画 keyPath 和 values 它可以在多个值之间变化，而CABasicAnimation 只能在两个值之间执行动画
    
    anim.keyPath = @"position";
    anim.values = values;
    anim.keyTimes = keyTimes; //每一帧用的时间
    anim.duration = duration;//动画执行时间
    anim.repeatCount = MAXFLOAT;
    anim.removedOnCompletion = YES; //执行动画后不要移除
    anim.fillMode = kCAFillModeForwards; //保持最新
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:anim forKey:kZJKeyFrameAnimationKey];
    
}



- (void)startKeyFrameAnimation:(CGPathRef)path
                      duration:(CFTimeInterval)duration
                   repeatCount:(float)count {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";//改变位置
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;
    anim.duration = duration;
    anim.path = path;
    // 设置动画的执行节奏
    // kCAMediaTimingFunctionEaseInEaseOut : 一开始比较慢, 中间会加速,  临近结束的时候, 会变慢
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.repeatCount = count;
    [self.layer addAnimation:anim forKey:kZJKeyFrameAnimationKey];
}



@end
