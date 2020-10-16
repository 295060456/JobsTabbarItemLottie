//
//  TabbarVC.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "TabbarVC.h"
#import "TabbarVC+UIGestureRecognizerDelegate.h"
#import "ScrollTabBarDelegate.h"
#import "TLAnimationTabBar.h"

#import "LongPressGRView.h"

#import "AppDelegate.h"

TabbarVC *tabbarVC;

@interface TabbarVC ()
<
UITabBarControllerDelegate,
UIGestureRecognizerDelegate
>

@property(nonatomic,strong)UIPanGestureRecognizer *panGesture;
@property(nonatomic,assign)NSInteger subViewControllerCount;
@property(nonatomic,strong)ScrollTabBarDelegate *tabBarDelegate;
@property(nonatomic,strong)NSMutableArray <UIView *>*UITabBarButtonMutArr;//UITabBarButton 是内部类 直接获取不到，需要间接获取

@end

@implementation TabbarVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
        tabbarVC = self;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self scrollTabbar];//手势横向滚动子VC联动Tabbar切换
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self UISetting];//最高只能在viewWillAppear，在viewDidLoad不出效果 self.tabBar.subviews为空
    [self 添加长按手势];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myTabBar.height += self.myTabBar.offsetHeight;
    self.myTabBar.y = self.view.height - self.myTabBar.height;
    
    for (UITabBarItem *item in self.tabBar.items) {
        if ([item.title isEqualToString:@"首页"]) {
            [item pp_addBadgeWithText:@"99+"];
#pragma mark —— 动画
            [UIView animationAlert:item.badgeView];//图片从小放大
            shakerAnimation(item.badgeView, 2, 20);//重力弹跳动画效果
//            [UIView 视图上下一直来回跳动的动画:item.badgeView];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark —— 一些私有方法
-(void)UISetting{
    for (int i = 0; i < self.tabBarControllerConfigMutArr.count; i++) {
        TabBarControllerConfig *config = (TabBarControllerConfig *)self.tabBarControllerConfigMutArr[i];

        
        UIViewController *viewController = self.childMutArr[i];
        //
        [self addLottieImage:viewController
                 lottieImage:config.lottieName];
        
        viewController.title = config.title;
        viewController.tabBarItem = [[TabBarItem alloc] initWithConfig:config];
        
        viewController.view.backgroundColor = RandomColor;
        
        if (config.humpOffsetY != 0) {
            //一般的图片
            [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(-config.humpOffsetY,
                                                                       0,
                                                                       -config.humpOffsetY / 2,
                                                                       0)];//修改图片偏移量，上下，左右必须为相反数，否则图片会被压缩
            [viewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];//修改文字偏移量
        }

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.title = config.title;
        [self.childMutArr replaceObjectAtIndex:i withObject:nav];//替换元素，每个VC加Navigation
    }
#warning 这句话走了以后 才会有self.tabBar
    self.viewControllers = self.childMutArr;
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [UIView animationAlert:subView];//图片从小放大
            [self.UITabBarButtonMutArr addObject:subView];
        }
    }
    
    for (int i = 0; i < self.childMutArr.count; i++) {
        TabBarControllerConfig *config = (TabBarControllerConfig *)self.tabBarControllerConfigMutArr[i];
        if (![NSString isNullString:config.lottieName]) {
            [self.tabBar addLottieImage:i
                                offsetY:-config.humpOffsetY / 2
                             lottieName:config.lottieName];
        }
    }
    
    //初始显示
    if (self.firstUI_selectedIndex < self.viewControllers.count) {
        self.selectedIndex = self.firstUI_selectedIndex;//初始显示哪个
        [self lottieImagePlay:self.childMutArr[self.firstUI_selectedIndex]];
        [self.tabBar animationLottieImage:self.firstUI_selectedIndex];
    }
}

-(void)添加长按手势{

    for (UIView *subView in self.UITabBarButtonMutArr) {
        LongPressGRView *longPressGRView = LongPressGRView.new;
        longPressGRView.tag = [self.UITabBarButtonMutArr indexOfObject:subView];
        @weakify(self)
        [longPressGRView actionBlockLongPressGRView:^(LongPressGRView *data) {
            @strongify(self)
            [NSObject feedbackGenerator];//震动反馈
            [JobsPullListAutoSizeView initWithTargetView:self.UITabBarButtonMutArr[data.tag]
                                            imagesMutArr:nil
                                             titleMutArr:[NSMutableArray arrayWithObjects:@"qqq",@"24r",nil]];
        }];
        [subView addSubview:longPressGRView];
        [longPressGRView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(subView);
        }];
    }
}

