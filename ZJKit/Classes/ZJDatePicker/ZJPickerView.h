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
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;

// selection. in this case, it means showing the appropriate row in the middle
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

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

// returns row height of component.
- (CGFloat)zj_rowHeightForComponentPickerView:(UIPickerView *)pickerView;

// returns content for each row
- (nullable NSString *)zj_pickerView:(ZJPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

// response of select action
- (void)zj_pickerView:(ZJPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;


@end
