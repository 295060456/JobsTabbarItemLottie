//
//  VC@1.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/13.
//  Copyright © 2020 xa. All rights reserved.
//

#import "VC@1.h"

@interface VC_1 ()

@end

@implementation VC_1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIViewController comingFromVC:self
                              toVC:VC_9.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationAutomatic
                     requestParams:@""
                           success:^(id data) {}
                          animated:YES];
}


@end
