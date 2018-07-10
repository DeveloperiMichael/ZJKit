//
//  ZJWebImage.m
//  ZJKit_Example
//
//  Created by 张炯 on 2018/7/3.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import "ZJWebImage.h"

@interface ZJWebImage ()

@property (nonatomic, strong, readwrite) UIImage *image;

@end

@implementation ZJWebImage



- (instancetype)initWithImageUrl:(NSString *)url finishedDownloadImage:(PhotoDownloadingCompletionBlock)completionBlock {
    static NSURLSession *session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration];
    });
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.image = [UIImage imageWithData:data];
        
        if (completionBlock) {
            completionBlock(self.image,error);
        }
        
    }];
    
    [task resume];
    
    return self;
}


@end
