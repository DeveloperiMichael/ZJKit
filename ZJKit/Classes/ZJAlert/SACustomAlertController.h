//
//  SACustomAlertController.h
//  SACustomAlert
//
//  Created by 汪志刚 on 2017/1/6.
//  Copyright © 2017年 汪志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮点击事件的block

 @param index 按钮对应的index
 @return 如果点击事件后有界面的跳转，传NO；否则传YES。（模态跳转可以传YES）
 */
typedef BOOL(^SAClickItemBlock)(NSInteger index);

@interface ZJAlertControllerView : UIView

@end

@interface SACustomAlertController : UIViewController

@property (nonatomic, assign) BOOL shouldTouchDismiss;

@property (nonatomic, strong, readonly) UIViewController *fromController;

- (void)presentAlertController;

- (void)dismissAlertController:(BOOL)animated;

@end