-(void)addLottieImage:(UIViewController *)vc
          lottieImage:(NSString *)lottieImage{
    vc.view.backgroundColor = [UIColor lightGrayColor];

    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieImage];
    lottieView.frame = [UIScreen mainScreen].bounds;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.loopAnimation = YES;
    lottieView.tag = 100;
    [vc.view addSubview:lottieView];
}

-(void)lottieImagePlay:(UIViewController *)vc{
    LOTAnimationView *lottieView = (LOTAnimationView *)[vc.view viewWithTag:100];
    if (!lottieView ||
        ![lottieView isKindOfClass:LOTAnimationView.class]) {
        return;
    }
    lottieView.animationProgress = 0;
    [lottieView play];
}

-(void)scrollTabbar{
    if (!self.isOpenScrollTabbar) {
        // 正确的给予 count
        self.subViewControllerCount = self.viewControllers ? self.viewControllers.count : 0;
        // 代理
        self.tabBarDelegate = [[ScrollTabBarDelegate alloc] init];
        self.delegate = self.tabBarDelegate;
        self.panGesture.enabled = !self.isOpenScrollTabbar;
    }
}
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    [self lottieImagePlay:viewController];
    return YES;
}
#pragma mark —— UITabBarDelegate 监听TabBarItem点击事件
- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item {
    if ([self.tabBar.items containsObject:item]) {
        NSInteger index = [self.tabBar.items indexOfObject:item];
        [self.tabBar animationLottieImage:(int)index];
        [NSObject playSoundWithFileName:@"Sound.wav"];
        [NSObject feedbackGenerator];
        shakerAnimation(item.badgeView, 2, 20);//重力弹跳动画效果
        [item pp_increase];

        UIView *UITabBarButton = self.UITabBarButtonMutArr[index];
        [UIView animationAlert:UITabBarButton];//图片从小放大
    }
}
#pragma mark —— 手势调用方法
-(void)panHandle:(UIPanGestureRecognizer *)panGesture{
    // 获取滑动点
    CGFloat translationX = [panGesture translationInView:self.view].x;
    CGFloat progress = fabs(translationX)/self.view.frame.size.width;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.tabBarDelegate.interactive = YES;
            CGFloat velocityX = [panGesture velocityInView:self.view].x;
            if (velocityX < 0) {
                if (self.selectedIndex < self.subViewControllerCount - 1) {
                    self.selectedIndex += 1;
                }
            }else {
                if (self.selectedIndex > 0) {
                    self.selectedIndex -= 1;
                }
            }
        }break;
        case UIGestureRecognizerStateChanged:{
            [self.tabBarDelegate.interactionController updateInteractiveTransition:progress];
        }break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:{
            if (progress > 0.3) {
                self.tabBarDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarDelegate.interactionController finishInteractiveTransition];
            }else{
                //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
                self.tabBarDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarDelegate.interactionController cancelInteractiveTransition];
            }
            self.tabBarDelegate.interactive = NO;
        }break;
        default:
            break;
    }
}
/// 包装 viewController / 自定义样式UITabBarItem
/// @param viewController 被加工的VC
/// @param title 显示标题
/// @param imageSelected 选中状态的静态图
/// @param imageUnselected 未选中状态的静态图
/// @param humpOffsetY 凸起偏移量，传0就是不凸起
/// @param lottieName 只要不为空值则启用Lottie动画
/// @param tag tag值定位
UIViewController *childViewController_customStyle(UIViewController *viewController,
                                                  NSString *title,
                                                  UIImage *imageSelected,
                                                  UIImage *imageUnselected,
                                                  CGFloat humpOffsetY,//Y轴凸起的偏移量 传0就是不凸起
                                                  NSString *lottieName,//有值则用Lottie动画
                                                  NSUInteger tag){

    TabBarControllerConfig *config = TabBarControllerConfig.new;
    config.vc = viewController;
    config.title = title;
    config.imageSelected = imageSelected;
    config.imageUnselected = imageUnselected;
    config.humpOffsetY = humpOffsetY;
    config.lottieName = lottieName;
    config.tag = tag;
    
    [[AppDelegate sharedInstance].tabbarVC.tabBarControllerConfigMutArr addObject:config];
    
    setAnimation(viewController.tabBarItem, tag);
    return viewController;
}
#pragma mark —— lazyLoad
-(CustomTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[CustomTabBar alloc] initWithBgImg:nil];
        [self setValue:_myTabBar
                forKey:@"tabBar"];//KVC 进行替换
        _myTabBar.frame = self.tabBar.bounds;
    }return _myTabBar;
}

