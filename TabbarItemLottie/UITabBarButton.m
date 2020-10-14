//
//  UITabBarButton.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//

#import "UITabBarButton.h"

@interface UITabBarButton ()

@end

@implementation UITabBarButton

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"");
}

-(UILongPressGestureRecognizer *)longPressGR{

    /*
     * 长按手势是连续的。
     当在指定的时间段（minimumPressDuration）
     按下允许的手指的数量（numberOfTouchesRequired）
     并且触摸不超过允许的移动范围（allowableMovement）时，
     手势开始（UIGestureRecognizerStateBegan）。
     手指移动时，手势识别器转换到“更改”状态，
     并且当任何手指抬起时手势识别器结束（UIGestureRecognizerStateEnded）。
     *
     */
    
    if (!_longPressGR) {
        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(LZBTabBarItemLongPress:)];
        _longPressGR.delegate = self;
        
        _longPressGR.numberOfTouchesRequired = 1;//手指数
        _longPressGR.minimumPressDuration = 1;
//        _longPressGR.allowableMovement;

        [self addGestureRecognizer:_longPressGR];
    }return _longPressGR;
}

-(void)LZBTabBarItemLongPress:(UILongPressGestureRecognizer *)longPressGR {
    switch (longPressGR.state) {
        case UIGestureRecognizerStatePossible:{
//            NSLog(@"没有触摸事件发生，所有手势识别的默认状态");
        }break;
        case UIGestureRecognizerStateBegan:{
            //长按手势
            NSLog(@"一个手势已经开始 但尚未改变或者完成时");
        }break;
        case UIGestureRecognizerStateChanged:{
//            NSLog(@"手势状态改变");
        }break;
        case UIGestureRecognizerStateEnded:{// = UIGestureRecognizerStateRecognized
//            NSLog(@"手势完成");
        }break;
        case UIGestureRecognizerStateCancelled:{
//            NSLog(@"手势取消，恢复至Possible状态");
        }break;
        case UIGestureRecognizerStateFailed:{
//            NSLog(@"手势失败，恢复至Possible状态");
        }break;
        default:
            break;
    }
}


@end
