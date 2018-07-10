//
//  UIView+ZJBasicAnimation.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/30.
//

#import "UIView+ZJBasicAnimation.h"

@interface UIView ()<CAAnimationDelegate>

@end

static NSString * const kZJBasicAnimationKey = @"com.zjouer.www.ZJBasicAnimation";

@implementation UIView (ZJBasicAnimation)

- (void)startBasicAnimationkeyPath:(NSString *)keyPath
                         fromValue:(id)fromValue
                           toValue:(id)toValue
                          duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = YES;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeBackwards;
    animation.repeatCount = 1;
    animation.duration = duration;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    NSString *key = [kZJBasicAnimationKey stringByAppendingString:[NSString stringWithFormat:@".%@.key",keyPath]];
    [self.layer addAnimation:animation forKey:key];
    
}


/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    NSLog(@"animationDidStart");
}

/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
}


@end
