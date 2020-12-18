//
//  NSDate+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/18.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSDate+KJExtension.h"

@implementation NSDate (KJExtension)
+ (NSInteger)dateYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return components.year;
}
+ (NSInteger)dateMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:[NSDate date]];
    return components.month;
}
+ (NSInteger)dateDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:[NSDate date]];
    return components.day;
}

@end
