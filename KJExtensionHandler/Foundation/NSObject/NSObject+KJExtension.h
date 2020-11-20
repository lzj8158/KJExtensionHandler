//
//  NSObject+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler
//  动态添加

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJExtension)
/// 获取该对象的所有属性，包含父类
- (NSArray*)kj_getTotalPropertieNames;
#pragma mark - 动态添加属性
/// 记录已经添加的属性
@property(nonatomic,strong,readonly)NSMutableArray *propertyNames;
/// 动态添加关联
- (void)kj_setAssociatedWithPropertyName:(NSString*)propertyName Value:(id)value Policy:(objc_AssociationPolicy)policy;
/// 获取动态添加的值
- (id)kj_getValueWithPropertyName:(NSString*)propertyName;
/// 移除动态添加的属性
- (void)kj_removeAllPropertyNames;

@end

NS_ASSUME_NONNULL_END
