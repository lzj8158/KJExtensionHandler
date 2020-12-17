//
//  NSTimer+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/16.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSTimer+KJExtension.h"
#import <objc/runtime.h>
@implementation NSTimer (KJExtension)
+ (NSTimer*)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval Repeats:(BOOL)repeats Block:(void(^)(NSTimer*timer))block{
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(blcokInvoke:) userInfo:[block copy] repeats:repeats];
}
+ (void)blcokInvoke:(NSTimer*)timer{
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) block(timer);
}

/// 下次执行计时器
+ (NSTimer*)kj_scheduledNoImmediateTimerWithTimeInterval:(NSTimeInterval)inerval Block:(void(^)(NSTimer*timer))block{
    self.immediate = NO;
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(blcokInvokeImmediate:) userInfo:[block copy] repeats:YES];
}
+ (void)blcokInvokeImmediate:(NSTimer*)timer{
    if (self.immediate == NO) {
        self.immediate = YES;
        return;
    }
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) block(timer);
}
+ (BOOL)immediate{
    return [objc_getAssociatedObject(self, @selector(immediate)) boolValue];
}
+ (void)setImmediate:(BOOL)immediate{
    objc_setAssociatedObject(self, @selector(immediate), @(immediate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
