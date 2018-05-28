//
//  ZJBubbleView.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/17.
//

#import "ZJBubbleView.h"
#import <Masonry/Masonry.h>

@interface ZJBubbleView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ZJBubbleView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15.f*0.5;
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1.0];
        [self setupSubviewsContraints];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    CGRect frame = self.frame;
    frame.size.height = 15.f;
    self.frame = frame;
}

- (void)addConstraint:(NSLayoutConstraint *)constraint {
    if (constraint.firstAttribute == NSLayoutAttributeHeight) {
        constraint.constant = 15.f;
    }
    [super addConstraint:constraint];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:10.0];
        _label.textColor = [UIColor whiteColor];
        _label.numberOfLines = 1;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)setBubbleValue:(NSInteger)bubbleValue {
    _bubbleValue = bubbleValue;
    [self setLabelText];
}

- (void)setBubbleMaxValue:(NSInteger)bubbleMaxValue {
    _bubbleMaxValue = bubbleMaxValue;
    [self setLabelText];
}

- (void)setLabelText {
    if (_bubbleValue>_bubbleMaxValue) {
        _label.text = [NSString stringWithFormat:@"%ld+",_bubbleMaxValue];
    } else {
        _label.text = [NSString stringWithFormat:@"%ld",_bubbleValue];
    }
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

@end
