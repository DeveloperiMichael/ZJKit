//
//  ZJThemeObject.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import <Foundation/Foundation.h>

/**
 关于主题风格的设置、读取
 正常模式
 夜间模式
 护眼模式
 等等 主要用于配置App不同色调
 */



/**
 主题模式

 - ZJThemeDefaultMode: 默认模式
 - ZJThemeNightMode: 夜间模式
 - ZJThemeProtectEyesMode: 护眼模式
 */
typedef NS_ENUM(NSInteger, ZJThemeMode) {
    ZJThemeDefaultMode = 0,
    ZJThemeNightMode,
    ZJThemeProtectEyesMode,
};


@interface ZJThemeObject : NSObject

@property(nonatomic, assign) ZJThemeMode themeMode;

+(instancetype) shareInstance;

@end
