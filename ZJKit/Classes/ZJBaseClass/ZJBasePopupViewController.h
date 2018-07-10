//
//  ZJBasePopupViewController.h
//  ZJKit
//
//  Created by 张炯 on 2018/6/1.
//

#import <UIKit/UIKit.h>
#import "ZJControllerPopupProtocol.h"


/**
 布局锚点（0，0）位置
 */
typedef NS_ENUM(NSInteger, ZJPopupViewLayoutType) {
    ZJPopupViewLayoutTypeRightTop = 0,
    ZJPopupViewLayoutTypeRightBottom,
    ZJPopupViewLayoutTypeLeftTop,
    ZJPopupViewLayoutTypeLeftBottom,
    ZJPopupViewLayoutTypeCenter
};


/**
 动画转场类型
 */
typedef NS_ENUM(NSInteger, ZJPopupAnimationTransition) {
    ZJPopupAnimationTransitionFromRight = 0,
    ZJPopupAnimationTransitionFromLeft,
    ZJPopupAnimationTransitionFromTop,
    ZJPopupAnimationTransitionFromBottom,
    ZJPopupAnimationTransitionCover
};

/**
 弹出视图控制器的基类
 */
@interface ZJBasePopupViewController : UIViewController<ZJControllerPopupProtocol>


/**
 contentView 相对于弹出视图的EdgeInsets
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;

/**
 弹出视图的弹出动画，默认 ZJPopupAnimationTransitionFromBottom。
 注：子类最好在初始化方法中设定
 */
@property (nonatomic, assign) ZJPopupAnimationTransition transition;

/**
 弹出视图 contentView 布局锚点（0，0）位置，默认 SAPopupLayoutTypeLeft Bottom。
 注：子类最好在初始化方法中设定
 */
@property (nonatomic, assign) ZJPopupViewLayoutType layoutType;

@end
