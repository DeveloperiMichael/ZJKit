//
//  ZJRowPickerTableViewCell.m
//  ZJKit
//
//  Created by 张炯 on 2018/7/10.
//

#import "ZJRowPickerTableViewCell.h"
#import <ZJKit/ZJKit.h>

@interface ZJRowPickerTableViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ZJRowPickerTableViewCell

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
#pragma mark- Getters && Setters

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [ZJColor zj_colorC8];
        _label.font = [ZJFont zj_font42px:ZJFontTypeRegular];
    }
    return _label;
}

- (void)setZj_selected:(BOOL)zj_selected {
    _zj_selected = zj_selected;
    _label.textColor = _zj_selected?[ZJColor zj_colorC5]:[ZJColor zj_colorC8];
    _label.font = _zj_selected?[ZJFont zj_font42px:ZJFontTypeBold]:[ZJFont zj_font32px:ZJFontTypeRegular];
}

- (void)setContent:(NSString *)content {
    _content = content;
    if (_content.length>0) _label.text = _content;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.contentView addSubview:self.label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}


@end
