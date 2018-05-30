//
//  UIView+ZJKitExtend.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJKitExtend)



/**
 截屏

 @return UIView 对应的image
 */
-(UIImage *)screenshot;


/**
 设置UIView边框

 @param radius 圆角大小
 @param borderWidth 边框宽度
 @param color 边框颜色
 */
- (void)setBorderWithRadius:(CGFloat)radius
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)color;




/**
 设置UIView虚线边框

 @param size 虚线闭环区域size
 @param radius 虚线圆角大小
 @param color 虚线颜色
 @param borderWidth 虚线宽度
 */
- (void)setDashBorderWithSize:(CGSize)size
                       radius:(CGFloat)radius
                  borderColor:(UIColor *)color
                  borderWidth:(CGFloat)borderWidth;


- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

@end
