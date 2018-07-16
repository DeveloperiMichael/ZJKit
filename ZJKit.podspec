#
# Be sure to run `pod lib lint ZJKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZJKit'
  s.version          = '0.0.1'
  s.summary          = 'A short description of ZJKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/DeveloperiMichael/ZJKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DeveloperiMichael' => 'michael.zhang@wwwarehouse.com' }
  s.source           = { :git => 'https://github.com/DeveloperiMichael/ZJKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZJKit/Classes/**/*.{h,m}'
  s.resources = 'ZJKit/Assets/ZJKit.xcassets'

  # s.resource_bundles = {
  #   'ZJKit' => ['ZJKit/Assets/*.png']
  # }

#UI布局约束
  s.dependency 'Masonry'

#与H5交互
  s.dependency 'WebViewJavascriptBridge'

#图片加载
  s.dependency 'SDWebImage'

#列表分页加载
  s.dependency 'MJRefresh'

#键盘处理
s.dependency 'IQKeyboardManager'

s.dependency 'SSToolkit'

  s.requires_arc = true

end
