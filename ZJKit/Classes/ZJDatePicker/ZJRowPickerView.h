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

@end



@protocol ZJRowPickerViewDataSource <NSObject>
@required


- (NSInteger)zj_rowPickerView:(ZJRowPickerView *)rowPickerView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)zj_rowPickerView:(ZJRowPickerView *)rowPickerView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end




@protocol ZJRowPickerViewDelegate <NSObject>
@optional

// height for row/header/footer
- (CGFloat)zj_rowPickerView:(ZJRowPickerView *)rowPickerView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)zj_rowPickerView:(ZJRowPickerView *)rowPickerView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)zj_rowPickerView:(ZJRowPickerView *)rowPickerView heightForFooterInSection:(NSInteger)section;

// customView for header/footer
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height


// response for selected row
- (void)zj_rowPickerView:(UITableView *)rowPickerView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

