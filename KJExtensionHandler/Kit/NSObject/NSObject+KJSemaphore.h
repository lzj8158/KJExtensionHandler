//
//  NSObject+KJSignal.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/15.
//  https://github.com/yangKJ/KJExtensionHandler
//  轻量级解耦工具（信号）
/*  使用规则
 在View当中发送消息
 UIViewController *vc = [NSClassFromString(dic[@"VCName"]) new];
 [self kj_sendSemaphoreWithKey:kHomeViewKey Message:vc Parameter:dic];
 
 在ViewController当中接收事件处理
 _weakself;
 [view kj_receivedSemaphoreBlock:^id _Nullable(NSString * _Nonnull key, id _Nonnull message, id _Nullable parameter) {
     if ([key isEqualToString:kHomeViewKey]) {
         ((UIViewController*)message).title = ((NSDictionary*)parameter)[@"describeName"];
         [weakself.navigationController pushViewController:message animated:true];
     }
     return nil;
 }];
*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef id _Nullable(^KJSemaphoreBlock)(NSString *key, id message, id _Nullable parameter);
@interface NSObject (KJSemaphore)
/// 发送消息处理
- (id)kj_sendSemaphoreWithKey:(NSString*)key Message:(id)message Parameter:(id _Nullable)parameter;
/// 接收消息处理
- (void)kj_receivedSemaphoreBlock:(KJSemaphoreBlock)block;

@end

NS_ASSUME_NONNULL_END
