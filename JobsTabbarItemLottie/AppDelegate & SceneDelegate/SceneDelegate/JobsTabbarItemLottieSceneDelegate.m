//
//  JobsTabbarItemLottieSceneDelegate.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//

#import "JobsTabbarItemLottieSceneDelegate.h"
#import "JobsTabbarItemLottieAppDelegate.h"

API_AVAILABLE(ios(13.0))
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

JobsTabbarItemLottieSceneDelegate *sceneDelegate;
@interface JobsTabbarItemLottieSceneDelegate ()

@end

@implementation JobsTabbarItemLottieSceneDelegate

-(instancetype)init{
    if (self = [super init]) {
        sceneDelegate = self;
    }return self;
}

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions {
    //在这里手动创建新的window
    if (@available(iOS 13.0, *)) {
        self.windowScene = (UIWindowScene *)scene;
        self.window.alpha = 1;
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"---applicationDidBecomeActive----");//进入前台
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"---applicationDidEnterBackground----"); //进入后台
    [(JobsTabbarItemLottieAppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}
#pragma mark —— lazyLoad
-(UIWindow *)window{
    [_window setRootViewController:JobsTabbarItemLottieAppDelegate.sharedInstance.tabBarVC];
    [_window makeKeyAndVisible];
    return _window;
}

@end

#pragma clang diagnostic pop
