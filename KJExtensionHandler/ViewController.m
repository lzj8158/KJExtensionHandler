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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.tabBarItem.selectedImage = [self.navigationController.tabBarItem.selectedImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
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
    KJHomeView *view = [[KJHomeView alloc]initWithFrame:CGRectMake(0, kSTATUSBAR_NAVIGATION_HEIGHT, width, height-kBOTTOM_SPACE_HEIGHT-kSTATUSBAR_NAVIGATION_HEIGHT)];
    view.sectionTemps = model.sectionTemps;
    view.temps = model.temps;
    [self.view addSubview:view];
    
    _weakself;
    [view kj_receivedSemaphoreBlock:^id _Nullable(NSString * _Nonnull key, id _Nonnull message, id _Nullable parameter) {
        if ([key isEqualToString:kHomeViewKey]) {
            ((UIViewController*)message).title = ((NSDictionary*)parameter)[@"describeName"];
            weakself.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:message animated:true];
        }
        return nil;
    }];
    
    self.navigationController.navigationBar.kj_changeNavigationBarImage([UIImage imageNamed:@"timg-2"]).kj_changeNavigationBarTitle(UIColor.whiteColor,[UIFont boldSystemFontOfSize:20]);
}

@end
