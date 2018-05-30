//
//  UIView+ZJAnimation.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import "UIView+ZJTransitionAnimation.h"
#import <objc/runtime.h>

static NSString * const kCAAnimationKey = @"com.zjouer.www.CAAnimation.key";
static char const *kTransitionTypeArrayKey = "com.zjouer.www.transitionTypeArray.key";
static char const *kTransitionSubtypeArrayKey = "com.zjouer.www.transitionSubtypeArray.key";

@interface UIView ()<CAAnimationDelegate>

@property (nonatomic, strong) NSArray *transitionTypeArray;
@property (nonatomic, strong) NSArray *transitionSubtypeArray;

@end

@implementation UIView (ZJTransitionAnimation)

- (void)startTransitionAnimationType:(ZJTransitionAnimationType)type
                             subType:(ZJTransitionAnimationSubtype)subtype
                            duration:(CFTimeInterval)duration {
    
    self.transitionTypeArray = [NSArray arrayWithObjects:
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
    
    self.transitionSubtypeArray = [NSArray arrayWithObjects:
                                @"none",
                                @"fromLeft",
                                @"fromRight",
                                @"fromTop",
                                @"fromBottom",nil];
    
    CATransition *transition = [CATransition animation];
    transition.type = self.transitionTypeArray[(NSInteger)type];
    transition.delegate = self;
    transition.duration = duration;
    transition.subtype = self.transitionSubtypeArray[(NSInteger)subtype];
    [self.layer addAnimation:transition forKey:kCAAnimationKey];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}


#pragma mark - property

- (void)setTransitionTypeArray:(NSArray *)transitionTypeArray {
    objc_setAssociatedObject(self, kTransitionTypeArrayKey, transitionTypeArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)transitionTypeArray {
    return objc_getAssociatedObject(self, kTransitionTypeArrayKey);
}

- (void)setTransitionSubtypeArray:(NSArray *)transitionSubtypeArray {
    objc_setAssociatedObject(self, kTransitionSubtypeArrayKey, transitionSubtypeArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)transitionSubtypeArray {
    return objc_getAssociatedObject(self, kTransitionSubtypeArrayKey);
}



@end
