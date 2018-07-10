//
//  ZJPickerView.h
//  ZJKit
//
//  Created by 张炯 on 2018/7/10.
//

#import <UIKit/UIKit.h>



@protocol ZJPickerViewDataSource, ZJPickerViewDelegate;

@interface ZJPickerView : UIView

@property(nullable,nonatomic,weak) id<ZJPickerViewDataSource> dataSource;
@property(nullable,nonatomic,weak) id<ZJPickerViewDelegate>   delegate;


// Reloading whole view or single component
- (void)zj_reloadAllComponents;
- (void)zj_reloadComponent:(NSInteger)component;

// selection. in this case, it means showing the appropriate row in the middle
- (void)zj_selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;  // scrolls the specified row to center.

@end




@protocol ZJPickerViewDataSource <NSObject>

@required

// returns the number of 'columns' to display.
- (NSInteger)zj_numberOfComponentsInPickerView:(ZJPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)zj_pickerView:(ZJPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end


@protocol ZJPickerViewDelegate <NSObject>
@optional

// returns width of column and height of row for each component.
- (CGFloat)zj_pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
- (CGFloat)zj_pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

// returns content for each row
- (nullable NSString *)zj_pickerView:(ZJPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

// response of select action
- (void)zj_pickerView:(ZJPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;




@end
