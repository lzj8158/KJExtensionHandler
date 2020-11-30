//
//  KJNodeQueue.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/30.
//

#import "KJNodeQueue.h"

@implementation KJNodeQueue{
    NSMutableData *nodeCache;
    NSInteger _topNodeOffset, _freeNodeOffset;
    NSInteger _increments, _multiplier;
}
static const int8_t kFinallyNodeOffset = -1;
- (instancetype)copyWithZone:(NSZone*)zone{
    return [[KJNodeQueue allocWithZone:zone] init];
}
- (instancetype)init{
    return [self initWithCapacity:500 Increments:500 Multiplier:1000];
}
- (instancetype)initWithCapacity:(NSInteger)capacity Increments:(NSInteger)increments Multiplier:(NSInteger)multiplier{
    if (self == [super init]) {
        nodeCache = [NSMutableData dataWithLength:capacity * sizeof(KJPointNode)];
        _increments = increments;
        _multiplier = multiplier;
        _topNodeOffset = kFinallyNodeOffset;
        _freeNodeOffset = 0;
        [self initNodeWithCount:capacity];
    }
    return self;
}

- (void)kj_pushNodeWithX:(NSInteger)x PushY:(NSInteger)y {
    KJPointNode *node = [self nextFreeNode];
    node->value = x * _multiplier + y;
    node->nextNodeOffset = _topNodeOffset;
    _topNodeOffset = [self offsetOfNode:node];
}

- (bool)kj_popNodeWithX:(NSInteger*)x PopY:(NSInteger*)y{
    if (_topNodeOffset == kFinallyNodeOffset) return false;
    KJPointNode *topNode = [self nodeOfOffset:_topNodeOffset];
    NSInteger value = topNode->value;
    NSInteger nextNodeOffset = topNode->nextNodeOffset;
    topNode->value = 0;
    topNode->nextNodeOffset = _freeNodeOffset;
    _freeNodeOffset = _topNodeOffset;
    _topNodeOffset = nextNodeOffset;
    *x = value / _multiplier;
    *y = value % _multiplier;
    return value == INT_MIN ? false : true;
}

#pragma mark - Private
/// 初始化节点
- (void)initNodeWithCount:(NSInteger)count{
    KJPointNode *node = (KJPointNode*)nodeCache.mutableBytes + _freeNodeOffset;
    for (int i = 0; i < count - 1; i++) {
        node->value = 0;
        node->nextNodeOffset = _freeNodeOffset + i + 1;
        node ++;
    }
    node->value = 0;
    node->nextNodeOffset = kFinallyNodeOffset;
}

- (KJPointNode*)nodeOfOffset:(NSInteger)offset{
    return (KJPointNode*)nodeCache.mutableBytes + offset;
}
- (NSInteger)offsetOfNode:(KJPointNode*)node{
    return node - (KJPointNode*)nodeCache.mutableBytes;
}
- (KJPointNode*)nextFreeNode{
    if (_freeNodeOffset < 0) {
        [nodeCache increaseLengthBy:_increments * sizeof(KJPointNode)];
        _freeNodeOffset = _topNodeOffset + 1;
        [self initNodeWithCount:_increments];
    }
    KJPointNode *node = (KJPointNode*)nodeCache.mutableBytes + _freeNodeOffset;
    _freeNodeOffset = node->nextNodeOffset;
    return node;
}

@end
