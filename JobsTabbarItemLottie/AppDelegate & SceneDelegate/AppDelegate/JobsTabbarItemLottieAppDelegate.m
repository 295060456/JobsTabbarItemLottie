//
//  JobsTabbarItemLottieAppDelegate.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//

#import "JobsTabbarItemLottieAppDelegate.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

JobsTabbarItemLottieAppDelegate *appDelegate;
@interface JobsTabbarItemLottieAppDelegate ()

@end

@implementation JobsTabbarItemLottieAppDelegate

-(instancetype)init{
    if (self = [super init]) {
        appDelegate = self;
    }return self;
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (HDDeviceSystemVersion.floatValue < 13.0) {
        self.window.alpha = 1;
    }return YES;
}

//系统版本低于iOS13.0的设备
-(void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"---applicationDidEnterBackground----");//进入后台
}

//系统版本低于iOS13.0的设备
-(void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"---applicationDidBecomeActive----");//进入前台
}
#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)
connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
                                          sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentCloudKitContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"TabbarItemLottie"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription,
                                                                              NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}
#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
#pragma mark —— lazyLoad
//仅仅为了iOS 13 版本向下兼容而存在
-(UIWindow *)window{
    if (!_window) {
        _window = UIWindow.new;
        _window.frame = [UIScreen mainScreen].bounds;
        [_window setRootViewController:self.tabBarVC];
        [_window makeKeyAndVisible];
    }return _window;
}

-(TabbarVC *)tabBarVC{
    if (!_tabBarVC) {
        _tabBarVC = TabbarVC.new;
//        _tabbarVC.isOpenScrollTabbar = NO;
        _tabBarVC.myTabBar.offsetHeight = 5;
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(VC_1.new,
                                                                         @"首页",
                                                                         KIMG(@"community_selected"),
                                                                         KIMG(@"community_unselected"),
                                                                         0,
                                                                         @"home_priase_animation",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(VC_2.new,
                                                                         @"精彩生活",
                                                                         KIMG(@"post_selected"),
                                                                         KIMG(@"post_unselected"),
                                                                         30,
                                                                         @"music_animation",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(VC_3.new,
                                                                         @"发现",
                                                                         KIMG(@"My_selected"),
                                                                         KIMG(@"My_unselected"),
                                                                         0,
                                                                         @"record_change",
                                                                         1)];
    }return _tabBarVC;
}

@end

#pragma clang diagnostic pop
