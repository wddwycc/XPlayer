#
# Be sure to run `pod lib lint XPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XPlayer'
  s.version          = '0.2.0'
  s.summary          = 'PIP Video player for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wddwycc/XPlayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wddwycc' => 'wddwyss@gmail.com' }
  s.source           = { :git => 'https://github.com/wddwycc/XPlayer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wddwycc'

  s.ios.deployment_target = '10.0'

  s.source_files = 'XPlayer/Classes/**/*'
  
  s.resource_bundles = {
    'XPlayer' => ['XPlayer/Assets/*.png']
  }

  s.dependency 'TinyConstraints', '~>3.0'
end
