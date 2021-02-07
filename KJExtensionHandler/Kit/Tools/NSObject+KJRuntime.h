//
//  NSObject+KJRuntime.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/15.
//  https://github.com/yangKJ/KJExtensionHandler
//  Runtime轻量级封装
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJRuntime)
/// 获取该对象的所有属性，包含父类
@property(nonatomic,strong,readonly)NSArray<NSString*>*propertyTemps;
/// 实例变量列表
@property(nonatomic,strong,readonly)NSArray<NSString*>*ivarTemps;
/// 方法列表
@property(nonatomic,strong,readonly)NSArray<NSString*>*methodTemps;
/// 遵循的协议列表
@property(nonatomic,strong,readonly)NSArray<NSString*>*protocolTemps;

/// 归档封装
- (void)kj_encodeRuntime:(NSCoder*)encoder;
/// 解档封装
- (void)kj_initCoderRuntime:(NSCoder*)decoder;

/// 动态继承，慎用（一旦修改后面使用的都是该子类）
- (void)kj_dynamicInheritChildClass:(Class)clazz;

/// 交换实例方法，该方法需要放在 dispatch_once 当中执行
void kRuntimeMethodSwizzling(Class clazz, SEL original, SEL swizzled);
/// 交换类方法
void kRuntimeClassMethodSwizzling(Class clazz, SEL original, SEL swizzled);

/// 获取对象类名
- (NSString*)kj_runtimeClassName;
/// 判断对象是否有该属性
- (void)kj_runtimeHaveProperty:(void(^)(NSString *property, BOOL * stop))traversal;

@end

NS_ASSUME_NONNULL_END
