#
# Be sure to run `pod lib lint HYFramework-OC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  # 库名称
  s.name             = 'HYFramework-OC'

  # 指定支持的平台和版本，不写则默认支持所有的平台，如果支持多个平台，则使用下面的deployment_target定义
  #spec.platform      = :ios

  # 版本号
  s.version          = '1.1.0'

  # 库简短介
  s.summary          = '自定义OC开发工具集'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  # 开源库描述
  s.description      = <<-DESC
一套自定义的OC开发工具集
                       DESC

  # 开源库地址，或者是博客、社交地址等
  s.homepage         = 'https://github.com/mrchenyoung/HYFramework-OC'

  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  
  # 开源协议
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  # 开源库作者
  s.author           = { 'mrchenyoung' => 'chenhuiyiyoung@163.com' }

  # 开源库GitHub的路径与tag值，GitHub路径后必须有.git,tag实际就是上面的版本
  s.source           = { :git => 'https://github.com/mrchenyoung/HYFramework-OC.git', :tag => s.version.to_s }

  # 社交网址
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'


  # 开源库最低支持
  s.ios.deployment_target = '9.0'

  # 源库资源文件
  s.source_files = 'HYFramework-OC/Classes/**/*'
  
  # 是否支持arc
  s.requires_arc = true
  # 资源文件
  s.resource_bundles = {
    'HYFramework-OC' => ['HYFramework-OC/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  # 依赖系统库
  # s.frameworks = 'UIKit', 'MapKit'
  
  # 依赖的开源库

  # 网络库
  s.dependency 'AFNetworking', '~>3.2.1'
  # 自动布局
  s.dependency 'Masonry', '~>1.1.0'
  # 加载蒙板
  s.dependency 'MBProgressHUD', '~>1.2.0'
  # tableView刷新控件
  s.dependency 'MJRefresh', '~>3.5.0'
  # 字典转模型
  s.dependency 'YYModel', '~>1.0.4'
  # 图片选择/预览
  s.dependency 'ZLPhotoBrowser', '~>3.2.0'

end
