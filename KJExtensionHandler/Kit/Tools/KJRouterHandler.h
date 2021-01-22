//
//  KJRouterHandler.h
//  KJBaseHandler
//
//  Created by 杨科军 on 2020/10/20.
//  https://github.com/yangKJ/KJBaseHandler
//  路由 - 基于URL实现控制器转场的框架
//  NSURL *URL = [NSURL URLWithString:@"https://www.test.com/xxxx?className=KJVideoEncodeVC&title=title"];
//  URL.query          // className=KJVideoEncodeVC&title=title
//  URL.scheme         // https
//  URL.host           // www.test.com
//  URL.path           // /xxxx
//  URL.absoluteString // https://www.test.com/test?className=KJVideoEncodeVC&title=title

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/// 解析参数
@interface NSURL (KJRouter)
/// 解析获取参数
- (NSDictionary*)kj_analysisParameterGetQuery;
@end
typedef UIViewController * _Nonnull (^kRouterBlock)(NSURL *URL, UIViewController *sourcevc);
@interface KJRouterHandler : NSObject
/// 注册路由URL
+ (void)kj_routerRegisterWithURL:(NSURL*)URL Block:(kRouterBlock)block;
/// 移除路由URL
+ (void)kj_routerRemoveWithURL:(NSURL*)URL;
/// 执行跳转处理
+ (void)kj_routerTransferWithURL:(NSURL*)URL source:(UIViewController*)vc;
+ (void)kj_routerTransferWithURL:(NSURL*)URL source:(UIViewController*)vc completion:(void(^_Nullable)(UIViewController *__vc))completion;

@end

NS_ASSUME_NONNULL_END
