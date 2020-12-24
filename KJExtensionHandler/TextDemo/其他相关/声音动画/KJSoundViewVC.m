//
//  KJSoundViewVC.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/22.
//

#import "KJSoundViewVC.h"
#import "KJSoundView.h"
@interface KJSoundViewVC ()

@end

@implementation KJSoundViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat sp = (kScreenW-4*50)/5;
    
    UIButton *button = [UIButton kj_createButtonWithFontSize:15 Title:@"测试音量大小" TextColor:UIColor.orangeColor];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.centerX = kScreenW/2;
    button.centerY = kScreenH - 100;
    button.borderWidth = 1;
    button.borderColor = UIColor.orangeColor;
    [self.view addSubview:button];

    __block KJSoundView *view = [[KJSoundView alloc]initWithFrame:CGRectMake(sp, 64+20, 50, 100)];
    view.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.3];
    view.cornerRadius = 10;
    view.borderWidth = 1;
    view.borderColor = UIColor.orangeColor;
    view.value = 1000;
    [self.view addSubview:view];
    
    __block KJSoundView *view2 = [[KJSoundView alloc]initWithFrame:CGRectMake(sp+50+sp, 64+20, 50, 100)];
    view2.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.3];
    view2.cornerRadius = 10;
    view2.borderWidth = 1;
    view2.borderColor = UIColor.orangeColor;
    view2.value = 0;
    [self.view addSubview:view2];
    
    __block KJSoundView *view3 = [[KJSoundView alloc]initWithFrame:CGRectMake(sp+50+sp+50+sp, 64+20, 50, 100)];
    view3.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.3];
    view3.cornerRadius = 10;
    view3.borderWidth = 1;
    view3.borderColor = UIColor.orangeColor;
    view3.value = -10;
    [self.view addSubview:view3];
    
    __block KJSoundView *view4 = [[KJSoundView alloc]initWithFrame:CGRectMake(sp+50+sp+50+sp+50+sp, 64+20, 50, 100)];
    view4.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.3];
    view4.cornerRadius = 10;
    view4.borderWidth = 1;
    view4.borderColor = UIColor.orangeColor;
    view4.value = 20;
    [self.view addSubview:view4];
    
    [button kj_addAction:^(UIButton * _Nonnull kButton) {
        [NSTimer kj_scheduledTimerWithTimeInterval:.2 Repeats:YES Block:^(NSTimer * _Nonnull timer) {
            view.value  = arc4random()%100;
            view2.value = arc4random()%100;
            view3.value = arc4random()%100;
            view4.value = arc4random()%100;
        }];
    }];
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
