//
//  ZJMaskView.h
//  ZJKit
//
//  Created by 张炯 on 2018/4/3.
//

#import <UIKit/UIKit.h>


typedef void(^ZJMaskViewDismissBlock)();

@interface ZJMaskView : UIView


/**
 初始化方法

 @param showInView 将要加载在该视图上面
 @param customView 自定义的alert View
 @param edgeInsets customView 相对于 showInView 的edgeInsets
 @return 实例对象
 */
- (instancetype)initWithShowInView:(UIView *)showInView
                        customView:(UIView *)customView
                        edgeInsets:(UIEdgeInsets)edgeInsets NS_DESIGNATED_INITIALIZER;


- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 展示视图

 @param animated 是否动画  仅仅alpha
 @param completion 视图展示完成回调
 */
- (void)showAnimated:(BOOL)animated completion:(ZJMaskViewDismissBlock)completion;

/**
 隐藏视图

 @param animated 是否动画  仅仅alpha
 @param completion 视图隐藏完成回调,如果实现dissmiss，该回调失效
 */
- (void)hideAnimated:(BOOL)animated completion:(ZJMaskViewDismissBlock)completion;



/**
 动态修改customView 相对于 showInView 的edgeInsets
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/**
 点击阴影区域，dismiss后回调
 */
@property (nonatomic, copy) ZJMaskViewDismissBlock dismiss;

@end
