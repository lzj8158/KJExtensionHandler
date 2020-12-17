//
//  NSTimer+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/16.
//  https://github.com/yangKJ/KJExtensionHandler

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (KJExtension)
/// 立即执行计时器
+ (NSTimer*)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval Repeats:(BOOL)repeats Block:(void(^)(NSTimer*timer))block;
/// 下次执行计时器
+ (NSTimer*)kj_scheduledNoImmediateTimerWithTimeInterval:(NSTimeInterval)inerval Block:(void(^)(NSTimer*timer))block;

@end

NS_ASSUME_NONNULL_END
