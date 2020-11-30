//
//  KJLinkedListQueue.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/30.
//  https://github.com/yangKJ/KJExtensionHandler
//  栈操作工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef struct KJPointNode{
    NSInteger value;
    NSInteger nextNodeOffset;
}KJPointNode;
@interface KJNodeQueue : NSObject<NSCopying>
/// 初始化
- (instancetype)initWithCapacity:(NSInteger)capacity Increments:(NSInteger)increments Multiplier:(NSInteger)multiplier;
/// 节点入栈
- (void)kj_pushNodeWithX:(NSInteger)x PushY:(NSInteger)y;
/// 节点出栈，返回是否出完
- (bool)kj_popNodeWithX:(NSInteger*)x PopY:(NSInteger*)y;

@end

NS_ASSUME_NONNULL_END
