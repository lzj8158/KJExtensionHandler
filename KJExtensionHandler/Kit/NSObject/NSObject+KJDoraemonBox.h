//
//  NSObject+KJDoraemonBox.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/29.
//  https://github.com/yangKJ/KJExtensionHandler
//  哆啦A梦百宝箱
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^KJObserveResultBlock) (id newValue, id oldValue);
@interface NSObject (KJDoraemonBox)
/// 代码执行时间处理，block当中执行代码
+ (CFTimeInterval)kj_executeTime:(void(^)(void))block;

#pragma mark - kvo键值监听封装，自动释放
/// 记录已经添加监听的keyPath与对应的block
@property(nonatomic,strong,readonly)NSMutableDictionary *observeDictionary;
/// kvo监听，暂不支持 `.` 语法
- (void)kj_observeKey:(NSString*)keyPath ResultBlock:(KJObserveResultBlock)block;

#pragma mark - 轻量级解耦工具（信号方式）
/// 发送消息处理
- (id)kj_sendSemaphoreWithKey:(NSString*)key Message:(id)message Parameter:(id _Nullable)parameter;
/// 接收消息处理
- (void)kj_receivedSemaphoreBlock:(id _Nullable(^)(NSString *key, id message, id _Nullable parameter))block;

#pragma mark - 路由框架（基于URL实现控制器转场）
/// 注册路由URL
+ (void)kj_routerRegisterWithURL:(NSURL*)URL Block:(UIViewController * (^)(NSURL *URL, UIViewController *vc))block;
/// 移除路由URL
+ (void)kj_routerRemoveWithURL:(NSURL*)URL;
/// 执行跳转处理
+ (void)kj_routerTransferWithURL:(NSURL*)URL source:(UIViewController*)vc;
+ (void)kj_routerTransferWithURL:(NSURL*)URL source:(UIViewController*)vc completion:(void(^_Nullable)(UIViewController *vc))completion;
/// 解析获取参数
+ (NSDictionary*)kj_analysisParameterGetQuery:(NSURL*)URL;

@end

NS_ASSUME_NONNULL_END
/* kvo键值监听封装使用规则 */
// [self.label kj_observeKey:@"text" ObserveResultBlock:^(id _Nonnull newValue, id _Nonnull oldValue) {
//     NSLog(@"%@",newValue);
// }];

/* 轻量级解耦工具使用规则 */
// 在View当中发送消息
// UIViewController *vc = [NSClassFromString(dic[@"VCName"]) new];
// [self kj_sendSemaphoreWithKey:kHomeViewKey Message:vc Parameter:dic];
//
// 在ViewController当中接收事件处理
// _weakself;
// [view kj_receivedSemaphoreBlock:^id _Nullable(NSString * _Nonnull key, id _Nonnull message, id _Nullable parameter) {
//     if ([key isEqualToString:kHomeViewKey]) {
//         ((UIViewController*)message).title = ((NSDictionary*)parameter)[@"describeName"];
//         [weakself.navigationController pushViewController:message animated:true];
//     }
//     return nil;
// }];
