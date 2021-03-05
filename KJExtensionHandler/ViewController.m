//
//  ViewController.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/9/25.
//

#import "ViewController.h"
#import "KJHomeView.h"
#import "KJHomeModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //暗黑模式
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return UIColor.whiteColor;
            }else{
                return UIColor.blackColor;
            }
        }];
    }else{
        self.view.backgroundColor = UIColor.whiteColor;
    }
    
    self.navigationController.navigationBar.kj_changeNavigationBarImage([UIImage imageNamed:@"timg-2"]).kj_changeNavigationBarTitle(UIColor.whiteColor,[UIFont boldSystemFontOfSize:20]);
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    KJHomeModel *model = [KJHomeModel new];
    KJHomeView *view = [[KJHomeView alloc]initWithFrame:CGRectMake(0, 0, width, height-100-kBOTTOM_SPACE_HEIGHT)];
    view.sectionTemps = model.sectionTemps;
    view.temps = model.temps;
    [self.view addSubview:view];
    
    _weakself;
    [view kj_receivedSemaphoreBlock:^id _Nullable(NSString * _Nonnull key, id _Nonnull message, id _Nullable parameter) {
        if ([key isEqualToString:kHomeViewKey]) {
            ((UIViewController*)message).title = ((NSDictionary*)parameter)[@"describeName"];
            [weakself.navigationController pushViewController:message animated:true];
        }
        return nil;
    }];
    
    self.navigationController.navigationBar.kj_changeNavigationBarImage([UIImage imageNamed:@"timg-2"]).kj_changeNavigationBarTitle(UIColor.whiteColor,[UIFont boldSystemFontOfSize:20]);
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(10, height-100-kBOTTOM_SPACE_HEIGHT, width-20, 100);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"大家觉得好用还请点个星，遇见什么问题也可issues，持续更新ing.." attributes:@{
        NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
        NSForegroundColorAttributeName:UIColor.redColor}];
    [button setAttributedTitle:attrStr forState:(UIControlStateNormal)];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = 1;
    [button addTarget:self action:@selector(kj_button) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}
- (void)kj_button{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/yangKJ/KJExtensionHandler"]];
#pragma clang diagnostic pop
}

@end
