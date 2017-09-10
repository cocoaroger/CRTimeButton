Pod::Spec.new do |s|
  s.name         = "CRTimeButton" # 项目名称
  s.version      = "0.0.1"        # 版本号 与 你仓库的 标签号 对应
  s.license      = { :type => 'MIT', :file => 'LICENSE' }          # 开源证书
  s.summary      = "A Verification Code Time Button" # 项目简介

  s.homepage     = "https://github.com/cocoaroger" # 你的主页
  s.source       = { :git => "https://github.com/cocoaroger/CRTimeButton.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
  s.source_files = "CRTimeButton/*.{h,m}" # 你代码的位置， BYPhoneNumTF/*.{h,m} 表示 BYPhoneNumTF 文件夹下所有的.h和.m文件
  s.requires_arc = true # 是否启用ARC
  s.platform     = :ios, "8.0" #平台及支持的最低版本
  s.frameworks   = "UIKit", "Foundation" #支持的框架

  # User
  s.author             = { "cocoaroger" => "cocoaroger@163.com" } # 作者信息
  s.social_media_url   = "https://cocoaroger.github.io/" # 个人主页

end
