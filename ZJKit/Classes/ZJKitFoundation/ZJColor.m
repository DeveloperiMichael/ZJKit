//
//  ZJColor.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/23.
//

#import "ZJColor.h"
#import "ZJThemeObject.h"

@implementation ZJColor


+ (UIColor *)zj_colorC1{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:33/255.0 green:37/255.0 blue:40/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:33/255.0 green:37/255.0 blue:40/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:51/255.0 green:124/255.0 blue:255/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC1Cur{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:18/255.0 green:19/255.0 blue:21/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:18/255.0 green:19/255.0 blue:21/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:46/255.0 green:111/255.0 blue:230/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC2{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:211/255.0 green:167/255.0 blue:102/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:211/255.0 green:167/255.0 blue:102/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:247/255.0 green:168/255.0 blue:47/255.0 alpha:1];
        }
            break;
    }
    
}

+ (UIColor *)zj_colorC2Cur{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:183/255.0 green:144/255.0 blue:87/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:183/255.0 green:144/255.0 blue:87/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:223/255.0 green:152/255.0 blue:42/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC3{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        }
            break;
    }
    
}

+ (UIColor *)zj_colorC4{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:18/255.0 green:20/255.0 blue:23/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:18/255.0 green:20/255.0 blue:23/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:18/255.0 green:20/255.0 blue:23/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC5{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:69/255.0 green:73/255.0 blue:78/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:69/255.0 green:73/255.0 blue:78/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:69/255.0 green:73/255.0 blue:78/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC6{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:88/255.0 green:93/255.0 blue:98/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:88/255.0 green:93/255.0 blue:98/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:88/255.0 green:93/255.0 blue:98/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC7{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:150/255.0 green:153/255.0 blue:158/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:150/255.0 green:153/255.0 blue:158/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:150/255.0 green:153/255.0 blue:158/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC8{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:213/255.0 green:215/255.0 blue:220/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:213/255.0 green:215/255.0 blue:220/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:213/255.0 green:215/255.0 blue:220/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC9{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:235/255.0 green:236/255.0 blue:238/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:235/255.0 green:236/255.0 blue:238/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:235/255.0 green:236/255.0 blue:238/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC10{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:243/255.0 green:246/255.0 blue:251/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:243/255.0 green:246/255.0 blue:251/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:243/255.0 green:246/255.0 blue:251/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC11{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:254/255.0 green:80/255.0 blue:46/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:254/255.0 green:80/255.0 blue:46/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:254/255.0 green:80/255.0 blue:46/255.0 alpha:1];
        }
            break;
    }
}

+ (UIColor *)zj_colorC12{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:69/255.0 green:72/255.0 blue:77/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:69/255.0 green:72/255.0 blue:77/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:131/255.0 green:111/255.0 blue:219/255.0 alpha:1];
        }
            break;
    }
    
}

+ (UIColor *)zj_colorC13{
    switch ([ZJThemeObject shareInstance].themeMode) {
        case ZJThemeNightMode:
        {
            return [UIColor colorWithRed:51/255.0 green:54/255.0 blue:59/255.0 alpha:1];
        }
            break;
        case ZJThemeProtectEyesMode:
        {
            return [UIColor colorWithRed:51/255.0 green:54/255.0 blue:59/255.0 alpha:1];
        }
            break;
        default:{
            return [UIColor colorWithRed:35/255.0 green:192/255.0 blue:177/255.0 alpha:1];
        }
            break;
    }
}

@end
