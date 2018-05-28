//
//  ZJKitConstant.h
//  ZJKit
//
//  Created by 张炯 on 2018/5/28.
//

#import <Foundation/Foundation.h>
#import "ZJDevice.h"


#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height

static inline UIColor *kColorByRGB(CGFloat r,CGFloat g,CGFloat b) {
    return [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
}

static inline CGFloat kScreenWidthRatio() {
    if (CGRectGetHeight([UIScreen mainScreen].bounds) > CGRectGetWidth([UIScreen mainScreen].bounds)) {
        return CGRectGetWidth([UIScreen mainScreen].bounds) / 375.0f;
    }else {
        return CGRectGetWidth([UIScreen mainScreen].bounds) / 667.0f;
    }
}

static inline CGFloat kScreenHeightRatio() {
    if (CGRectGetHeight([UIScreen mainScreen].bounds) > CGRectGetWidth([UIScreen mainScreen].bounds)) {
        return CGRectGetHeight([UIScreen mainScreen].bounds) / 667.0f;
    }else {
        return CGRectGetHeight([UIScreen mainScreen].bounds) / 375.0f;
    }
}


#if TARGET_IPHONE_SIMULATOR

static inline BOOL kDeviceIsiPhoneX() {
    
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
}

#elif TARGET_OS_IPHONE//真机

static inline BOOL kDeviceIsiPhoneX() {
    return [[ZJDevice deviceModel] isEqualToString:@"iPhone X"];
}

#endif


@interface ZJKitConstant : NSObject

@end
