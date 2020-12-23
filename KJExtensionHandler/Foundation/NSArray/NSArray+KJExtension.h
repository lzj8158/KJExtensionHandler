//
//  NSArray+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler
//  对数组里面元素的相关处理
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (KJExtension)
/// 是否为空
@property(nonatomic,assign,readonly)bool isEmpty;
/// 筛选数据
- (id)kj_detectArray:(BOOL(^)(id object, int index))block;
/// 多维数组筛选数据
- (id)kj_detectManyDimensionArray:(BOOL(^)(id object, BOOL * stop))recurse;
/// 查找数据，返回-1表示未查询到
- (int)kj_searchObject:(id)object;
/// 映射
- (NSArray*)kj_mapArray:(id(^)(id object))block;
/// 数组计算交集
- (NSArray*)kj_arrayIntersectionWithOtherArray:(NSArray*)otherArray;
/// 数组计算差集
- (NSArray*)kj_arrayMinusWithOtherArray:(NSArray*)otherArray;
/// 随机打乱数组
- (NSArray*)kj_disorganizeArray;
/// 删除数组当中的相同元素
- (NSArray*)kj_delArrayEquelObj;
/// 生成一组不重复的随机数
- (NSArray*)kj_noRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger)max count:(NSInteger)count;
/// 二分查找，当数据量很大适宜采用该方法
- (NSInteger)kj_binarySearchTarget:(NSInteger)target;
/// 冒泡排序
- (NSArray*)kj_bubbleSort;
/// 插入排序
- (NSArray*)kj_insertSort;
/// 选择排序
- (NSArray*)kj_selectionSort;

@end

NS_ASSUME_NONNULL_END
