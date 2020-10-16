//
//  LongPressGRView.h
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LongPressGRView : UIView

@property(nonatomic,assign)NSInteger tag;

-(void)actionBlockLongPressGRView:(MKDataBlock)longPressGRViewBlock;

@end

NS_ASSUME_NONNULL_END
