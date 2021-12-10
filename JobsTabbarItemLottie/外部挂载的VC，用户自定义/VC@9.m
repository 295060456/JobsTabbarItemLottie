//
//  VC@9.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//  Copyright © 2020 xa. All rights reserved.
//

#import "VC@9.h"

@interface VC_9 ()

@end

@implementation VC_9

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (instancetype)init{
    if (self = [super init]) {
//        @weakify(self)
        PrintRetainCount(self);
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    
    self.isHiddenNavigationBar = NO;//这一句决定是否有navigationbar
    PrintRetainCount(self);
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    PrintRetainCount(self);
}


@end
