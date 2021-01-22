//
//  NSString+KJChinese.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSString+KJChinese.h"

@implementation NSString (KJChinese)
/// 汉字转拼音
- (NSString*)pinYin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformMandarinLatin,  NO);//先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformStripDiacritics,NO);//再转换为不带声调的拼音
    return str;
}
/// 随机汉字
+ (NSString*)kj_randomCreateChinese:(NSInteger)count{
    NSMutableString *randomChineseString = @"".mutableCopy;
    for (NSInteger i = 0; i < count; i++) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc]initWithData:data encoding:gbkEncoding];
        [randomChineseString appendString:string];
    }
    return randomChineseString.mutableCopy;
}
/// 查找数据，返回-1表示未查询到
- (int)kj_searchArray:(NSArray<NSString*>*)temps{
    unsigned index = (unsigned)CFArrayBSearchValues((CFArrayRef)temps, CFRangeMake(0, temps.count), (CFStringRef)self, (CFComparatorFunction)CFStringCompare, NULL);
    if (index < temps.count && [self isEqualToString:temps[index]]){
        return index;
    }else{
        return -1;
    }
}
/// 字母排序
- (NSArray*)kj_letterSortArray:(NSArray<NSString*>*)array{
    return [array sortedArrayUsingSelector:@selector(compare:)];
}

@end