-(UIPanGestureRecognizer *)panGesture{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(panHandle:)];
        [self.view addGestureRecognizer:_panGesture];
    }return _panGesture;
}

-(NSMutableArray<UIView *> *)UITabBarButtonMutArr{
    if (!_UITabBarButtonMutArr) {
        _UITabBarButtonMutArr = NSMutableArray.array;
    }return _UITabBarButtonMutArr;
}

-(NSMutableArray<UIViewController *> *)childMutArr{
    if (!_childMutArr) {
        _childMutArr = NSMutableArray.array;
    }return _childMutArr;
}

/*  系统样式UITabBarItem
 *  UITabBarSystemItemMore,
 *  UITabBarSystemItemFavorites,
 *  UITabBarSystemItemFeatured,
 *  UITabBarSystemItemTopRated,
 *  UITabBarSystemItemRecents,
 *  UITabBarSystemItemContacts,
 *  UITabBarSystemItemHistory,
 *  UITabBarSystemItemBookmarks,
 *  UITabBarSystemItemSearch,
 *  UITabBarSystemItemDownloads,
 *  UITabBarSystemItemMostRecent,
 *  UITabBarSystemItemMostViewed,
 */

UIViewController *childViewController_SystemStyle(UIViewController *viewController,
                                                  UITabBarSystemItem systemItem,
                                                  NSUInteger tag){
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:systemItem
                                                                           tag:tag];
    setAnimation(viewController.tabBarItem, tag);
    return viewController;
}

// MARK: - 给UITabBarItem绑定动画
/// 给UITabBarItem绑定动画
void setAnimation(UITabBarItem *item,
                  NSInteger index) {
     item.animation = @[
                       bounceAnimation(),
                       rotationAnimation(),
                       transitionAniamtion(),
                       fumeAnimation(),
                       frameAnimation()
                       ][index];
}

// MARK: - 创建动画函数
TLBounceAnimation *bounceAnimation(){
    TLBounceAnimation *anm = TLBounceAnimation.new;
    anm.isPlayFireworksAnimation = YES;
    return anm;
}

TLRotationAnimation *rotationAnimation(){
    TLRotationAnimation *anm = TLRotationAnimation.new;
    return anm;
}

TLTransitionAniamtion *transitionAniamtion(){
    TLTransitionAniamtion *anm = TLTransitionAniamtion.new;
    anm.direction = 1; // 1~6
    anm.disableDeselectAnimation = NO;
    return anm;
}

TLFumeAnimation *fumeAnimation(){
    TLFumeAnimation *anm = TLFumeAnimation.new;
    return anm;
}

TLFrameAnimation *frameAnimation(){
    TLFrameAnimation *anm = TLFrameAnimation.new;
    anm.images = imgs();
    anm.isPlayFireworksAnimation = YES;
    return anm;
}

NSArray *imgs (){
    NSMutableArray *temp = NSMutableArray.array;
    for (NSInteger i = 28 ; i <= 65; i++) {
        NSString *imgName = [NSString stringWithFormat:@"Tools_000%zi", i];
        CGImageRef img = [UIImage imageNamed:imgName].CGImage;
        [temp addObject:(__bridge id _Nonnull)(img)];
    }return temp;
}

-(NSMutableArray<TabBarControllerConfig *> *)tabBarControllerConfigMutArr{
    if (!_tabBarControllerConfigMutArr) {
        _tabBarControllerConfigMutArr = NSMutableArray.array;
    }return _tabBarControllerConfigMutArr;
}

@end
