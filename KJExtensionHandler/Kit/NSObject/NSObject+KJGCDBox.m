//
//  NSObject+KJGCDBox.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/3/17.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJGCDBox.h"
@interface NSObject ()
@property(nonatomic,assign)BOOL isHangUp;
@end

@implementation NSObject (KJGCDBox)
/* 创建异步定时器 */
- (dispatch_source_t)kj_gcdCreateAsyncTimer:(BOOL)async Task:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats{
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    self.isHangUp = NO;
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    __block dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    __weak __typeof(self) weaktarget = self;
    dispatch_source_set_event_handler(timer, ^{
        if (weaktarget == nil) {
            dispatch_source_cancel(timer);
            timer = nil;
        }else{
            if (repeats) {
                task();
            }else{
                task();
                [self kj_gcdStopTimer:timer];
            }
        }
    });
    dispatch_resume(timer);
    return timer;
}
/* 取消计时器 */
- (void)kj_gcdStopTimer:(dispatch_source_t)timer{
    self.isHangUp = NO;
    dispatch_source_t __timer = timer;
    if (__timer) {
        dispatch_source_cancel(__timer);
        __timer = nil;
    }
}
/* 暂停计时器 */
- (void)kj_gcdPauseTimer:(dispatch_source_t)timer{
    if (timer) {
        self.isHangUp = YES;
        dispatch_suspend(timer);
    }
}
/* 继续计时器 */
- (void)kj_gcdResumeTimer:(dispatch_source_t)timer{
    if (timer && self.isHangUp) {
        self.isHangUp = NO;
        //挂起的时候注意，多次暂停的操作会导致线程锁的现象
        //dispatch_suspend和dispatch_resume是一对
        dispatch_resume(timer);
    }
}

/* 延时执行 */
- (void)kj_gcdAfterTask:(void(^)(void))task time:(NSTimeInterval)time Asyne:(BOOL)async{
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), queue, ^{
        task();
    });
}
/* 异步快速迭代 */
- (void)kj_gcdApplyTask:(BOOL(^)(size_t index))task count:(NSUInteger)count{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(count, queue, ^(size_t index) {
        if (task(index)) { }
    });
}

#pragma mark - Associated
- (BOOL)isHangUp{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsHangUp:(BOOL)isHangUp{
    objc_setAssociatedObject(self, @selector(isHangUp), @(isHangUp), OBJC_ASSOCIATION_ASSIGN);
}

@end
