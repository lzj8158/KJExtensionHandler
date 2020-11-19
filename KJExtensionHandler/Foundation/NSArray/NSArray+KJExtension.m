//
//  NSArray+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSArray+KJExtension.h"

@implementation NSArray (KJExtension)
- (bool)isEmpty{
    return (self == nil || [self isKindOfClass:[NSNull class]] || self.count == 0);
}
/// 数组计算交集
- (NSArray*)kj_arrayIntersectionWithOtherArray:(NSArray*)otherArray{
    if(self.count == 0 || otherArray == nil) return nil;
    NSMutableArray *temps = [NSMutableArray array];
    for (id obj in self) {
        if(![otherArray containsObject:obj]) continue;
        [temps addObject:obj];
    }
    return temps;
}
/// 数组计算差集
- (NSArray*)kj_arrayMinusWithOtherArray:(NSArray*)otherArray{
    if(self == nil) return nil;
    if(otherArray == nil) return self;
    NSMutableArray *temps = [NSMutableArray arrayWithArray:self];
    for (id obj in otherArray) {
        if(![self containsObject:obj]) continue;
        [temps removeObject:obj];
    }
    return temps;
}

@end
