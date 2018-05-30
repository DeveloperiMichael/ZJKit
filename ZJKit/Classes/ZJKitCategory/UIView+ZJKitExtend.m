//
//  UIView+ZJKitExtend.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import "UIView+ZJKitExtend.h"
#import <objc/runtime.h>


static char const *kZJViewDashBorderLayer = "com.zjouer.www.viewDashBorderLayer.key";

@interface UIView ()

@property (nonatomic, strong) CAShapeLayer *dashBorderLayer;

@end

@implementation UIView (ZJKitExtend)

- (UIImage *)screenshot {
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (void)setBorderWithRadius:(CGFloat)radius
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

- (void)setDashBorderWithSize:(CGSize)size
                       radius:(CGFloat)radius
                  borderColor:(UIColor *)color
                  borderWidth:(CGFloat)borderWidth {
    if (!self.dashBorderLayer) {
        self.dashBorderLayer = [CAShapeLayer layer];
        self.dashBorderLayer.lineWidth = borderWidth;
        self.dashBorderLayer.lineDashPattern = @[@4,@4];
        self.dashBorderLayer.fillColor = [UIColor clearColor].CGColor;
        self.dashBorderLayer.strokeColor = color.CGColor;
        //        self.dashBorderLayer.masksToBounds = YES;
        [self.layer addSublayer:self.dashBorderLayer];
    }
    self.dashBorderLayer.frame = CGRectMake(0, 0, size.width, size.height);
    self.dashBorderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.dashBorderLayer.bounds cornerRadius:radius].CGPath;
}

- (void)setDashBorderLayer:(CAShapeLayer *)dashBorderLayer {
    objc_setAssociatedObject(self, kZJViewDashBorderLayer, dashBorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)dashBorderLayer {
    return objc_getAssociatedObject(self, kZJViewDashBorderLayer);
}

- (void)addRoundingCorenrs:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
