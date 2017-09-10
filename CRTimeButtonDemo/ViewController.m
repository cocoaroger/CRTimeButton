//
//  ViewController.m
//  CRTimeButtonDemo
//
//  Created by roger wu on 10/09/2017.
//  Copyright © 2017 cocoaroger. All rights reserved.
//

#import "ViewController.h"
#import "CRTimeButton.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

static const CGFloat kNavigationH = 64;

static const CGFloat kButtonX = 100;
static const CGFloat kButtonMargin = 20;
static const CGFloat kButtonW = 100;
static const CGFloat kButtonH = 44;

@interface ViewController ()<CRTimeButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(230, 230, 230, 1);
    
    CGFloat firstButtonY = kNavigationH+kButtonMargin;
    for (NSInteger i = 0; i < 2; i ++) {
        CRTimeButton *button = [CRTimeButton new];
        button.delegate = self;
        button.frame = CGRectMake(kButtonX, firstButtonY + (kButtonH+kButtonMargin) * i,
                                  kButtonW, kButtonH);
        [self.view addSubview:button];
        
        switch (i) {
            case 0: {
                // 默认样式
                break;
            }
            case 1: {
                // 样式1
                [button setDefaultTitle:@"获取验证码"];
                [button setAgainTitle:@"重新发送"];
                [button setDuration:30];
                [button setCounDownPrifex:@"还剩"];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button setTitleColor:rgba(100,149,237,1) forState:UIControlStateNormal];
                [button setTitleColor:rgba(100,149,237,0.5) forState:UIControlStateHighlighted];
                [button setTitleColor:rgba(192,192,192,1) forState:UIControlStateDisabled];
                break;
            }
            default: {
                break;
            }
        }
    }
    
}

#pragma mark - CRTimeButtonDelegate
- (void)timeButtonClicked:(CRTimeButton *)timeButton {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timeButton resetButton]; // 模拟网络发送失败，重置按钮状态
    });
}


@end
