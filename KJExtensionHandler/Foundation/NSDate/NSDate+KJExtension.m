//
//  NSDate+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/16.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSDate+KJExtension.h"

@implementation NSDate (KJExtension)
/* 判断两个日期是否在同一周 */
- (BOOL)kj_sameDate:(NSDate*)date{
    if (fabs([self timeIntervalSinceDate:date]) >= 7 * 24 *3600){
        return NO;
    }
    NSCalendar *calender = [NSCalendar currentCalendar];
    calender.firstWeekday = 2;
    NSUInteger countSelf = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:self];
    NSUInteger countDate = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:date];
    return countSelf == countDate;
}

@end
