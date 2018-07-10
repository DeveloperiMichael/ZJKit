//
//  ZJRulerVIew.m
//  ZJKit
//
//  Created by 张炯 on 2018/6/7.
//

#import "ZJRulerView.h"
#import <Masonry/Masonry.h>
#import "ZJRulerCollectionViewCell.h"
#import "ZJKit.h"

@interface ZJRulerView ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    BOOL _shouldDdecelerate;
}

@property (nonatomic, strong) UICollectionView *collectionView;

/**
 collectionView  高度
 */
@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, strong) UIView *verLineView;

/**
 self 的高度
 */
@property (nonatomic, assign) CGFloat viewHeight;

/**
 每个刻度的宽度 默认为72.0
 */
@property (nonatomic, assign) CGFloat perWidth;

@property (nonatomic, strong) UILabel *label;

@end


@implementation ZJRulerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _rulerCount = 100;
        _rulerScale = 1.0;
        _perWidth = 72.0;
        _itemHeight = 50.0;
        _viewHeight = 100.0;
        _decimalType = ZJRulerDecimalTypeInteger;
        [self setupSubviewsContraints];
        self.currentIndex = 0;
        
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_viewHeight).priorityHigh();
        make.width.mas_equalTo(_perWidth).priorityHigh();
    }];
}

- (void)addConstraint:(NSLayoutConstraint *)constraint {
    if (constraint.firstAttribute == NSLayoutAttributeHeight) {
        constraint.constant = _viewHeight;
    }
    if (constraint.firstAttribute == NSLayoutAttributeWidth) {
        constraint.constant = _perWidth;
    }
    [super addConstraint:constraint];
}

#pragma mark-
#pragma mark- UICollectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _rulerCount+6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJRulerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZJRulerCollectionViewCell" forIndexPath:indexPath];
    
    
    
    if (indexPath.row>2&&indexPath.row<_rulerCount+3) {
        switch (_decimalType) {
            case ZJRulerDecimalTypeInteger:
            {
                cell.content = [NSString stringWithFormat:@"%d",(int)_rulerScale*(indexPath.row-3)];
            }
                break;
            case ZJRulerDecimalTypeOnePoint:
            {
                cell.content = [NSString stringWithFormat:@"%.1f",_rulerScale*(indexPath.row-3)];
            }
                break;
            case ZJRulerDecimalTypeTwoPoint:
            {
                cell.content = [NSString stringWithFormat:@"%.2f",_rulerScale*(indexPath.row-3)];
            }
                break;
            default:
                break;
        }
    } else{
        cell.content = @"";
    }
    
    
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _shouldDdecelerate = decelerate;
    if (!decelerate) {
        self.currentIndex = (scrollView.contentOffset.x/_perWidth);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_shouldDdecelerate) {
        self.currentIndex = (scrollView.contentOffset.x/_perWidth);
    }
    
}


#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

- (void)setScrollViewAtCurrentIndex {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex+3 inSection:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    });
   
    switch (_decimalType) {
        case ZJRulerDecimalTypeInteger:
        {
            _label.text = [NSString stringWithFormat:@"%d",(int)_rulerScale*_currentIndex];
        }
            break;
        case ZJRulerDecimalTypeOnePoint:
        {
            _label.text = [NSString stringWithFormat:@"%.1f",_rulerScale*_currentIndex];
        }
            break;
        case ZJRulerDecimalTypeTwoPoint:
        {
            _label.text = [NSString stringWithFormat:@"%.2f",_rulerScale*_currentIndex];
        }
            break;
        default:
            break;
    }
}


#pragma mark-
#pragma mark- Getters && Setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(_perWidth, _itemHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZJRulerCollectionViewCell class] forCellWithReuseIdentifier:@"ZJRulerCollectionViewCell"];
    }
    return _collectionView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [ZJFont zj_font48px:ZJFontTypeNumBold];
        _label.textColor = [ZJColor zj_colorC1];
    }
    return _label;
}


- (void)setRulerCount:(NSInteger)rulerCount {
    _rulerCount = rulerCount;
    [_collectionView reloadData];
}

- (void)setRulerScale:(CGFloat)rulerScale {
    _rulerScale = rulerScale;
    [_collectionView reloadData];
}

- (UIView *)verLineView {
    if (!_verLineView) {
        _verLineView = [[UIView alloc] init];
        _verLineView.backgroundColor = [ZJColor zj_colorC1];
    }
    return _verLineView;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    if (_currentIndex>_rulerCount-1) {
        _currentIndex = _rulerCount-1;
    }
    
    if (_currentIndex<=0) {
        _currentIndex = 0;
    }
    
    [self setScrollViewAtCurrentIndex];
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.collectionView];
    [self addSubview:self.verLineView];
    [self addSubview:self.label];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(self.itemHeight);
    }];
    [_verLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.mas_equalTo(self);
        make.height.mas_equalTo(self.viewHeight*0.75);
        make.width.mas_equalTo(2.0);
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(self);
    }];
}

@end
