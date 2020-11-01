//
//  VC@1.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/13.
//  Copyright © 2020 xa. All rights reserved.
//

#import "VC@1.h"

typedef enum : NSUInteger {
    ShadowDirection_top = 0,
    ShadowDirection_down,
    ShadowDirection_left,
    ShadowDirection_right,
    ShadowDirection_leftTop,
    ShadowDirection_leftDown,
    ShadowDirection_rightTop,
    ShadowDirection_rightDown,
    ShadowDirection_All
} ShadowDirection;


@interface VC_1 ()

@end

@implementation VC_1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCyanColor;//RandomColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"");
    self.view.backgroundColor  = kWhiteColor;
    UIView *ff = UIView.new;
    ff.backgroundColor = kRedColor;
    [self.view addSubview:ff];
    [ff mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.left.equalTo(self.view).offset(100);
    }];

    
    
[VC_1 makeTargetShadowview:ff
                 superView:self.view
           shadowDirection:ShadowDirection_leftTop
         shadowWithOffsetX:0
                   offsetY:0
              cornerRadius:8
              shadowOffset:CGSizeZero
             shadowOpacity:1
          layerShadowColor:kBlueColor
         layerShadowRadius:0];
    
//    [UIView cornerCutToCircleWithView:ff AndCornerRadius:8];
    

    
}


/// iOS 阴影效果 添加了shadowPath后消除了离屏渲染问题
/// @param targetShadowview 需要作用阴影效果的View
/// @param superview 该阴影效果的View的父View
/// @param ShadowDirection 阴影朝向
/// @param offsetX 贝塞尔曲线X轴偏移量
/// @param offsetY 贝塞尔曲线Y轴偏移量
/// @param cornerRadius 圆切角参数，传0表示不切
/// @param shadowOffset  阴影偏移量
/// @param shadowOpacity 阴影的不透明度,取值范围在0~1
/// @param layerShadowColor 阴影颜色
/// @param layerShadowRadius  模糊计算的半径
+(void)makeTargetShadowview:(UIView *)targetShadowview
                  superView:(UIView *)superview
            shadowDirection:(ShadowDirection)ShadowDirection
          shadowWithOffsetX:(CGFloat)offsetX
                    offsetY:(CGFloat)offsetY
               cornerRadius:(CGFloat)cornerRadius
               shadowOffset:(CGSize)shadowOffset
              shadowOpacity:(CGFloat)shadowOpacity
           layerShadowColor:(UIColor *__nullable)layerShadowColor
          layerShadowRadius:(CGFloat)layerShadowRadius{
    
    targetShadowview.layer.cornerRadius = cornerRadius;//圆切角
    
    if (CGRectEqualToRect(targetShadowview.frame,CGRectZero)) {
        [superview layoutIfNeeded];//targetShadowview当在某些masonry约束的时候，没有frame,需要进行刷新得到frame，否则不会出现阴影效果
    }
    
    targetShadowview.layer.shadowOpacity = (shadowOpacity != 0) ? : 0.7f;//shadowOpacity设置了阴影的不透明度,取值范围在0~1;
    targetShadowview.layer.shadowOffset = shadowOffset;//阴影偏移量
    targetShadowview.layer.shadowColor = (layerShadowColor ? :KDarkGrayColor).CGColor;//阴影颜色   KLightGrayColor.CGColor;
    targetShadowview.layer.shadowRadius = (layerShadowRadius != 0) ? : 8.0f;//模糊计算的半径
    
    UIBezierPath *path = UIBezierPath.bezierPath;

    //偏移量保持为正数，便于后续计算
    offsetX = offsetX >= 0 ? offsetX : -offsetX;
    offsetY = offsetY >= 0 ? offsetY : -offsetY;
    //偏移量默认值
    offsetX = offsetX != 0 ? :20;
    offsetY = offsetY != 0 ? :20;

    switch (ShadowDirection) {
        case ShadowDirection_top:{
            [path moveToPoint:CGPointMake(0, -offsetY)];//左上角为绘制的贝塞尔曲线原点
            [path addLineToPoint:CGPointMake(0, targetShadowview.height)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width, targetShadowview.height)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width, -offsetY)];//👆
        }break;
        case ShadowDirection_down:{
            [path moveToPoint:CGPointMake(0, 0)];//左上角为绘制的贝塞尔曲线原点
            [path addLineToPoint:CGPointMake(0, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width, targetShadowview.height + offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width, 0)];//👆
        }break;
        case ShadowDirection_left:{
            [path moveToPoint:CGPointMake(offsetX, 0)];//左上角
            [path addLineToPoint:CGPointMake(offsetX, targetShadowview.height)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width, targetShadowview.height)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width, 0)];//👆
        }break;
        case ShadowDirection_right:{
            [path moveToPoint:CGPointMake(0, 0)];//左上角
            [path addLineToPoint:CGPointMake(0, targetShadowview.height)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, 0)];//👆
        }break;
        case ShadowDirection_leftTop:{
            [path moveToPoint:CGPointMake(-offsetX, -offsetY)];//左上角
            [path addLineToPoint:CGPointMake(-offsetX, targetShadowview.height - offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, targetShadowview.height - offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, -offsetY)];//👆
        }break;
        case ShadowDirection_leftDown:{
            [path moveToPoint:CGPointMake(-offsetX, offsetY)];//左上角
            [path addLineToPoint:CGPointMake(-offsetX, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, targetShadowview.height + offsetX)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, offsetY)];//👆
        }break;
        case ShadowDirection_rightTop:{
            [path moveToPoint:CGPointMake(offsetX, -offsetY)];//左上角
            [path addLineToPoint:CGPointMake(offsetX, targetShadowview.height - offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height - offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, -offsetY)];//👆
        }break;
        case ShadowDirection_rightDown:{
            [path moveToPoint:CGPointMake(offsetX, offsetY)];//左上角
            [path addLineToPoint:CGPointMake(offsetX, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height + offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, offsetY)];//👆
        }break;
        case ShadowDirection_All:{
            [path moveToPoint:CGPointMake(-offsetX, -offsetY)];//左上角
            [path addLineToPoint:CGPointMake(-offsetX, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height + offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, -offsetY)];//👆
        }break;
            
        default:
            break;
    }
    
    targetShadowview.layer.shadowPath = path.CGPath;
}

- (void)p_setupViewWithY3:(CGFloat)y {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, y, [UIScreen mainScreen].bounds.size.width - 60, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    view.layer.shadowOpacity = 1;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-5, 0)];
    [path addLineToPoint:CGPointMake(-5, view.frame.size.height)];
    [path addLineToPoint:CGPointMake(view.frame.size.width, view.frame.size.height)];
    [path addLineToPoint:CGPointMake(view.frame.size.width, 0)];
    view.layer.shadowPath = path.CGPath;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    return;
    [UIViewController comingFromVC:self
                              toVC:VC_9.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationAutomatic
                     requestParams:@""
                           success:^(id data) {}
                          animated:YES];
}


@end
