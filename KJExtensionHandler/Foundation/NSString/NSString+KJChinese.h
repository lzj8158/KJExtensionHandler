//
//  NSString+KJChinese.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler
//  汉字相关处理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJChinese)
/// 汉字转拼音
@property(nonatomic,strong,readonly)NSString *pinYin;
/// 随机汉字
+ (NSString*)kj_randomCreateChinese:(NSInteger)count;
/// 查找数据，返回-1表示未查询到
- (int)kj_searchArray:(NSArray<NSString*>*)temps;
/// 字母排序
- (NSArray*)kj_letterSortArray:(NSArray<NSString*>*)array;

@end

NS_ASSUME_NONNULL_END
