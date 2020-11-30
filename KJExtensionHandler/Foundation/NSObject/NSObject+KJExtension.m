//
//  NSObject+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJExtension.h"

@implementation NSObject (KJExtension)
/// 获取该对象的所有属性，包含父类
- (NSArray*)kj_getTotalPropertieNames{
    NSMutableArray *temps = [NSMutableArray array];
    unsigned int outCount, i;
    Class targetClass = [self class];
    while (targetClass != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(targetClass, &outCount);
        for (i = 0; i < outCount; i++)  {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            [temps addObject:propertyName];
        }
        free(properties);
        targetClass = [targetClass superclass];
    }
    return temps.mutableCopy;
}
#pragma mark - associated
- (NSMutableArray*)propertyNames{
    NSMutableArray *array = objc_getAssociatedObject(self, @selector(propertyNames));
    if (array == nil) {
        array = [NSMutableArray array];
        [self setPropertyNames:array];
    }
    return array;
}
- (void)setPropertyNames:(NSMutableArray*)propertyNames{
    objc_setAssociatedObject(self, @selector(propertyNames), propertyNames, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)kj_setAssociatedWithPropertyName:(NSString*)propertyName Value:(id)value Policy:(objc_AssociationPolicy)policy{
    objc_setAssociatedObject(self, (__bridge objc_objectptr_t)propertyName, value, policy);
    [self.propertyNames addObject:propertyName];
}
- (id)kj_getValueWithPropertyName:(NSString*)propertyName{
    return objc_getAssociatedObject(self, (__bridge objc_objectptr_t)propertyName);
}
- (void)kj_removeAllPropertyNames{
    [self.propertyNames removeAllObjects];
    objc_removeAssociatedObjects(self);
}

@end
