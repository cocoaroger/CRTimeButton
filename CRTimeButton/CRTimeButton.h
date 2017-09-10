//
//  CRTimeButton.h
//  CRKit
//
//  Created by roger wu on 16/7/15.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CRTimeButtonDelegate;

/**
 *  发送验证码，倒计时按钮
 */
@interface CRTimeButton : UIButton

/**
 *  普通状态的标题，默认是"发送验证码"
 */
@property (nonatomic, copy) NSString *defaultTitle;

/**
 *  设置重新发送的按钮标题，默认是"重新发送"
 */
@property (nonatomic, copy) NSString *againTitle;

@property (nonatomic, weak) id<CRTimeButtonDelegate> delegate;



/**
 *  关闭定时器,在控制器dealloc的方法中要记得调用
 */
- (void)invalidateTimer;

/**
 *  重置按钮状态为"重新发送"
 */
- (void)resetButton;

@end


@protocol CRTimeButtonDelegate <NSObject>
/**
 *  点击按钮回调
 *
 *  @param timeButton 按钮
 */
- (void)timeButtonClicked:(CRTimeButton *)timeButton;

@end