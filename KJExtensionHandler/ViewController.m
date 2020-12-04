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
    
    KJHomeModel *model = [KJHomeModel new];
    KJHomeView *view = [[KJHomeView alloc]initWithFrame:self.view.bounds];
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
}

//- (UIView*)statusBarView{
//    UIView *statusBar = nil;
//    NSData *data = [NSData dataWithBytes:(unsigned char[]){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
//    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//    id object = [UIApplication sharedApplication];
//    if ([object respondsToSelector:NSSelectorFromString(key)]) {
//        statusBar = [object valueForKey:key];
//    }
//    return statusBar;
//}

@end
