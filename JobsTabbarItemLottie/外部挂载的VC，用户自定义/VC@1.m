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

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCyanColor;//RandomColor;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


@end
