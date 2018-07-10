//
//  ZJRulerView.h
//  ZJKit
//
//  Created by 张炯 on 2018/6/7.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZJRulerDecimalType) {
    ZJRulerDecimalTypeInteger = 0,
    ZJRulerDecimalTypeOnePoint,
    ZJRulerDecimalTypeTwoPoint,
};

@interface ZJRulerView : UIView


/**
 刻度 默认为1.0
 */
@property (nonatomic, assign) CGFloat rulerScale;

/**
 有多少个刻度 默认100个
 */
@property (nonatomic, assign) NSInteger rulerCount;

/**
 设置当前选中index
 */
@property (nonatomic, assign) NSInteger currentIndex;

/**
 保留小数位数 默认整数
 */
@property (nonatomic, assign) ZJRulerDecimalType decimalType;

@end
