# CRTimeButton

在按钮回调方法中发出网络请求
`
#pragma mark - CRTimeButtonDelegate
- (void)timeButtonClicked:(CRTimeButton *)timeButton {
    // 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timeButton resetButton]; // 模拟网络发送失败，重置按钮状态
    });
}
`
