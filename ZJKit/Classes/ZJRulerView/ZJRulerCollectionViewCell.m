//
//  ZJRulerCollectionViewCell.m
//  ZJKit
//
//  Created by 张炯 on 2018/6/7.
//

#import "ZJRulerCollectionViewCell.h"
#import "ZJKit.h"
#import <Masonry/Masonry.h>

@interface ZJRulerCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *horLineView;

@property (nonatomic, strong) UIView *verLineView;

@end


@implementation ZJRulerCollectionViewCell

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

-(void)setContent:(NSString *)content {
    _content = content;
    _label.text = _content;
}


#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [ZJFont zj_font36px:ZJFontTypeNumBold];
        _label.textColor = [ZJColor zj_colorC8];
        _label.text = @"15";
    }
    return _label;
}

- (UIView *)horLineView {
    if (!_horLineView) {
        _horLineView = [[UIView alloc] init];
        _horLineView.backgroundColor = [ZJColor zj_colorC8];
    }
    return _horLineView;
}

- (UIView *)verLineView {
    if (!_verLineView) {
        _verLineView = [[UIView alloc] init];
        _verLineView.backgroundColor = [ZJColor zj_colorC8];
    }
    return _verLineView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.horLineView];
    [self.contentView addSubview:self.verLineView];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
    }];
    [_horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    [_verLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(8.0);
        make.width.mas_equalTo(0.5);
    }];
}


@end
