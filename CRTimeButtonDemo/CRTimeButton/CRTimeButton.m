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
    NSInteger _timeCount; // 倒计时的值
    NSTimer *_timer; // 计时器
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
    _timeCount = 0;
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
        _timeCount = _duration;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timeCounting)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [self timeCounting];
        [self.delegate timeButtonClicked:self];
    } else {
        NSAssert(NO, @"必须设置代理方法才可用!");
    }
}

- (void)timeCounting {
    if (_timeCount > 0) {
        NSString *title = [NSString stringWithFormat:@"%@%@s", _counDownPrifex, @(_timeCount)];
        [self setTitle:title forState:UIControlStateNormal];
        self.enabled = NO;
        _timeCount--;
    } else {
        [self setTitle:_againTitle forState:UIControlStateNormal];
        self.enabled = YES;
        [self invalidateTimer];
    }
}

- (void)invalidateTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = NULL;
    }
}

- (void)resetButton {
    [self invalidateTimer];
    self.enabled = YES;
    [self setTitle:self.againTitle forState:UIControlStateNormal];
}

- (void)dealloc {
    NSLog(@"____%@____被释放", [self class]);
}

@end
