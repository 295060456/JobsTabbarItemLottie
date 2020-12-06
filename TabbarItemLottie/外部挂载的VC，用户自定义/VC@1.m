//
//  VC@1.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/13.
//  Copyright © 2020 xa. All rights reserved.
//

#import "VC@1.h"
#import "UIButton+CountDownBtn.h"

#import "TimeModel.h"

@interface VC_1 ()

@property(nonatomic,strong)UIButton *midView_Style1;//自启动模式
@property(nonatomic,strong)UIButton *midView_Style2;//手动启动模式

@property(nonatomic,strong)NSString *titleStr_1;
@property(nonatomic,strong)NSString *titleStr_2;
@property(nonatomic,strong)NSMutableArray <RichLabelDataStringsModel *>*richLabelDataStringsMutArr;

@end

@implementation VC_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCyanColor;//RandomColor;
    self.titleStr_1 = @"开始";
    self.titleStr_2 = @"倒计时";
    self.midView_Style1.alpha = 1;
    self.midView_Style2.alpha = 1;
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
    
    UILabel *lab = UILabel.new;
    
    [NSObject makeRichTextWithDataConfigMutArr:self.richLabelDataStringsMutArr];
    
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 100));
        make.top.equalTo(self.view).offset(200);
        make.left.equalTo(self.view).offset(50);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",[TimeModel whatDayOfWeekDistanceNow:0]);
//
//    [UIViewController comingFromVC:self
//                              toVC:VC_9.new
//                       comingStyle:ComingStyle_PUSH
//                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
//                     requestParams:@""
//          hidesBottomBarWhenPushed:YES
//                          animated:YES
//                           success:^(id data) {
//
//    }];
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
        
        _midView_Style1 = [[UIButton alloc] initWithRichTextRunningDataMutArr:self.richLabelDataStringsMutArr
                                                             countDownBtnType:CountDownBtnType_countDown
                                                                      runType:CountDownBtnRunType_auto
                                                             layerBorderWidth:1
                                                            layerCornerRadius:1
                                                             layerBorderColor:kClearColor
                                                                   titleColor:kWhiteColor
                                                                titleBeginStr:@""
                                                               titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];

        _midView_Style1.titleRuningStr = @"开始倒计时了";
        _midView_Style1.showTimeType = ShowTimeType_SS;
        _midView_Style1.bgCountDownColor = kCyanColor;
        _midView_Style1.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_front;
        _midView_Style1.countDownBtnNewLineType = CountDownBtnNewLineType_normal;
        
        [_midView_Style1 timeFailBeginFrom:9999];

        [self.view addSubview:_midView_Style1];
        [_midView_Style1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300, 100));
            make.top.equalTo(self.view).offset(200);
            make.left.equalTo(self.view).offset(50);
        }];

    }return _midView_Style1;
}

-(UIButton *)midView_Style2{
    if (!_midView_Style2) {
//        _midView_Style2 = [[UIButton alloc] initWithType:CountDownBtnType_countDown
//                                                          runType:CountDownBtnRunType_auto
//                                                 layerBorderWidth:1
//                                                layerCornerRadius:1
//                                                 layerBorderColor:kClearColor
//                                                       titleColor:kWhiteColor
//                                                    titleBeginStr:@""
//                                                   titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
        
        _midView_Style2 = [[UIButton alloc] initWithRichTextRunningDataMutArr:self.richLabelDataStringsMutArr
                                                             countDownBtnType:CountDownBtnType_countDown
                                                                      runType:CountDownBtnRunType_manual
                                                             layerBorderWidth:1
                                                            layerCornerRadius:1
                                                             layerBorderColor:kClearColor
                                                                   titleColor:kWhiteColor
                                                                titleBeginStr:@""
                                                               titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];

        _midView_Style2.titleRuningStr = @"开始倒计时了";
        _midView_Style2.count = 60;
        _midView_Style2.showTimeType = ShowTimeType_SS;
        _midView_Style2.bgCountDownColor = kCyanColor;
        _midView_Style2.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;
        _midView_Style2.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;

        [self.view addSubview:_midView_Style2];
        [_midView_Style2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300, 100));
            make.top.equalTo(self.midView_Style1).offset(200);
            make.left.equalTo(self.view).offset(50);
        }];

    }return _midView_Style1;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)richLabelDataStringsMutArr{
    if (!_richLabelDataStringsMutArr) {
        _richLabelDataStringsMutArr = NSMutableArray.array;
        
        RichLabelFontModel *richLabelFontModel_1 = RichLabelFontModel.new;
        richLabelFontModel_1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        richLabelFontModel_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelFontModel *richLabelFontModel_2 = RichLabelFontModel.new;
        richLabelFontModel_2.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        richLabelFontModel_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        
        RichLabelTextCorModel *richLabelTextCorModel_1 = RichLabelTextCorModel.new;
        richLabelTextCorModel_1.cor = kBlueColor;
        richLabelTextCorModel_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelTextCorModel *richLabelTextCorModel_2 = RichLabelTextCorModel.new;
        richLabelTextCorModel_2.cor = kRedColor;
        richLabelTextCorModel_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        //////
        
        RichLabelDataStringsModel *richLabelDataStringsModel_1 = RichLabelDataStringsModel.new;
        richLabelDataStringsModel_1.dataString = self.titleStr_1;
        richLabelDataStringsModel_1.richLabelFontModel = richLabelFontModel_1;
        richLabelDataStringsModel_1.richLabelTextCorModel = richLabelTextCorModel_1;
        
        RichLabelDataStringsModel *richLabelDataStringsModel_2 = RichLabelDataStringsModel.new;
        richLabelDataStringsModel_2.dataString = self.titleStr_2;
        richLabelDataStringsModel_2.richLabelFontModel = richLabelFontModel_2;
        richLabelDataStringsModel_2.richLabelTextCorModel = richLabelTextCorModel_2;
        
        [_richLabelDataStringsMutArr addObject:richLabelDataStringsModel_1];
        [_richLabelDataStringsMutArr addObject:richLabelDataStringsModel_2];
        
    }return _richLabelDataStringsMutArr;
}


@end
