//
//  NSObject+KJRuntime.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/15.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJRuntime.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (KJRuntime)
@dynamic propertyTemps;
- (NSArray<NSString*>*)propertyTemps{
    NSMutableArray *temps = [NSMutableArray array];
    unsigned int outCount, i;
    Class targetClass = [self class];
    while (targetClass != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(targetClass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            if (propertyName) [temps addObject:propertyName];
        }
        free(properties);
        targetClass = [targetClass superclass];
    }
    return temps.mutableCopy;
}
@dynamic ivarTemps;
- (NSArray<NSString*>*)ivarTemps{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        const char *char_f = ivar_getName(ivar[i]);
        NSString *name = [NSString stringWithCString:char_f encoding:NSUTF8StringEncoding];
        if (name) [temp addObject:name];
    }
    return temp.mutableCopy;
}
@dynamic methodTemps;
- (NSArray<NSString*>*)methodTemps{
    unsigned int count;
    Method *method = class_copyMethodList([self class], &count);
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        NSString *name = NSStringFromSelector(method_getName(method[i]));
        if (name) [temp addObject:name];
    }
    return temp.mutableCopy;
}
@dynamic protocolTemps;
- (NSArray<NSString*>*)protocolTemps{
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i<count; i++) {
        const char *protocolName = protocol_getName(protocolList[i]);
        NSString *name = [NSString stringWithCString:protocolName encoding:NSUTF8StringEncoding];
        if (name) [temp addObject:name];
    }
    return temp.mutableCopy;
}

/// 归档封装
- (void)kj_encodeRuntime:(NSCoder*)encoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char *name = ivar_getName(ivars[i]);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivars);
}
/// 解档封装
- (void)kj_initCoderRuntime:(NSCoder*)decoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char *name = ivar_getName(ivars[i]);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [decoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(ivars);
}
/// 动态继承，慎用（一旦修改后面使用的都是该子类）
- (void)kj_dynamicInheritChildClass:(Class)clazz{
    // 动态继承修改(self)对象的isa指针使其指向子类(clazz)，便可以调用子类的方法
    object_setClass(self, clazz);
}

/// 交换实例方法
void kRuntimeMethodSwizzling(Class clazz, SEL original, SEL swizzled){
    Method originalMethod = class_getInstanceMethod(clazz, original);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzled);
    if (class_addMethod(clazz, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(clazz, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
/// 交换类方法
void kRuntimeClassMethodSwizzling(Class clazz, SEL original, SEL swizzled){
    Method originalMethod = class_getClassMethod(clazz, original);
    Method swizzledMethod = class_getClassMethod(clazz, swizzled);
    Class metaclass = objc_getMetaClass(NSStringFromClass(clazz).UTF8String);
    if (class_addMethod(metaclass, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(metaclass, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
