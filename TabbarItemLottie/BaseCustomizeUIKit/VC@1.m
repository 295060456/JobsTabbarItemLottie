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

@property(nonatomic,strong)NSString *titleStr_1;
@property(nonatomic,strong)NSString *titleStr_2;
@property(nonatomic,strong)NSMutableArray <RichLabelFontModel *>*richLabelFontsMutArr;
@property(nonatomic,strong)NSMutableArray <RichLabelTextCorModel *>*richLabelTextCorsMutArr;

@end

@implementation VC_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCyanColor;//RandomColor;
    self.titleStr_1 = @"韩国K联 第26轮";
    self.titleStr_2 = @"2020/09/09 18:00";
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
//        _midView_Style1 = [[UIButton alloc] initWithType:CountDownBtnType_countDown
//                                                          runType:CountDownBtnRunType_auto
//                                                 layerBorderWidth:1
//                                                layerCornerRadius:1
//                                                 layerBorderColor:kClearColor
//                                                       titleColor:kWhiteColor
//                                                    titleBeginStr:@""
//                                                   titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
        
        _midView_Style1 = [[UIButton alloc] initWithType:CountDownBtnType_countDown
                                                 runType:CountDownBtnRunType_auto
                                        layerBorderWidth:1
                                       layerCornerRadius:1
                                        layerBorderColor:kClearColor
                                              titleColor:kWhiteColor
                                           titleBeginStr:@"开始倒计时"
                                          titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]
                                          richLabelFonts:self.richLabelFontsMutArr
                                       richLabelTextCors:self.richLabelTextCorsMutArr
                                     richLabelUnderlines:nil
                                richLabelParagraphStyles:nil
                                           richLabelURLs:nil];
        
        _midView_Style1.titleRuningStr = @"开始倒计时了\n";
        _midView_Style1.showTimeType = ShowTimeType_HHMMSS;
        _midView_Style1.bgCountDownColor = kCyanColor;
        _midView_Style1.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;
        
        [_midView_Style1 timeFailBeginFrom:9999];

        [self.view addSubview:_midView_Style1];
        [_midView_Style1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300, 100));
            make.top.equalTo(self.view).offset(200);
            make.left.equalTo(self.view).offset(50);
        }];

    }return _midView_Style1;
}

-(NSMutableArray<RichLabelFontModel *> *)richLabelFontsMutArr{
    if (!_richLabelFontsMutArr) {
        _richLabelFontsMutArr = NSMutableArray.array;
        
        RichLabelFontModel *model_1 = RichLabelFontModel.new;
        model_1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        model_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelFontModel *model_2 = RichLabelFontModel.new;
        model_2.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        model_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);

        [_richLabelFontsMutArr addObject:model_1];
        [_richLabelFontsMutArr addObject:model_2];
        
    }return _richLabelFontsMutArr;
}

-(NSMutableArray<RichLabelTextCorModel *> *)richLabelTextCorsMutArr{
    if (!_richLabelTextCorsMutArr) {
        _richLabelTextCorsMutArr = NSMutableArray.array;
        
        RichLabelTextCorModel *model_1 = RichLabelTextCorModel.new;
        model_1.cor = kBlueColor;
        model_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelTextCorModel *model_2 = RichLabelTextCorModel.new;
        model_2.cor = KGreenColor;
        model_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        
        [_richLabelTextCorsMutArr addObject:model_1];
        [_richLabelTextCorsMutArr addObject:model_2];
        
    }return _richLabelTextCorsMutArr;
}


@end
