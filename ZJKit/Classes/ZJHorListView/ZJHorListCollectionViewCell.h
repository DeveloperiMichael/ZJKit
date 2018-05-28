//
//  ZJHorListCollectionViewCell.h
//  CMOrders
//
//  Created by 张炯 on 2018/5/14.
//

#import <UIKit/UIKit.h>

/**
 底部滑动line样式
 
 - ZJHorListViewLineStyleNone: 没有线条
 - ZJHorListViewLineStyleEqualTitle: 和content等长
 - ZJHorListViewLineStyleEqualCell: 和cell等长
 - ZJHorListViewLineStyleFixedLength: 固定长度
 */
typedef NS_ENUM(NSInteger, ZJHorListViewLineStyle) {
    ZJHorListViewLineStyleNone=0,
    ZJHorListViewLineStyleEqualTitle,
    ZJHorListViewLineStyleEqualCell,
    ZJHorListViewLineStyleFixedLength
};

@interface ZJHorListCollectionViewCell : UICollectionViewCell

/** 标签内容 */
@property (nonatomic, copy) NSString *content;

/** 气泡内容 */
@property (nonatomic, assign) NSInteger bubbleValue;

/** 气泡可显示的最大值，超出该值，则显示 bubbleMaxValue+ */
@property (nonatomic, assign) NSInteger bubbleMaxValue;

/** 是否显示气泡，默认Yes */
@property (nonatomic, assign) BOOL shouldShowBubble;

/** 设置线条样式 */
@property (nonatomic, assign) ZJHorListViewLineStyle lineStyle;

@end
