//
//  UIView+ZJBasicAnimation.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/30.
//

#import <UIKit/UIKit.h>

/*******
 
 注意：
 
 该分类用处不大，主要用来记录CABasicAnimation使用方法
 
 *******/


@interface UIView (ZJBasicAnimation)


/* CATransform3D Key Paths : (example)transform.rotation.z
 
 旋转
 rotation.x
 rotation.y
 rotation.z

 
 缩放
 scale.x
 scale.y
 scale
 
 平移
 translation.x
 translation.y
 translation
 
 
 CGPoint Key Paths : (example)position.x
 position.x
 position.y
 position 位置

 CGRect Key Paths : (example)bounds.size.width
 origin.x
 origin.y
 origin
 size.width
 size.height
 size
 
 
 opacity
 backgroundColor
 cornerRadius
 borderWidth
 contents
 
 Shadow Key Path:
 shadowColor
 shadowOffset
 shadowOpacity
 shadowRadius
 
 */


/**
 CABasicAnimation

 @param keyPath 可以指定keyPath为CALayer的属性值，并对它的值进行修改，以达到对应的动画效果，需要注意的是部分属性值是不支持动画效果的,查看CALayer属性。
 @param fromValue 开始值
 @param toValue 结束值
 @param duration 动画持续时间
 */
- (void)startBasicAnimationkeyPath:(NSString *)keyPath
                         fromValue:(id)fromValue
                           toValue:(id)toValue
                          duration:(CFTimeInterval)duration;


@end
