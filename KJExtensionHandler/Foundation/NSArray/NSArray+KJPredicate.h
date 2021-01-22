//
//  NSArray+KJPredicate.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/16.
//  https://github.com/yangKJ/KJExtensionHandler
//  谓词工具

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
// bindings参数:替换变量字典，字典必须包含接收器中所有变量的键值对
typedef BOOL (^kPredicateBlock)(id evaluatedObject,NSDictionary<NSString*,id> *bindings);
@interface NSArray (KJPredicate)
/// 对比两个数组删除相同元素并合并
- (NSArray*)kj_mergeArrayAndDelEqualObjWithOtherArray:(NSArray*)temp;
/// 过滤数组
- (NSArray*)kj_filtrationDatasWithPredicateBlock:(kPredicateBlock)block;
/// 除去数组当中包含目标数组的数据
- (NSArray*)kj_delEqualDatasWithTargetTemps:(NSArray*)temp;
/// 按照某一属性的升序降序排列
- (NSArray*)kj_sortDescriptorWithKey:(NSString*)key Ascending:(BOOL)ascending;
/// 按照某些属性的升序降序排列
- (NSArray*)kj_sortDescriptorWithKeys:(NSArray*)keys Ascendings:(NSArray*)ascendings;
/// 匹配元素
- (NSArray*)kj_takeOutDatasWithKey:(NSString*)key Value:(NSString*)value;
/// 字符串比较运算符
- (NSArray*)kj_takeOutDatasWithOperator:(NSString*)ope Key:(NSString*)key Value:(NSString*)value;

@end

NS_ASSUME_NONNULL_END
