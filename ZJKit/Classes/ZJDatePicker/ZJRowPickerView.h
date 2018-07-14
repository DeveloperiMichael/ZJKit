//
//  ZJRowPickerView.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/10.
//

#import <UIKit/UIKit.h>

@protocol ZJRowPickerViewDataSource,ZJRowPickerViewDelegate;

@interface ZJRowPickerView : UIView

@property(nonatomic, weak) id<ZJRowPickerViewDataSource> dataSource;
@property(nonatomic, weak) id<ZJRowPickerViewDelegate> delegate;

- (void)reloadData;

- (void)setSelectRowAtIndex:(NSInteger)index;

@end

#pragma mark -------------
#pragma mark --------------------------ZJRowPickerViewDataSource

@protocol ZJRowPickerViewDataSource <NSObject>
@required

- (NSInteger)zj_numberOfRowsInRowPickerView:(ZJRowPickerView *)rowPickerView;

//odd number required -> 2n+1, if even number  (+1)  >=3
 -(NSInteger)zj_numberOfDisplayRowsInRowPickerView:(ZJRowPickerView *)rowPickerView;

@end

#pragma mark -------------
#pragma mark --------------------------ZJRowPickerViewDelegate

@protocol ZJRowPickerViewDelegate <NSObject>
@optional

- (NSString *)zj_rowPickerView:(ZJRowPickerView *)rowPickerView contentForRowAtIndex:(NSInteger)index;

// height for row
- (CGFloat)zj_heightForRowInRowPickerView:(ZJRowPickerView *)rowPickerView;

// response for selected row
- (void)zj_rowPickerView:(UITableView *)rowPickerView didSelectRowAtIndex:(NSInteger)index;

@end

