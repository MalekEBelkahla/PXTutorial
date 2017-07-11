#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PXTutorial'
  s.version          = '0.1.0'
  s.summary          = 'PXTutorial provides a configurable JSON file and programmatic interface to define the steps of a tutorial.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
PXTutorial provides a configurable JSON file and programmatic interface to define the steps of a tutorial. Each step contains image, headline and text, additionally it can contain a link and a close button. The link can be used to open an external web link. The close button can be used to redirect users to the next view.
                       DESC

  s.homepage         = 'https://github.com/MalekEBelkahla/PXTutorial'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Malek Belkahla" => "malek.belkahla@proxym-it.com" }
  s.source           = { :git => 'https://github.com/MalekEBelkahla/PXTutorial.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Classes/**/*'
  
  s.resource_bundles = {
    'PXTutorial' => ['Assets/*.{png,storyboard}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
