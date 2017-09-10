//
//  CRTimeButton.m
//  CRKit
//
//  Created by roger wu on 16/7/15.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "CRTimeButton.h"

/**
 *  默认倒计时时长
 */
static const NSTimeInterval kDefaultTimeInterval = 60;

static NSString * const kDefaultTitle = @"发送验证码";

static NSString * const kDefaultAgainTitle = @"重新发送";

@interface CRTimeButton ()

/**
 *  倒计时的值
 */
@property (nonatomic, assign) NSInteger countTime;

/**
 *  计时器
 */
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation CRTimeButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.defaultTitle = kDefaultTitle;
    [self setTitle:self.defaultTitle forState:UIControlStateNormal];
    self.againTitle = kDefaultAgainTitle;
    [self addTarget:self action:@selector(timeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDefaultTitle:(NSString *)defaultTitle {
    if (defaultTitle.length > 0) {
        _defaultTitle = defaultTitle;
    } else {
        _defaultTitle = kDefaultTitle;
    }
    [self setTitle:_defaultTitle forState:UIControlStateNormal];
}

- (void)setAgainTitle:(NSString *)againTitle {
    if (againTitle.length > 0) {
        _againTitle = againTitle;
    } else {
        _againTitle = kDefaultAgainTitle;
    }
}

- (void)timeButtonAction:(CRTimeButton *)timeButton {
    if ([self.delegate respondsToSelector:@selector(timeButtonClicked:)]) {
        if (!self.countTime) {
            self.countTime = kDefaultTimeInterval;
        }
        
        // 使用GCD定时
        __weak __typeof(&*self) weakSelf = self;
        dispatch_queue_t queue = dispatch_queue_create("CRTIMEBUTTON_QUEUE", DISPATCH_QUEUE_CONCURRENT);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.f * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            weakSelf.countTime--;
            
            if (weakSelf.countTime > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *title = [NSString stringWithFormat:@"还剩%@s", @(weakSelf.countTime)];
                    [weakSelf setTitle:title forState:UIControlStateNormal];
                    weakSelf.enabled = NO;
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setTitle:weakSelf.againTitle forState:UIControlStateNormal];
                    weakSelf.enabled = YES;
                });
                dispatch_cancel(weakSelf.timer);
            }
        });
        
        dispatch_resume(self.timer);
        self.enabled = NO; // 点击按钮后，按钮的状态设置为不可用
        [self.delegate timeButtonClicked:self];
    } else {
        NSAssert(NO, @"请不要忘记设置代理方法");
    }
}

- (void)invalidateTimer {
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = NULL;
    }
}

- (void)resetButton {
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = NULL;
        
        __weak __typeof(&*self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.enabled = YES;
            weakSelf.countTime = kDefaultTimeInterval;
            [weakSelf setTitle:self.againTitle forState:UIControlStateNormal];
        });
    }
}

- (void)dealloc {
    NSLog(@"____%@____被释放了", [self class]);
}

@end
