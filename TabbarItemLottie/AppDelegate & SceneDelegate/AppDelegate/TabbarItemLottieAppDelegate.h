//
//  TabbarItemLottieAppDelegate.h
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TabbarVC.h"

@interface TabbarItemLottieAppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在
@property(nonatomic,strong)TabbarVC *tabBarVC;

- (void)saveContext;
+(instancetype)sharedInstance;

@end

