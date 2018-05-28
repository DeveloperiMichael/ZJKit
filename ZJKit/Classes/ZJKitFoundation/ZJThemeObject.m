//
//  ZJThemeObject.m
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//



#import "ZJThemeObject.h"

@implementation ZJThemeObject

+ (instancetype)shareInstance {
    static ZJThemeObject *themeObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeObject = [[ZJThemeObject alloc] init];
        themeObject.themeMode = ZJThemeDefaultMode;
    });
    
    return themeObject;
}


@end
