//
//  NSString+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSString+KJExtension.h"

@implementation NSString (KJExtension)
/// 是否为空
- (bool)isEmpty{
    if (self == nil || self == NULL || [self isKindOfClass:[NSNull class]] || [self length] == 0 || [self isEqualToString: @"(null)"]) {
        return true;
    }
    return false;
}
/// 转换为URL
- (NSURL*)URL{ return [NSURL URLWithString:self];}
/// 获取图片
- (UIImage*)image{ return [UIImage imageNamed:self];}
/// 取出HTML
- (NSString*)HTMLString{
    if (self == nil) return nil;
    NSString *html = self;
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd] == NO){
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
/// Josn字符串转字典
- (NSDictionary*)jsonDict{
    if (self == nil) return nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return nil;
    return dic;
}
/// 生成竖直文字
- (NSString*)verticalText{
    NSMutableString *text = [[NSMutableString alloc] initWithString:self];
    NSInteger count = text.length;
    for (int i = 1; i < count; i ++) {
        [text insertString:@"\n" atIndex:i*2-1];
    }
    return text;
}
/// 获取文本宽度
- (CGFloat)kj_maxWidthWithFont:(UIFont*)font Height:(CGFloat)height Alignment:(NSTextAlignment)alignment LinebreakMode:(NSLineBreakMode)linebreakMode LineSpace:(CGFloat)lineSpace{
    return [self kj_sizeWithFont:font Size:CGSizeMake(CGFLOAT_MAX, height) Alignment:alignment LinebreakMode:linebreakMode LineSpace:lineSpace].width;
}
/// 获取文本高度
- (CGFloat)kj_maxHeightWithFont:(UIFont*)font Width:(CGFloat)width Alignment:(NSTextAlignment)alignment LinebreakMode:(NSLineBreakMode)linebreakMode LineSpace:(CGFloat)lineSpace{
    return [self kj_sizeWithFont:font Size:CGSizeMake(width, CGFLOAT_MAX) Alignment:alignment LinebreakMode:linebreakMode LineSpace:lineSpace].height;
}
- (CGSize)kj_sizeWithFont:(UIFont*)font Size:(CGSize)size Alignment:(NSTextAlignment)alignment LinebreakMode:(NSLineBreakMode)linebreakMode LineSpace:(CGFloat)lineSpace{
    if (self.length == 0) return CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = linebreakMode;
    paragraphStyle.alignment = alignment;
    if (lineSpace > 0) paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    CGSize newSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:NULL].size;
    return CGSizeMake(ceil(newSize.width), ceil(newSize.height));
}
/// 文字转图片
- (UIImage*)kj_textBecomeImageWithSize:(CGSize)size BackgroundColor:(UIColor*)color TextAttributes:(NSDictionary*)attributes{
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, bounds);
    CGSize textSize = [self sizeWithAttributes:attributes];
    [self drawInRect:CGRectMake(bounds.size.width/2-textSize.width/2, bounds.size.height/2-textSize.height/2, textSize.width, textSize.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
