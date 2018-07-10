//
//  ZJControllerPopupProtocol.h
//  ZJKit
//
//  Created by 张炯 on 2018/6/1.
//

#import <Foundation/Foundation.h>


/**
 pop up 动画完成回调
 */
typedef void(^ZJPopupAnimationBlock)(void(^)(void));

@protocol ZJControllerPopupProtocol <NSObject>


/**
 弹出视图控制器

 @param fromController 弹出视图控制器的父控制器。当fromController有导航控制器时，将会被加到导航控制器上。
 @param animated 是否有弹出动画
 */
- (void)showFromController:(UIViewController *)fromController animated:(BOOL)animated;


/**
 隐藏弹出视图
 
 @param animated 是否有动画
 @param compeletion 隐藏成功的回调
 */
- (void)dismiss:(BOOL)animated compeletion:(ZJPopupAnimationBlock)compeletion;

@end
