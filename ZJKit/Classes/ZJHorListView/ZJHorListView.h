//
//  ZJHorListView.h
//  CMOrders
//
//  Created by 张炯 on 2018/5/14.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "ZJHorListCollectionViewCell.h"

@protocol ZJHorListViewDelegate;
@protocol ZJHorListViewDataSource;

@interface ZJHorListView : UIView 

@property(nonatomic, weak) id<ZJHorListViewDelegate> sa_delegate;
@property(nonatomic, weak) id<ZJHorListViewDataSource> sa_dataSource;


/** 是否显示气泡，默认Yes，如果设置为No 则dataSource代理方法设置无效 */
@property (nonatomic, assign) BOOL shouldShowBubble;

/** 标签内容最大字符数 默认无限制 */
@property (nonatomic, assign) NSInteger maxCharValue;

/** 设置线条样式 */
@property (nonatomic, assign) ZJHorListViewLineStyle lineStyle;

/**
 设置选中的cell
 */
- (void)setSelectIndex:(NSInteger)selectIndex;

/**
 刷新所有数据
 */
- (void)reloadData;

/**
 刷新某些cell

 @param indexs 刷新的index数组
 */
- (void)reloadItemsAtIndexs:(NSArray <NSNumber *> *)indexs;

@end



@protocol ZJHorListViewDelegate <NSObject>

@optional

/**
 点击事件
 
 @param horListView 视图对象
 @param index 当前点击index
 @param lastIndex 上一个点击的index
 */
- (void)horListView:(ZJHorListView *)horListView didSelectRowAtIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex;

@end

@protocol ZJHorListViewDataSource <NSObject>

@required

/**
 标签数量
 */
- (NSInteger)numberOfItemsInHorListView:(ZJHorListView *)horListView;

/**
 标签内容
 */
- (NSString *)horListView:(ZJHorListView *)horListView contentForRowAtIndex:(NSInteger)index;

@optional

/**
 标签上气泡最大值
 */
- (NSInteger)horListView:(ZJHorListView *)horListView bubbleMaxValueForRowAtIndex:(NSInteger)index;

/**
 标签上气泡数值
 */
- (NSInteger)horListView:(ZJHorListView *)horListView bubbleValueForRowAtIndex:(NSInteger)index;

@end
