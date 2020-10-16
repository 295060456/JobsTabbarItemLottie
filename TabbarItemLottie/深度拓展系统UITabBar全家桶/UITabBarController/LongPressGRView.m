//
//  LongPressGRView.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/16.
//

#import "LongPressGRView.h"

@interface LongPressGRView ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;
@property(nonatomic,copy)MKDataBlock longPressGRViewBlock;

@end

@implementation LongPressGRView

- (instancetype)init{
    if (self = [super init]) {
        self.longPressGR.enabled = YES;
        self.backgroundColor = [UIColor grayColor];
    }return self;
}

-(void)actionBlockLongPressGRView:(MKDataBlock)longPressGRViewBlock{
    self.longPressGRViewBlock = longPressGRViewBlock;
}

-(void)LZBTabBarItemLongPress:(UILongPressGestureRecognizer *)longPressGR{
    NSLog(@"UIGestureRecognizerState = %ld",(long)longPressGR.state);
    switch (longPressGR.state) {
        case UIGestureRecognizerStatePossible:{
            NSLog(@"没有触摸事件发生，所有手势识别的默认状态");
        }break;
        case UIGestureRecognizerStateBegan:{
            //长按手势
//            NSInteger currentIndex = [self.UITabBarButtonMutArr indexOfObject:longPressGR.view];
//            NSLog(@"一个手势已经开始 但尚未改变或者完成时，当前长按点击序号：%ld",currentIndex);//长按手势的锚点

            
            if (self.longPressGRViewBlock) {
                self.longPressGRViewBlock(self);
            }
        }break;
        case UIGestureRecognizerStateChanged:{
            NSLog(@"手势状态改变");
        }break;
        case UIGestureRecognizerStateEnded:{// = UIGestureRecognizerStateRecognized
            NSLog(@"手势完成");
        }break;
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"手势取消，恢复至Possible状态");
        }break;
        case UIGestureRecognizerStateFailed:{
            NSLog(@"手势失败，恢复至Possible状态");
        }break;
        default:
            break;
    }
}

// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
// API_AVAILABLE(ios(7.0));
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    NSLog(@"2");
    return YES;
}
// API_AVAILABLE(ios(7.0));
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch{
    NSLog(@"1");
    return YES;
}
// called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceivePress:(UIPress *)press{
    return YES;
}
// called once before either -gestureRecognizer:shouldReceiveTouch: or -gestureRecognizer:shouldReceivePress:
// return NO to prevent the gesture recognizer from seeing this event
//API_AVAILABLE(ios(13.4), tvos(13.4)) API_UNAVAILABLE(watchos);
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveEvent:(UIEvent *)event{
    return YES;
}
#pragma mark —— lazyLoad
-(UILongPressGestureRecognizer *)longPressGR{
    if (!_longPressGR) {
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
        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(LZBTabBarItemLongPress:)];
        _longPressGR.delegate = self;

        _longPressGR.numberOfTouchesRequired = 1;//手指数
        _longPressGR.minimumPressDuration = 1;
        //        longPressGR.allowableMovement;

        [self addGestureRecognizer:_longPressGR];
    }return _longPressGR;
}

@end
