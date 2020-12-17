//
//  KJMathEquation.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  数学算法方程式

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJMathEquation : NSObject
/// 把弧度转换成角度
+ (CGFloat)kj_degreeFromRadian:(CGFloat)radian;
/// 把角度转换成弧度
+ (CGFloat)kj_radianFromDegree:(CGFloat)degree;
/// 正切函数的弧度值，tan
+ (CGFloat)kj_radianValueFromTanSideA:(CGFloat)sideA sideB:(CGFloat)sideB;
/// 获取具有固定宽度的新size
+ (CGSize)kj_resetFromSize:(CGSize)size FixedWidth:(CGFloat)width;
/// 获取具有固定高度的新size
+ (CGSize)kj_resetFromSize:(CGSize)size FixedHeight:(CGFloat)height;

#pragma mark - 一元一次线性方程 (Y = kX + b).
/// 一元一次线性方程，求k，b
typedef struct KJLinearEquation{ CGFloat k;CGFloat b; }KJLinearEquation;
+ (KJLinearEquation)kj_mathOnceLinearEquationWithPointA:(CGPoint)pointA PointB:(CGPoint)pointB;
/// 已知y，k，b 求 x
+ (CGFloat)kj_xValueWithY:(CGFloat)yValue LinearEquation:(KJLinearEquation)kb;
/// 已知x，k，b 求 y
+ (CGFloat)kj_yValueWithX:(CGFloat)xValue LinearEquation:(KJLinearEquation)kb;

@end

NS_ASSUME_NONNULL_END
