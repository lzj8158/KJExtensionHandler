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
@end
