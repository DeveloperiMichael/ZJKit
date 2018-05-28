//
//  ZJHorListView.m
//  CMOrders
//
//  Created by 张炯 on 2018/5/14.
//

#import "ZJHorListView.h"

static NSString * const kZJHorListCollectionViewCellIdentifier = @"wwwarehouse.SAStrongAnimal.collectionViewCell.identifier";

@interface ZJHorListView ()<UICollectionViewDelegate, UICollectionViewDataSource>

{
    NSInteger _lastIndex;
    NSInteger _selectIndex;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ZJHorListCollectionViewCell *lastSelectedCell;

@end

@implementation ZJHorListView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxCharValue = MAXFLOAT;
        _selectIndex = 0;
        _shouldShowBubble = YES;
        [self setupSubviewsContraints];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(49.0).priorityHigh();
    }];
}

- (void)addConstraint:(NSLayoutConstraint *)constraint {
    if (constraint.firstAttribute == NSLayoutAttributeHeight) {
        constraint.constant = 49.0;
    }
    [super addConstraint:constraint];
}


#pragma mark-
#pragma mark- UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sa_dataSource numberOfItemsInHorListView:self];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJHorListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kZJHorListCollectionViewCellIdentifier forIndexPath:indexPath];
    
    //cell.contentView.backgroundColor = [UIColor yellowColor];
    NSString *string = [self.sa_dataSource horListView:self contentForRowAtIndex:indexPath.row];
    if (string.length>_maxCharValue) {
        string = [string substringToIndex:_maxCharValue];
    }
    cell.lineStyle = ZJHorListViewLineStyleEqualTitle;
    cell.content = string;
    cell.selected = (_selectIndex == indexPath.row?YES:NO);
    cell.shouldShowBubble = _shouldShowBubble;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    if ([self.sa_dataSource respondsToSelector:@selector(horListView:bubbleMaxValueForRowAtIndex:)]) {
        cell.bubbleMaxValue = [self.sa_dataSource horListView:self bubbleMaxValueForRowAtIndex:indexPath.row];;
    }
    
    if ([self.sa_dataSource respondsToSelector:@selector(horListView:bubbleValueForRowAtIndex:)]) {
        cell.bubbleValue = [self.sa_dataSource horListView:self bubbleValueForRowAtIndex:indexPath.row];;
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_lastIndex == indexPath.row) return;
    
    _selectIndex = indexPath.row;
    
    if ([_sa_delegate respondsToSelector:@selector(horListView:didSelectRowAtIndex:lastIndex:)]) {
        [_sa_delegate horListView:self didSelectRowAtIndex:indexPath.row lastIndex:_lastIndex];
    }
    
    _lastIndex = indexPath.row;
    
    [_collectionView reloadData];
 
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark-
#pragma mark- Private Methods

- (void)reloadData {
    [_collectionView reloadData];
}

- (void)reloadItemsAtIndexs:(NSArray<NSNumber *> *)indexs {
    NSMutableArray <NSIndexPath *>*indexPaths = [NSMutableArray array];
    [indexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[obj integerValue] inSection:0];
        [indexPaths addObject:indexPath];
    }];
    if (indexPaths.count>0) {
        [_collectionView reloadItemsAtIndexPaths:indexPaths];
    }
}

#pragma mark-
#pragma mark- Getters && Setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *latout = [[UICollectionViewFlowLayout alloc] init];
        latout.minimumLineSpacing = 10;
        latout.estimatedItemSize = CGSizeMake(100, 47);
        latout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:latout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[ZJHorListCollectionViewCell class] forCellWithReuseIdentifier:kZJHorListCollectionViewCellIdentifier];
    }
    return _collectionView;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    [self reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)setShouldShowBubble:(BOOL)shouldShowBubble {
    _shouldShowBubble = shouldShowBubble;
    [_collectionView reloadData];
}

- (void)setMaxCharValue:(NSInteger)maxCharValue {
    _maxCharValue = maxCharValue;
    [_collectionView reloadData];
}

- (void)setLineStyle:(ZJHorListViewLineStyle)lineStyle {
    _lineStyle = lineStyle;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


@end
