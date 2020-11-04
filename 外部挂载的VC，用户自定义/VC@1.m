//
//  VC@1.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/13.
//  Copyright © 2020 xa. All rights reserved.
//

#import "VC@1.h"
#import "UIButton+CountDownBtn.h"

@interface VC_1 ()

@property(nonatomic,strong)UIButton *midView_Style1;

@end

@implementation VC_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCyanColor;//RandomColor;
    self.midView_Style1.alpha = 1;
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

-(UIButton *)midView_Style1{
    if (!_midView_Style1) {
        _midView_Style1 = [[UIButton alloc] initWithType:CountDownBtnType_countDown
                                                          runType:CountDownBtnRunType_auto
                                                 layerBorderWidth:1
                                                layerCornerRadius:1
                                                 layerBorderColor:kClearColor
                                                       titleColor:kWhiteColor
                                                    titleBeginStr:@""
                                                   titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
        
        _midView_Style1.titleRuningStr = @"开始倒计时\n";
        _midView_Style1.showTimeType = ShowTimeType_HHMMSS;
        _midView_Style1.bgCountDownColor = kCyanColor;
        _midView_Style1.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;
        
        [_midView_Style1 timeFailBeginFrom:9999];

        [self.view addSubview:_midView_Style1];
        [_midView_Style1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 100));
            make.top.left.equalTo(self.view).offset(200);
        }];

    }return _midView_Style1;
}


@end
