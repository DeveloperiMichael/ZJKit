//
//  UIView+ZJAnimation.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import <UIKit/UIKit.h>

typedef void(^ZJAnimationCompletionBlock)();

/** 动画类型 */
typedef NS_ENUM(NSInteger, ZJTransitionAnimationType) {
    ZJTransitionAnimationFade = 0,
    ZJTransitionAnimationMoveIn,
    ZJTransitionAnimationPush,
    ZJTransitionAnimationReveal,
    ZJTransitionAnimationCube,
    ZJTransitionAnimationSuckEffect,
    ZJTransitionAnimationRippleEffect,
    ZJTransitionAnimationPageCurl,
    ZJTransitionAnimationPageUnCurl,
    ZJTransitionAnimationOglFlip,
    ZJTransitionAnimationCameralrisHollowOpen,
    ZJTransitionAnimationCameralrisHollowClose,
};

/** 动画方向 */
typedef NS_ENUM(NSInteger, ZJTransitionAnimationSubtype) {
    ZJTransitionAnimationNone = 0,
    ZJTransitionAnimationFromLeft,
    ZJTransitionAnimationFromRight,
    ZJTransitionAnimationFromTop,
    ZJTransitionAnimationFromBottom,
};


@interface UIView (ZJTransitionAnimation)

/**
 CATransition
 
 @param type 'fade' 'moveIn' 'push' 'reveal' 'cube' 'suckEffect' 'rippleEffect' 'pageCurl' 'pageUnCurl' 'oglFlip' 'cameralrisHollowOpen' 'cameralrisHollowClose'
 
 @param subType 'fromRight' 'fromLeft' 'fromTop' 'fromBottom'
 
 @param duration 动画持续时间
 */
- (void)startTransitionAnimationType:(ZJTransitionAnimationType)type
                             subType:(ZJTransitionAnimationSubtype)subtype
                            duration:(CFTimeInterval)duration;


@end
