//
//  UITabBarButton.h
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarButton : UIView<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按

@end

NS_ASSUME_NONNULL_END
