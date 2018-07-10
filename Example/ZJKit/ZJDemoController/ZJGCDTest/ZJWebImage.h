//
//  ZJWebImage.h
//  ZJKit_Example
//
//  Created by 张炯 on 2018/7/3.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PhotoDownloadingCompletionBlock)(UIImage *image, NSError *error);

@interface ZJWebImage : NSObject

@property (nonatomic, strong, readonly) UIImage *image;

- (instancetype)initWithImageUrl:(NSString *)url finishedDownloadImage:(PhotoDownloadingCompletionBlock)completionBlock;

@end
