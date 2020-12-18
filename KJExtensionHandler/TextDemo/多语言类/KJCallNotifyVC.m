//
//  KJCallNotifyVC.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/16.
//

#import "KJCallNotifyVC.h"
#import "KJCallNotifyView.h"
@interface KJCallNotifyVC ()

@end

@implementation KJCallNotifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton kj_createButtonWithFontSize:15 Title:@"测试来电" TextColor:UIColor.orangeColor];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.centerX = kScreenW/2;
    button.centerY = kScreenH - 100;
    button.borderWidth = 1;
    button.borderColor = UIColor.orangeColor;
    [self.view addSubview:button];
    
//    __block KJCallNotifyView *view = [[KJCallNotifyView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64)];
//    [self.view addSubview:view];
//    view.maxCount = 5;
//    view.vanishTime = 5;
//    view.repetition = YES;
//    [view kj_tapBlock:^(KJCallNotifyInfo * _Nonnull info) {
//        NSLog(@"-----%@",info);
//    }];
    
    __block NSInteger index = 520;
    NSArray *names = @[@"Sone",@"痛苦的信仰",@"X",@"yang"];
    [button kj_addAction:^(UIButton * _Nonnull kButton) {
        [[KJCallNotifyView kj_shareInstance] kj_addCallNotify:^(KJCallNotifyInfo * _Nonnull info) {
            info.imageUrl = @"xxsf";
            info.userid = [NSString stringWithFormat:@"%ld",index++];
            info.name = names[index%4];
        } RepetitionCondition:^bool(KJCallNotifyInfo * _Nonnull info) {
            if ([info.name isEqualToString:names[index%4]]) {
                return true;
            }
            return false;
        }];
//        [view kj_addCallNotify:^(KJCallNotifyInfo * _Nonnull info) {
//            info.imageUrl = @"IMG_4931";
//            info.userid = @"userid";
//            info.name = @"Like You";
//        } RepetitionCondition:nil];
    }];
    [KJCallNotifyView kj_shareInstance].maxCount = 5;
    [KJCallNotifyView kj_shareInstance].vanishTime = 2;
    [KJCallNotifyView kj_shareInstance].tapVanish = YES;
    [[KJCallNotifyView kj_shareInstance] kj_tapBlock:^(KJCallNotifyInfo * _Nonnull info) {
        NSLog(@"-----%@",info);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
