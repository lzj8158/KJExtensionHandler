//
//  KJRenderImageVC.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/4.
//

#import "KJRenderImageVC.h"
#import "KJRenderImageView.h"
@interface KJRenderImageVC ()

@end

@implementation KJRenderImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _weakself;
    CGFloat sp = kAutoW(10);
    CGFloat w = (kScreenW-sp*3)/2;
    CGFloat h = w;
    CGFloat maxY = kSTATUSBAR_NAVIGATION_HEIGHT;
    UIImage *image = kGetImage(@"IMG_4931");
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(sp, maxY+sp, w, h)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.1];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    __block NSArray <KJRenderInfo*>*renderTemps = @[({
        KJRenderInfo *info = [KJRenderInfo new];
        info.type = KJRenderFilterTypeOriginal;
        info.opacity = 1.;
        info;
    }),({
        KJRenderInfo *info = [KJRenderInfo new];
        info.type = KJRenderFilterTypeCoreImage;
        info.coreType = KJRenderCoreImageFilterTypeSepia;
        info.extend = .8;
        info.opacity = 1.;
        info;
    }),({
        KJRenderInfo *info = [KJRenderInfo new];
        info.type = KJRenderFilterTypeSketch;
        info.extend = .8;
        info.opacity = 1.;
        info;
    }),({
        KJRenderInfo *info = [KJRenderInfo new];
        info.type = KJRenderFilterTypeColor;
        info.extend = .8;
        info.color = [UIColor.greenColor colorWithAlphaComponent:0.1];
        info;
    })];
    
    KJRenderImageView *view = ({
        KJRenderImageView *renderImageView = [[KJRenderImageView alloc] kj_initWithOriImage:image ExtendParameterBlock:^(KJRenderImageView * _Nonnull obj) {
            obj.kAddView(weakself.view).kFrame(CGRectMake(sp+imageView.maxX, imageView.top, w, h));
        }];
        renderImageView.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.1];
        [renderImageView kj_changeRenderInfo:renderTemps[1]];
        renderImageView;
    });
    
    KJRenderImageView *view2 = ({
        KJRenderImageView *renderImageView = [[KJRenderImageView alloc] kj_initWithOriImage:image ExtendParameterBlock:^(KJRenderImageView * _Nonnull obj) {
            obj.kAddView(weakself.view).kFrame(CGRectMake(sp, view.bottom+sp, w, h));
        }];
        renderImageView.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.1];
        [renderImageView kj_changeRenderInfo:renderTemps[2]];
        renderImageView;
    });
    
    KJRenderImageView *renderImageView = [[KJRenderImageView alloc] kj_initWithOriImage:image ExtendParameterBlock:^(KJRenderImageView * _Nonnull obj) {
        obj.kAddView(weakself.view).kFrame(CGRectMake(sp+view2.maxX, view.bottom+sp, w, h));
    }];
    renderImageView.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.1];
    [renderImageView kj_changeRenderInfo:renderTemps[3]];
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
