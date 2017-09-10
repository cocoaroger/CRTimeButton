# CRTimeButton

### CocoaPods

1. Add `pod 'CRTimeButton'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import <CRTimeButton/CRTimeButton.h>.

### 使用方法

```
    CRTimeButton *button = [CRTimeButton new];
    button.delegate = self;
    button.frame = ...;
    [button setDefaultTitle:@"获取验证码"];
    [button setAgainTitle:@"重新发送"];
    [button setDuration:30];
    [button setCounDownPrifex:@"还剩"];

    #pragma mark - CRTimeButtonDelegate
    - (void)timeButtonClicked:(CRTimeButton *)timeButton {
        // 模拟网络请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [timeButton resetButton]; // 模拟网络发送失败，重置按钮状态
        });
    }
```
