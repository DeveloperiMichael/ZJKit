//
//  ZJHorListCollectionViewCell.m
//  CMOrders
//
//  Created by 张炯 on 2018/5/14.
//

#import "ZJHorListCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "ZJBubbleView.h"

@interface ZJHorListCollectionViewCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) ZJBubbleView *bubbleView;
@property (nonatomic, strong) UIView *lineView;


@end

@implementation ZJHorListCollectionViewCell

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _shouldShowBubble = YES;
        self.lineStyle = ZJHorListViewLineStyleNone;
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- delegate

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect cellFrame = layoutAttributes.frame;
    
    CGRect rect = [_content boundingRectWithSize:CGSizeMake(MAXFLOAT, cellFrame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil];
    
    cellFrame.size.width= rect.size.width+50;
    layoutAttributes.frame= cellFrame;
    
    return layoutAttributes;
    
}

#pragma mark-
#pragma mark- Private Methods

- (CGRect)getRectByString:(NSString *)string {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 15.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil];
    return rect;
}

#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithRed:69/255.0 green:73/255.0 blue:78/255.0 alpha:1];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _contentLabel;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.contentLabel.font = selected?[UIFont systemFontOfSize:16.0]:[UIFont systemFontOfSize:14.0];
        if (_lineStyle == ZJHorListViewLineStyleNone) {
            self.lineView.hidden = YES;
        } else {
            self.lineView.hidden = !selected;
        }
        
    } completion:nil];
   
}

- (void)setContent:(NSString *)content {
    _content = content;
    _contentLabel.text = content;
}

- (void)setBubbleMaxValue:(NSInteger)bubbleMaxValue {
    _bubbleMaxValue = bubbleMaxValue;
    self.bubbleView.bubbleMaxValue = _bubbleMaxValue;
    [_bubbleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentLabel.mas_right);
        make.centerY.mas_equalTo(self.contentLabel.mas_top).mas_offset(5.0);
        CGFloat width = [self getRectByString:[NSString stringWithFormat:@"%ld",self.bubbleValue]].size.width+10;
        make.width.mas_equalTo(MAX(width, 15.f));
        make.height.mas_equalTo(15.f);
    }];
}

- (void)setBubbleValue:(NSInteger)bubbleValue {
    _bubbleValue = bubbleValue;
    if (_bubbleValue==0) {
        self.bubbleView.hidden = YES;
        return;
    }
    self.bubbleView.bubbleValue = _bubbleValue;
    
    [_bubbleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentLabel.mas_right);
        make.centerY.mas_equalTo(self.contentLabel.mas_top).mas_offset(5.0);
        CGFloat width = [self getRectByString:[NSString stringWithFormat:@"%ld",self.bubbleValue]].size.width+10;
        make.width.mas_equalTo(MAX(width, 15.f));
        make.height.mas_equalTo(15.f);
    }];
}

- (void)setShouldShowBubble:(BOOL)shouldShowBubble {
    _shouldShowBubble = shouldShowBubble;
    self.bubbleView.hidden = !_shouldShowBubble;
}

- (ZJBubbleView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [[ZJBubbleView alloc] init];
    }
    return _bubbleView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =  [UIColor colorWithRed:46/255.0 green:111/255.0 blue:230/255.0 alpha:1];
    }
    return _lineView;
}

- (void)setLineStyle:(ZJHorListViewLineStyle)lineStyle {
    _lineStyle = lineStyle;
    switch (_lineStyle) {
        case ZJHorListViewLineStyleNone:
        {
            _lineView.hidden = YES;
        }
            break;
        case ZJHorListViewLineStyleEqualTitle:
        {
            [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self);
                make.left.right.mas_equalTo(self.contentLabel);
                make.height.mas_equalTo(3.0);
            }];
        }
            break;
        case ZJHorListViewLineStyleEqualCell:
        {
            [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self);
                make.height.mas_equalTo(3.0);
            }];
        }
            break;
        case ZJHorListViewLineStyleFixedLength:
        {
            [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.bottom.mas_equalTo(self);
                make.width.mas_equalTo(20.0);
                make.height.mas_equalTo(3.0);
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.bubbleView];
    [self.contentView addSubview:self.lineView];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
    [_bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentLabel.mas_right);
        make.centerY.mas_equalTo(self.contentLabel.mas_top).mas_offset(5.0);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(3.0);
    }];
}





@end
