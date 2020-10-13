//
//  TabbarVC.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import <Lottie/Lottie.h>

#import "TabbarVC.h"
#import "CustomTabBar.h"
#import "UITabBar+Ex.h"

#import "VC@1.h"
#import "VC@2.h"
#import "VC@3.h"

@interface TabbarVC () <UITabBarControllerDelegate>

@property(nonatomic,strong)CustomTabBar *myTabBar;

@property(nonatomic,strong)NSMutableArray <NSString *>*lottieImageMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*tabLottieMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*imagesMutArr;

@end

@implementation TabbarVC

-(instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                                             forState:UIControlStateSelected];
    self.tabBar.backgroundColor = UIColor.whiteColor;
    self.tabBar.barStyle = UIBarStyleBlack;

    [self UISetting];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGRect frame = self.tabBar.frame;
    frame.size.height += 5;
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    self.tabBar.frame = frame;

//    for (UITabBarItem *item in self.tabBar.items) {
//        if ([item.title isEqualToString:@"直播"]) {
//
//        }
//    }

//    for (UIView *subView in self.tabBar.subviews) {
//        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//        }
//    }
}

- (void)UISetting{
    
    self.myTabBar.alpha = 1;// 更换tabBar
    
    NSMutableArray *mArr = NSMutableArray.array;
    for (int i = 0 ; i < self.childMutArr.count; i++){

        NSString *imageSelected = [NSString stringWithFormat:@"%@_selected",self.imagesMutArr[i]];
        NSString *imageUnselected = [NSString stringWithFormat:@"%@_unselected",self.imagesMutArr[i]];
        
        UIViewController *vc = self.childMutArr[i];
        
        [self addLottieImage:vc
                 lottieImage:self.lottieImageMutArr[i]];

        [vc setTitle:self.titleMutArr[i]];
        vc.tabBarItem.image = [[UIImage imageNamed:imageUnselected]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelected]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        if (i == 1) {
            [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(-30, 0, 15, 0)];//修改图片偏移量，上下，左右必须为相反数，否则图片会被压缩
            [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -30)];//修改文字偏移量
        }
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.title = self.titleMutArr[i];
        [mArr addObject:nav];
    }
    
    self.viewControllers = mArr;
    
    for (int d = 0; d < self.childMutArr.count; d++) {
        [self.tabBar addLottieImage:d
                         lottieName:self.tabLottieMutArr[d]];
    }
    //初始显示
    if (self.firstUI_selectedIndex < self.viewControllers.count) {
        self.selectedIndex = self.firstUI_selectedIndex;//初始显示哪个
        [self lottieImagePlay:self.childMutArr[self.firstUI_selectedIndex]];
        [self.tabBar animationLottieImage:self.firstUI_selectedIndex];
    }
}


- (void)addLottieImage:(UIViewController *)vc
           lottieImage:(NSString *)lottieImage {
    vc.view.backgroundColor = [UIColor lightGrayColor];

    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieImage];
    lottieView.frame = [UIScreen mainScreen].bounds;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.loopAnimation = YES;
    lottieView.tag = 100;
    [vc.view addSubview:lottieView];
}

- (void)lottieImagePlay:(UIViewController *)vc {
    LOTAnimationView *lottieView = (LOTAnimationView *)[vc.view viewWithTag:100];
    
    if (!lottieView ||
        ![lottieView isKindOfClass:LOTAnimationView.class]) {
        return;
    }
    
    lottieView.animationProgress = 0;
    [lottieView play];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    [self lottieImagePlay:viewController];
    return YES;
}
//点击事件
- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item {
    if ([self.tabBar.items containsObject:item]) {
        NSInteger index = [self.tabBar.items indexOfObject:item];
        [self.tabBar animationLottieImage:(int)index];
    }
}
#pragma mark —— lazyLoad
-(CustomTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = CustomTabBar.new;
//        _myTabBar.effectAreaY = -150;
        [self setValue:_myTabBar
                forKey:@"tabBar"];//KVC 进行替换
    }return _myTabBar;
}

-(NSMutableArray<NSString *> *)lottieImageMutArr{
    if (!_lottieImageMutArr) {
        _lottieImageMutArr = NSMutableArray.array;
        [_lottieImageMutArr addObject:@"home_priase_animation"];
        [_lottieImageMutArr addObject:@"music_animation"];
        [_lottieImageMutArr addObject:@"record_change"];
    }return _lottieImageMutArr;
}

-(NSMutableArray<NSString *> *)tabLottieMutArr{
    if (!_tabLottieMutArr) {
        _tabLottieMutArr = NSMutableArray.array;
        [_tabLottieMutArr addObject:@"tab_home_animate"];
        [_tabLottieMutArr addObject:@"tab_search_animate"];
        [_tabLottieMutArr addObject:@"tab_message_animate"];
    }return _tabLottieMutArr;
}

-(NSMutableArray<UIViewController *> *)childMutArr{
    if (!_childMutArr) {
        _childMutArr = NSMutableArray.array;
        [_childMutArr addObject:VC_1.new];
        [_childMutArr addObject:VC_2.new];
        [_childMutArr addObject:VC_3.new];
    }return _childMutArr;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"首页"];
        [_titleMutArr addObject:@"精彩生活"];
        [_titleMutArr addObject:@"发现"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)imagesMutArr{
    if (!_imagesMutArr) {
        _imagesMutArr = NSMutableArray.array;
        [_imagesMutArr addObject:@"community"];
        [_imagesMutArr addObject:@"post"];
        [_imagesMutArr addObject:@"My"];
    }return _imagesMutArr;
}

@end
