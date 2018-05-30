//
//  UIView+Frame.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)


/**
 *  方便设置和获取对应的x、或y坐标
 */
@property (nonatomic , assign)CGFloat top;
@property (nonatomic , assign)CGFloat bottom;
@property (nonatomic , assign)CGFloat left;
@property (nonatomic , assign)CGFloat right;

/**
 *  方便设置和获取x、y和origin
 */
@property (nonatomic , assign)CGFloat x;
@property (nonatomic , assign)CGFloat y;
@property (nonatomic , assign)CGPoint origin;

/**
 *  centerX、centerY分别对应中点的x和y坐标
 */
@property (nonatomic , assign)CGFloat centerX;
@property (nonatomic , assign)CGFloat centerY;


/**
 *  方便设置和获取宽、高和大小
 */
@property (nonatomic , assign)CGFloat width;
@property (nonatomic , assign)CGFloat height;
@property (nonatomic , assign)CGSize size;

@end
