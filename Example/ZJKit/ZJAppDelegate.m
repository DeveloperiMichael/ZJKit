//
//  ZJAppDelegate.m
//  ZJKit
//
//  Created by DeveloperiMichael on 05/23/2018.
//  Copyright (c) 2018 DeveloperiMichael. All rights reserved.
//

#import "ZJAppDelegate.h"
#import "ZJViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface ZJAppDelegate ()

@end

@implementation ZJAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //     Override point for customization after application launch.
    //如果想进SAViewController调试
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ZJViewController alloc] init]];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    return YES;
}



- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end
