//
//  ZJRowPickerView.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/10.
//

#import "ZJRowPickerView.h"
#import "ZJRowPickerTableViewCell.h"
#import <Masonry/Masonry.h>

static NSString *const kZJBottomTableViewCellIdentifier = @"com.zjkit.zjrowpickerview.bottomTableView.cellIdentifier";

static NSString *const kZJTopTableViewCellIdentifier = @"com.zjkit.zjrowpickerview.topTableView.cellIdentifier";

static NSInteger kZJBlankCellNumber = 2;

static CGFloat kZJRowPickerViewMargin = 15.0;

static CGFloat kZJRowPickerViewRowHeight = 37.0;

@interface ZJRowPickerView ()
<UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *bottomTableView;
@property (nonatomic, strong) UITableView *topTableView;

@property (nonatomic, assign) NSInteger displayRowNumber;
@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) NSInteger selectedIndex;

@end


@implementation ZJRowPickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self setupData];
    [self setupSubviewsContraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.frame.size.height<_rowHeight*_displayRowNumber) {
        NSLog(@"warning: please check <ZJRowPickerView> size");
    }
}

#pragma mark-
#pragma mark- <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _bottomTableView) {
        return _numberOfRows+2*kZJBlankCellNumber;
    } else if (tableView == _topTableView) {
        return _numberOfRows;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _topTableView) {
        
        ZJRowPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kZJTopTableViewCellIdentifier];
        cell.content=[_delegate zj_rowPickerView:self contentForRowAtIndex:indexPath.row];
        cell.zj_selected = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (tableView == _bottomTableView){
        
        ZJRowPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kZJBottomTableViewCellIdentifier];
        
        if (indexPath.row>kZJBlankCellNumber-1&&indexPath.row<_numberOfRows+kZJBlankCellNumber) {
            cell.content=[_delegate zj_rowPickerView:self contentForRowAtIndex:indexPath.row-kZJBlankCellNumber];
        }else{
            cell.content = @"";
        }
        cell.zj_selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight==0?kZJRowPickerViewRowHeight:_rowHeight;
}

#pragma mark-
#pragma mark- <UITableViewDataSource,UITableViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _bottomTableView) {
        _topTableView.contentOffset = scrollView.contentOffset;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _bottomTableView&&!decelerate) {
        _selectedIndex = [self getIndexForScrollViewPosition:scrollView];
        _selectedIndex = _selectedIndex<_numberOfRows?_selectedIndex:(_numberOfRows-1);
        _topTableView.contentOffset = scrollView.contentOffset;
        [self setSelectRowAtIndex:_selectedIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _bottomTableView) {
        _selectedIndex = [self getIndexForScrollViewPosition:scrollView];
        _selectedIndex = _selectedIndex<_numberOfRows?_selectedIndex:(_numberOfRows-1);
        _topTableView.contentOffset = scrollView.contentOffset;
        [self setSelectRowAtIndex:_selectedIndex];
    }
    
}

- (int)getIndexForScrollViewPosition:(UIScrollView *)scrollView {
    
    CGFloat offsetContentScrollView = (scrollView.frame.size.height - _rowHeight) / 2.0;
    CGFloat offetY = scrollView.contentOffset.y;
    CGFloat exactIndex = (offetY + offsetContentScrollView) / _rowHeight;
    int intIndex = floorf((offetY + offsetContentScrollView) / _rowHeight);
    int index;
    if (intIndex+0.5>exactIndex) {
        index = intIndex;
    }else{
        index = intIndex+1;
    }
    index = index-kZJBlankCellNumber;
    return index;
}

#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

- (void)setupData {
    self.selectedIndex = 0;
    _displayRowNumber = [_dataSource zj_numberOfDisplayRowsInRowPickerView:self];
    _numberOfRows = [_dataSource zj_numberOfRowsInRowPickerView:self];
    if ([_delegate respondsToSelector:@selector(zj_heightForRowInRowPickerView:)]) {
        _rowHeight = [_delegate zj_heightForRowInRowPickerView:self];
    }
    
    if (_displayRowNumber == 0) {
        _displayRowNumber = 3;
    }
    
    if (_displayRowNumber>0&&(_displayRowNumber-1)%2==1) {
        _displayRowNumber = (_displayRowNumber - 1)>3?(_displayRowNumber - 1):3;
    }

}


#pragma mark-
#pragma mark- Public Methods

- (void)reloadData {
    [self setupData];
    [self.bottomTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(_displayRowNumber*_rowHeight);
    }];
    [self.topTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bottomTableView);
        make.width.mas_equalTo(self.bottomTableView);
        make.height.mas_equalTo(_rowHeight);
    }];
    [_bottomTableView reloadData];
    [_topTableView reloadData];
    [self setSelectRowAtIndex:0];
}

- (void)setSelectRowAtIndex:(NSInteger)index {
    if (0<=index&&index<_numberOfRows) {
        self.selectedIndex = index;
    } else {
        self.selectedIndex = 0;
        NSLog(@"warning: please check setSelectRowAtIndex");
    }
    
    [_bottomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [_topTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if ([self.delegate respondsToSelector:@selector(zj_rowPickerView:didSelectRowAtIndex:)]) {
        [self.delegate zj_rowPickerView:self didSelectRowAtIndex:self.selectedIndex];
    }
}

#pragma mark-
#pragma mark- Getters && Setters

- (UITableView *)topTableView {
    if (!_topTableView) {
        _topTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            [_topTableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        } else {
            // Fallback on earlier versions
        }
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
        _topTableView.userInteractionEnabled = NO;
        _topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _topTableView.showsVerticalScrollIndicator = NO;
        _topTableView.bounces = NO;
        _topTableView.estimatedRowHeight = 0;
        [_topTableView registerClass:[ZJRowPickerTableViewCell class] forCellReuseIdentifier:kZJTopTableViewCellIdentifier];
        _topTableView.backgroundColor = [UIColor greenColor];
    }
    return _topTableView;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        if (@available(iOS 11.0, *)) {
            [_bottomTableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        } else {
            // Fallback on earlier versions
        }
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bottomTableView.showsVerticalScrollIndicator = NO;
        _bottomTableView.bounces = NO;
        _bottomTableView.estimatedRowHeight = 0;
        [_bottomTableView registerClass:[ZJRowPickerTableViewCell class] forCellReuseIdentifier:kZJBottomTableViewCellIdentifier];
        _bottomTableView.backgroundColor = [UIColor yellowColor];
    }
    return _bottomTableView;
    
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
    [self addSubview:self.bottomTableView];
    [self addSubview:self.topTableView];
    
    [self.bottomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(_displayRowNumber*_rowHeight);
    }];
    [self.topTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bottomTableView);
        make.width.mas_equalTo(self.bottomTableView);
        make.height.mas_equalTo(_rowHeight);
    }];
    
}


@end
