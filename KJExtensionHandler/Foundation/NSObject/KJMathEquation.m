//
//  KJMathEquation.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "KJMathEquation.h"

@implementation KJMathEquation
+ (CGFloat)kj_degreeFromRadian:(CGFloat)radian {
    return ((radian) * (180.0 / M_PI));
}
+ (CGFloat)kj_radianFromDegree:(CGFloat)degree {
    return ((degree) * M_PI / 180.f);
}
+ (CGFloat)kj_radianValueFromTanSideA:(CGFloat)sideA sideB:(CGFloat)sideB {
    return atan2f(sideA, sideB);
}
+ (CGSize)kj_resetFromSize:(CGSize)size FixedWidth:(CGFloat)width {
    CGFloat newHeight = size.height * (width / size.width);
    CGSize  newSize   = CGSizeMake(width, newHeight);
    return newSize;
}
+ (CGSize)kj_resetFromSize:(CGSize)size FixedHeight:(CGFloat)height {
    float  newWidth = size.width * (height / size.height);
    CGSize newSize  = CGSizeMake(newWidth, height);
    return newSize;
}
#pragma mark - Calculate once linear equation (Y = kX + b)
+ (KJLinearEquation)kj_mathOnceLinearEquationWithPointA:(CGPoint)pointA PointB:(CGPoint)pointB{
    CGFloat x1 = pointA.x; CGFloat y1 = pointA.y;
    CGFloat x2 = pointB.x; CGFloat y2 = pointB.y;
    CGFloat k = x1 == x2 ? 0 : (y2 - y1) / (x2 - x1);
    CGFloat b = x1 == x2 ? 0 : (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
    return (KJLinearEquation){k,b};
}
/// 已知y，k，b 求 x
+ (CGFloat)kj_xValueWithY:(CGFloat)yValue LinearEquation:(KJLinearEquation)kb{
    if (kb.k == 0) return 0;
    return (yValue - kb.b) / kb.k;
}
/// 已知x，k，b 求 y
+ (CGFloat)kj_yValueWithX:(CGFloat)xValue LinearEquation:(KJLinearEquation)kb{
    return kb.k * xValue + kb.b;
}

@end
