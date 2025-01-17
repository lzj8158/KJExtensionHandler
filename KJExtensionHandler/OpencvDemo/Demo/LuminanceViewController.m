//
//  LuminanceViewController.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/3/20.
//  https://github.com/yangKJ/KJExtensionHandler


#import "LuminanceViewController.h"

@interface LuminanceViewController ()

@end

@implementation LuminanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.orignalImageView.image = [UIImage imageNamed:@"banana"];
    self.slider.value = 0;
    self.slider2.value = 0.5;
    _weakself;
    weakself.imageView.image = [weakself.orignalImageView.image kj_opencvChangeContrast:0 luminance:1];
    self.kButtonAction = ^{
        weakself.imageView.image = [weakself.orignalImageView.image kj_opencvChangeContrast:0 luminance:1];
    };
    self.kSliderMoveEnd = ^(CGFloat value) {
        CGFloat x = 100 * value;
        CGFloat y = 2 * weakself.slider2.value;
        weakself.imageView.image = [weakself.orignalImageView.image kj_opencvChangeContrast:x luminance:y];
    };
    self.kSlider2MoveEnd = ^(CGFloat value) {
        CGFloat x = 100 * weakself.slider.value;
        CGFloat y = 2 * value;
        weakself.imageView.image = [weakself.orignalImageView.image kj_opencvChangeContrast:x luminance:y];
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
