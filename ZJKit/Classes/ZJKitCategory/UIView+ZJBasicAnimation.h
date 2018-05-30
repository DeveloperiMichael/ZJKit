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
 
 rotation.x
 rotation.y
 rotation.z
 rotation 旋转
 
 
 scale.x
 scale.y
 scale.z
 scale 缩放
 
 translation.x
 translation.y
 translation.z
 translation 平移
 
 
 CGPoint Key Paths : (example)position.x
 x
 y
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

- (void)startBasicAnimationkeyPath:(NSString *)keyPath
                         fromValue:(id)fromValue
                           toValue:(id)toValue
                          duration:(CFTimeInterval)duration;


@end
