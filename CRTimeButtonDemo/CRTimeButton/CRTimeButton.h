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
 *  发送验证码-倒计时
 */
@interface CRTimeButton : UIButton

// 可选
@property (nonatomic, assign) NSTimeInterval duration; // 倒计时时间，默认60s
@property (nonatomic, copy) NSString *defaultTitle; // 普通状态的标题，默认`发送验证码`
@property (nonatomic, copy) NSString *againTitle; // 设置重新发送的按钮标题，默认`重新发送`
@property (nonatomic, copy) NSString *counDownPrifex; // 倒计时前缀，默认无，例如：`还剩`,将显示为`还剩59s`

// 必填
@property (nonatomic, weak) id<CRTimeButtonDelegate> delegate;

/**
 *  关闭定时器,在 controller dealloc 中要记得调用,否则会内存泄露
 */
- (void)invalidateTimer;
/**
 *  重置按钮状态为`againTitle`
 */
- (void)resetButton;
@end

@protocol CRTimeButtonDelegate <NSObject>
/**
 *  点击按钮回调,可在这个回调方法中发出网络请求
 *
 *  @param timeButton 按钮
 */
- (void)timeButtonClicked:(CRTimeButton *)timeButton;

@end
