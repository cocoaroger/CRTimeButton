//
//  CRTimeButton.m
//  CRKit
//
//  Created by roger wu on 16/7/15.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "CRTimeButton.h"

static const NSTimeInterval kDefaultDuration = 60;
static NSString * const kDefaultTitle = @"发送验证码";
static NSString * const kDefaultAgainTitle = @"重新发送";

@interface CRTimeButton ()
@end

@implementation CRTimeButton {
    NSInteger _countTime; // 倒计时的值
    dispatch_source_t _timer; // 计时器
}

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
    _duration = kDefaultDuration;
    _defaultTitle = kDefaultTitle;
    _againTitle = kDefaultAgainTitle;
    _counDownPrifex = @"";
    [self setTitle:_defaultTitle forState:UIControlStateNormal];
    [self addTarget:self action:@selector(timeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDuration:(NSTimeInterval)duration {
    if (duration > 0) {
        _duration = duration;
    } else {
        _duration = kDefaultDuration;
    }
    [self setTitle:_defaultTitle forState:UIControlStateNormal];
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

- (void)setCounDownPrifex:(NSString *)counDownPrifex {
    if (counDownPrifex.length > 0) {
        _counDownPrifex = counDownPrifex;
    } else {
        _counDownPrifex = @"";
    }
}

- (void)timeButtonAction:(CRTimeButton *)timeButton {
    if ([self.delegate respondsToSelector:@selector(timeButtonClicked:)]) {
        if (!_countTime) {
            _countTime = _duration;
        }
        
        dispatch_queue_t queue = dispatch_queue_create("CRTIMEBUTTON_QUEUE", DISPATCH_QUEUE_CONCURRENT);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.f * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            _countTime--;
            if (_countTime > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *title = [NSString stringWithFormat:@"%@%@s", _counDownPrifex, @(_countTime)];
                    [self setTitle:title forState:UIControlStateNormal];
                    self.enabled = NO;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setTitle:_againTitle forState:UIControlStateNormal];
                    self.enabled = YES;
                });
                dispatch_cancel(_timer);
            }
        });
        dispatch_resume(_timer);
        self.enabled = NO; // 点击按钮后，按钮的状态设置为不可用
        [self.delegate timeButtonClicked:self];
    } else {
        NSAssert(NO, @"必须设置代理方法!");
    }
}

- (void)invalidateTimer {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = NULL;
    }
}

- (void)resetButton {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = NULL;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.enabled = YES;
            _countTime = self.duration;
            [self setTitle:self.againTitle forState:UIControlStateNormal];
        });
    }
}

- (void)dealloc {
    NSLog(@"____%@____被释放了", [self class]);
}

@end
