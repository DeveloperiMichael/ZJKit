//
//  ZJFont.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import <Foundation/Foundation.h>


/**
 字体类型，目前采用的是HelveticaNeue字体系列。
 @warning 字体类型从细到粗的顺序是：廋体 < 细体 < 常规 < 中等 < 加粗
 */
typedef NS_ENUM(NSInteger, ZJFontType){
    /**廋体**/
    ZJFontTypeThin,
    /**细体*/
    ZJFontTypeLight,
    /**常规**/
    ZJFontTypeRegular,
    /**中等**/
    ZJFontTypeMedium,
    /**加粗**/
    ZJFontTypeBold,
    /**AvenirNextCondensed-Bold**/
    ZJFontTypeNumBold,
};


@interface ZJFont : NSObject

/**
 120px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font120px:(ZJFontType)fontType;

/**
 60px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font60px:(ZJFontType)fontType;

/**
 48px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font48px:(ZJFontType)fontType;

/**
 42px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font42px:(ZJFontType)fontType;

/**
 36px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font36px:(ZJFontType)fontType;

/**
 34px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font34px:(ZJFontType)fontType;

/**
 32px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font32px:(ZJFontType)fontType;

/**
 30px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font30px:(ZJFontType)fontType;

/**
 28px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font28px:(ZJFontType)fontType;

/**
 26px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font26px:(ZJFontType)fontType;

/**
 24px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font24px:(ZJFontType)fontType;

/**
 22px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font22px:(ZJFontType)fontType;

/**
 20px
 @param fontType 字体类型
 @return 字体对象
 */
+ (UIFont *)zj_font20px:(ZJFontType)fontType;

@end
