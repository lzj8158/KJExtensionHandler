//
//  _KJGCD.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler

#ifndef _KJGCD_h
#define _KJGCD_h

// 同步会阻塞主线程
#pragma mark ********** 11.线程 GCD   *********
/* 使用方式 kGCD_MAIN_ASYNC(^{ NSLog(@"77"); }); */
// 异步主线程
#define kGCD_MAIN_ASYNC(main_queue_block) dispatch_async(dispatch_get_main_queue(), main_queue_block)
// 异步子线程
#define kGCD_QUEUE_ASYNC(global_queue_block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), global_queue_block)
// 一次性执行
#define kGCD_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
// 异步并行队列
#define kGCD_GROUP_ASYNC(group_async_block,group_notify_block) \
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);\
dispatch_group_t group = dispatch_group_create();\
dispatch_group_async(group, queue, group_async_block);\
dispatch_group_notify(group, queue, ^{\
dispatch_async(dispatch_get_main_queue(), group_notify_block);\
})\

/* kGCD_Async_MainQueue({ self.button.padding = 20;}); */
// 异步主线程执行，不强持有Self
#define kGCD_Async_MainQueue(x) \
__weak typeof(self) weakSelf = self; \
dispatch_async(dispatch_get_main_queue(), ^{ \
typeof(weakSelf) self = weakSelf; \
{x} \
});

#pragma mark - GCD 线程处理
NS_INLINE dispatch_queue_t kGCD_queue(void) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    return queue;
}
/// 主线程
NS_INLINE void kGCD_main(dispatch_block_t block) {
    dispatch_queue_t queue = dispatch_get_main_queue();
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {
        block();
    }else{
        if ([[NSThread currentThread] isMainThread]) {
            dispatch_async(queue, block);
        }else{
            dispatch_sync(queue, block);
        }
    }
}
/// 子线程
NS_INLINE void kGCD_async(dispatch_block_t block) {
    dispatch_queue_t queue = kGCD_queue();
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {
        block();
    }else{
        dispatch_async(queue, block);
    }
}
/// 异步并行队列，携带可变参数（需要nil结尾）
NS_INLINE void kGCD_group_notify(dispatch_block_t notify,dispatch_block_t block,...) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, block);
    va_list args;dispatch_block_t arg;
    va_start(args, block);
    while ((arg = va_arg(args, dispatch_block_t))) {
        dispatch_group_async(group, queue, arg);
    }
    va_end(args);
    dispatch_group_notify(group, queue, notify);
}
/// 栅栏
NS_INLINE dispatch_queue_t kGCD_barrier(dispatch_block_t block,dispatch_block_t barrier) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_async(queue, block);
    dispatch_barrier_async(queue, ^{ dispatch_async(dispatch_get_main_queue(), barrier); });
    return queue;
}
/// 一次性
NS_INLINE void kGCD_once(dispatch_block_t block) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, block);
}
/// 延时执行
NS_INLINE void kGCD_after(int64_t delayInSeconds, dispatch_block_t block) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(time, queue, block);
}
NS_INLINE void kGCD_after_main(int64_t delayInSeconds, dispatch_block_t block) {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), block);
}
/// 主线程当中延时执行
NS_INLINE void kGCD_main_after(int64_t delayInSeconds, dispatch_block_t block) {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), block);
}
/// 快速迭代
NS_INLINE void kGCD_apply(int iterations, void(^block)(size_t idx)) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_apply(iterations, queue, block);
}
/// 快速遍历数组
NS_INLINE void kGCD_apply_array(NSArray * temp, void(^block)(id obj, size_t index)) {
    void (^xxblock)(size_t) = ^(size_t index){
        block(temp[index],index);
    };
    dispatch_apply(temp.count, kGCD_queue(), xxblock);
}

#endif /* _KJGCD_h */
