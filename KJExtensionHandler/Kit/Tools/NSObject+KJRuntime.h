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
/// 获取该对象的所有实例变量
@property(nonatomic,strong,readonly)NSArray<NSString*>*ivarTemps;
/// 获取该对象的所有方法
@property(nonatomic,strong,readonly)NSArray<NSString*>*methodTemps;

@end

NS_ASSUME_NONNULL_END
