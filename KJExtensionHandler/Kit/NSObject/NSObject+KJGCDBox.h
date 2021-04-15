//
//  NSObject+KJGCDBox.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/3/17.
//  https://github.com/yangKJ/KJExtensionHandler
//  GCD盒子封装，

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJGCDBox)
/* 创建异步定时器 */
- (dispatch_source_t)kj_gcdCreateAsyncTimer:(BOOL)async
                                       Task:(void(^)(void))task
                                      start:(NSTimeInterval)start
                                   interval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats;
/* 取消计时器 */
- (void)kj_gcdStopTimer:(dispatch_source_t)timer;
/* 暂停计时器 */
- (void)kj_gcdPauseTimer:(dispatch_source_t)timer;
/* 继续计时器 */
- (void)kj_gcdResumeTimer:(dispatch_source_t)timer;

/* 延时执行 */
- (void)kj_gcdAfterTask:(void(^)(void))task time:(NSTimeInterval)time Asyne:(BOOL)async;
/* 异步快速迭代 */
- (void)kj_gcdApplyTask:(BOOL(^)(size_t index))task count:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
