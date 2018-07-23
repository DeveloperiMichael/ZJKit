//
//  ZJDatePickerView.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/10.
//

#import "ZJPickerView.h"
#import "ZJRowPickerView.h"
#import <Masonry/Masonry.h>

static CGFloat kZJPickerViewRowHeight = 39.0f;
static CGFloat kZJPickerViewComponentMargin = 5.0f;
static NSInteger kZJRowPickerViewBaseTag = 500;

@interface ZJPickerView ()<ZJRowPickerViewDelegate,ZJPickerViewDataSource>


@property (nonatomic, assign) NSInteger numberOfComponents;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign, readwrite) CGFloat widthOfComponent;

@end


@implementation ZJPickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark-
#pragma mark- delegate

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self setupData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _widthOfComponent = (self.frame.size.width-kZJPickerViewComponentMargin*(_numberOfComponents+1))/_numberOfComponents;
    [self setupSubviewsContraints];
}

#pragma mark-
#pragma mark- Private Methods

- (void)setupData {
    _rowHeight =kZJPickerViewRowHeight;
    _numberOfComponents = [_dataSource zj_numberOfComponentsInPickerView:self];
    if ([_delegate respondsToSelector:@selector(zj_rowHeightForComponentPickerView:)]) {
        _rowHeight = [_delegate zj_rowHeightForComponentPickerView:self]>0?[_delegate zj_rowHeightForComponentPickerView:self]:kZJPickerViewRowHeight;
    }
}


#pragma mark-
#pragma mark- <ZJRowPickerViewDelegate,ZJPickerViewDataSource>

- (CGFloat)zj_heightForRowInRowPickerView:(ZJRowPickerView *)rowPickerView {
    return _rowHeight;
}

- (NSInteger)zj_numberOfDisplayRowsInRowPickerView:(ZJRowPickerView *)rowPickerView {
    return 5;
}

- (NSInteger)zj_numberOfRowsInRowPickerView:(ZJRowPickerView *)rowPickerView {
    NSInteger component = rowPickerView.tag-kZJRowPickerViewBaseTag;
    return [_dataSource zj_pickerView:self numberOfRowsInComponent:component];
}

- (NSString *)zj_rowPickerView:(ZJRowPickerView *)rowPickerView contentForRowAtIndex:(NSInteger)index {
    NSInteger component = rowPickerView.tag-kZJRowPickerViewBaseTag;
    if ([_delegate respondsToSelector:@selector(zj_pickerView:titleForRow:forComponent:)]) {
        return [_delegate zj_pickerView:self titleForRow:index forComponent:component];
    }
    return nil;
}

- (void)zj_rowPickerView:(UITableView *)rowPickerView didSelectRowAtIndex:(NSInteger)index {
    NSInteger component = rowPickerView.tag-kZJRowPickerViewBaseTag;
    if ([_delegate respondsToSelector:@selector(zj_pickerView:didSelectRow:inComponent:)]) {
        [_delegate zj_pickerView:self didSelectRow:index inComponent:component];
    }
}


#pragma mark-
#pragma mark- Public Methods

- (void)reloadAllComponents {
    for (int i=0; i<_numberOfComponents; i++) {
        ZJRowPickerView *rowPickerView = [self viewWithTag:kZJRowPickerViewBaseTag+i];
        [rowPickerView reloadData];
    }
}

- (void)reloadComponent:(NSInteger)component {
    [self reloadComponent:component withSelectRowAtIndex:0];
}

- (void)reloadComponent:(NSInteger)component withSelectRowAtIndex:(NSInteger)index{
    ZJRowPickerView *rowPickerView = [self viewWithTag:kZJRowPickerViewBaseTag+component];
    [rowPickerView reloadDataWithSelectRowAtIndex:index];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ZJRowPickerView *rowPickerView = [self viewWithTag:kZJRowPickerViewBaseTag+component];
        [rowPickerView setSelectRowAtIndex:row];
    });
   
}

#pragma mark-
#pragma mark- Getters && Setters

- (CGFloat)widthOfComponent {
    return _widthOfComponent;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i=0; i<_numberOfComponents; i++) {
        ZJRowPickerView *rowPickerView = [[ZJRowPickerView alloc] init];
        rowPickerView.delegate = self;
        rowPickerView.dataSource = self;
        rowPickerView.tag = kZJRowPickerViewBaseTag+i;
        [self addSubview:rowPickerView];
        [rowPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(_widthOfComponent);
            make.left.mas_equalTo((_widthOfComponent+kZJPickerViewComponentMargin)*i+kZJPickerViewComponentMargin);
        }];
    }
    
}


@end
