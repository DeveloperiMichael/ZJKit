//
//  UIView+ZJAnimation.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import "UIView+ZJTransitionAnimation.h"

static NSString * const kZJTransitionAnimationKey = @"com.zjouer.www.ZJTransitionAnimation";

@interface UIView ()<CAAnimationDelegate>


@end

@implementation UIView (ZJTransitionAnimation)

- (void)startTransitionAnimationType:(ZJTransitionAnimationType)type
                             subType:(ZJTransitionAnimationSubtype)subtype
                            duration:(CFTimeInterval)duration {
    
    NSArray *transitionTypeArray = [NSArray arrayWithObjects:
                                @"fade",
                                @"moveIn",
                                @"push",
                                @"reveal",
                                @"cube",
                                @"suckEffect",
                                @"rippleEffect",
                                @"pageCurl",
                                @"pageUnCurl",
                                @"oglFlip",
                                @"cameralrisHollowOpen",
                                @"cameralrisHollowClose",nil];
    
    NSArray *transitionSubtypeArray = [NSArray arrayWithObjects:
                                @"none",
                                @"fromLeft",
                                @"fromRight",
                                @"fromTop",
                                @"fromBottom",nil];
    
    CATransition *transition = [CATransition animation];
    transition.type = transitionTypeArray[(NSInteger)type];
    transition.delegate = self;
    transition.duration = duration;
    transition.subtype = transitionSubtypeArray[(NSInteger)subtype];
    NSString *key = [kZJTransitionAnimationKey stringByAppendingString:[NSString stringWithFormat:@".%@.key",transitionTypeArray[(NSInteger)type]]];
    [self.layer addAnimation:transition forKey:key];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}





@end
