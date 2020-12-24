//
//  KJSoundView.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/22.
//  https://github.com/yangKJ/KJExtensionHandler

#import "KJSoundView.h"

@interface KJSoundView()

@end
@implementation KJSoundView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        self.minValue = 0;
        self.maxValue = 100;
        self.soundColor = UIColorFromHEXA(0x29D652, 1);
        self.soundBackColor = UIColor.whiteColor;
    }
    return self;
}
- (void)setValue:(CGFloat)value{
    value  = self.minValue<=value?value:self.minValue;
    _value = self.maxValue<=value?self.maxValue:value;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat width = self.width,height = self.height;
    CGFloat halfwidth = self.width/2;
    CGFloat line = (int)width >> 4;
    CGContextSetLineWidth(context, line);
    [self.soundBackColor set];
    CGContextAddArc(context, halfwidth, height/5*3, halfwidth-line, 0, M_PI, 0);
    CGContextMoveToPoint(context, halfwidth, height/5*3+halfwidth-line);
    CGContextAddLineToPoint(context, halfwidth, height-line/2);
    CGContextMoveToPoint(context, width/4, height-line);
    CGContextAddLineToPoint(context, width/4*3, height-line);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, halfwidth, halfwidth, width/4, 0, M_PI, 1);
    CGContextAddArc(context, halfwidth, height/5*3, width/4, M_PI, 0, 1);
    CGContextMoveToPoint(context, width/4*3, halfwidth);
    CGContextAddLineToPoint(context, width/4*3, height-width/4*3);
    [self.soundColor set];
    CGContextFillPath(context);
    
    CGFloat max = self.maxValue - self.minValue;
    CGFloat ch = (height/5*3-halfwidth) * (max-_value)/max;
     
    CGContextAddArc(context, halfwidth, halfwidth, width/4, 0, M_PI, 1);
    CGContextAddArc(context, halfwidth, halfwidth+ch, width/4, M_PI, 0, 1);
    CGContextMoveToPoint(context, width/4*3, halfwidth);
    CGContextAddLineToPoint(context, width/4*3, height-width/4*3);
    [self.soundBackColor set];
    CGContextFillPath(context);
}

@end
