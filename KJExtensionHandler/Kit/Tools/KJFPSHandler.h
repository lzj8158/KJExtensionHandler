//
//  KJFPSHandler.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2019/1/9.
//  https://github.com/yangKJ/KJExtensionHandler
//  FPS监控工具

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KJFPSHandler : NSObject
+ (instancetype)shareInstance;
/// fps回调 1秒回调一次
- (void)startMonitor:(void(^)(float fps))callback;

@end

NS_ASSUME_NONNULL_END
