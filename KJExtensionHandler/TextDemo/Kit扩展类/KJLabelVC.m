//
//  KJLabelVC.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/11.
//

#import "KJLabelVC.h"

@interface KJLabelVC ()

@end

@implementation KJLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat x,y;
    CGFloat sp = kAutoW(10);
    CGFloat w = (kScreenW-sp*4)/3.;
    CGFloat h = w*9/16;
    NSArray *names = @[@"左边",@"右边",@"中间",@"左上",@"右上",@"左下",@"右下",@"中上",@"中下"];
    NSInteger types[9] = {
        KJLabelTextAlignmentTypeLeft,
        KJLabelTextAlignmentTypeRight,
        KJLabelTextAlignmentTypeCenter,
        KJLabelTextAlignmentTypeLeftTop,
        KJLabelTextAlignmentTypeRightTop,
        KJLabelTextAlignmentTypeLeftBottom,
        KJLabelTextAlignmentTypeRightBottom,
        KJLabelTextAlignmentTypeTopCenter,
        KJLabelTextAlignmentTypeBottomCenter
    };
    for (int k=0; k<names.count; k++) {
        x = k%3*(w+sp)+sp;
        y = k/3*(h+sp)+sp+kSTATUSBAR_NAVIGATION_HEIGHT+sp*2;
        UILabel *label = [UILabel kj_createLabel:^(id<KJLabelDelegate>  _Nonnull handle) {
            handle.kj_frame(x, y, w, h).kj_add(self.view);
            handle.kj_background([UIColor.orangeColor colorWithAlphaComponent:0.2]);
            handle.kj_text(names[k]).kj_font([UIFont systemFontOfSize:16]).kj_textColor(UIColor.orangeColor);
        }];
        label.customTextAlignment = types[k];
        label.borderWidth = 1;
        label.borderColor = UIColor.orangeColor;
    }
}

@end
