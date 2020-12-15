//
//  NSObject+KJSemaphore.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/15.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJSemaphore.h"
#import <objc/runtime.h>
@implementation NSObject (KJSemaphore)
/// 发送消息处理
- (id)kj_sendSemaphoreWithKey:(NSString*)key Message:(id)message Parameter:(id _Nullable)parameter{
#ifdef DEBUG
    NSLog(@"🍒🍒 发送信号消息 🍒🍒\nSenderKey:%@\n目标:%@\n发送者:%@\n携带参数:%@",key,message,self,parameter);
#endif
    return self.semaphoreblock?self.semaphoreblock(key,message,parameter):nil;
}
/// 接收消息处理
- (void)kj_receivedSemaphoreBlock:(KJSemaphoreBlock)block{
    if (block) self.semaphoreblock = block;
}
#pragma mark - associated
- (KJSemaphoreBlock)semaphoreblock{
    return objc_getAssociatedObject(self, @selector(semaphoreblock));
}
- (void)setSemaphoreblock:(KJSemaphoreBlock)semaphoreblock{
    objc_setAssociatedObject(self, @selector(semaphoreblock), semaphoreblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/// 代码执行时间处理，block当中执行代码
+ (CFTimeInterval)kj_executeTime:(void(^)(void))block{
    if (block) {
        CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
        block();
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        NSLog(@"Linked in %f ms", linkTime * 1000.0);
        return linkTime * 1000;
    }
    return 0;
}
@end
