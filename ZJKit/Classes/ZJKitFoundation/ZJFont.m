//
//  ZJFont.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import "ZJFont.h"
#import "ZJKitConstant.h"

@implementation ZJFont

+ (UIFont *)zj_font120px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:60.0f];
}

+ (UIFont *)zj_font60px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:30.0f];
}

+ (UIFont *)zj_font48px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:24.0f];
}

+ (UIFont *)zj_font42px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:21.0f];
}

+ (UIFont *)zj_font36px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:18.0f];
}

+ (UIFont *)zj_font34px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:17.0f];
}

+ (UIFont *)zj_font32px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:16.0f];
}

+ (UIFont *)zj_font30px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:15.0f];
}

+ (UIFont *)zj_font28px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:14.0f];
}

+ (UIFont *)zj_font26px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:13.0f];
}

+ (UIFont *)zj_font24px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:12.0f];
}

+ (UIFont *)zj_font22px:(ZJFontType)fontName {
    return [ZJFont fontWithBoldType:fontName size:11.0f];
}

+ (UIFont *)zj_font20px:(ZJFontType)fontName{
    return [ZJFont fontWithBoldType:fontName size:10.0f];
}

+ (UIFont *)fontWithBoldType:(ZJFontType)boldType size:(CGFloat)size{
    NSString *thinFontName;//纤细
    NSString *lightFontName;//细体
    NSString *regularFontName;//常规
    NSString *mediumFontName;//加粗
    NSString *boldFontName;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0f) {
        thinFontName   = @"HelveticaNeue-Thin";//纤细
        lightFontName = @"HelveticaNeue-Light";//细体
        regularFontName = @"HelveticaNeue";//常规
        mediumFontName = @"HelveticaNeue-Medium";//加粗
        boldFontName = @"HelveticaNeue-Bold";
    }else {
        thinFontName = @"PingFangSC-Thin";
        lightFontName = @"PingFangSC-Light";
        regularFontName = @"PingFangSC-Regular";
        mediumFontName = @"PingFangSC-Medium";
        boldFontName = @"PingFangSC-Semibold";
    }
    
    CGFloat ratio = (kScreen_width > 320 && kScreen_height > 568) ? 1 : kScreenWidthRatio();
    switch (boldType) {
        case ZJFontTypeThin:
            return [UIFont fontWithName:thinFontName size:size * ratio];
        case ZJFontTypeLight:
            return [UIFont fontWithName:lightFontName size:size * ratio];
        case ZJFontTypeRegular:
            return [UIFont fontWithName:regularFontName size:size * ratio];
        case ZJFontTypeMedium:
            return [UIFont fontWithName:mediumFontName size:size * ratio];
        case ZJFontTypeBold:
            return [UIFont fontWithName:boldFontName size:size * ratio];
        case ZJFontTypeNumBold:
            return [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:size * ratio];
        default:
            return nil;
    }
}

@end
