#
# Be sure to run `pod lib lint LPDCollectionViewKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LPDCollectionViewKit'
  s.version          = '0.1.2'
  s.summary          = 'LPDCollectionViewKit, data driven collection view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/foxsofter/lpd-collectionview-kit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'foxsofter' => 'foxsofter@gmail.com' }
  s.source           = { :git => 'https://github.com/foxsofter/lpd-collectionview-kit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LPDCollectionViewKit/Classes/**/*'
  s.private_header_files = 'LPDCollectionViewKit/Classes/LPDCollectionSectionViewModel+Private.h', 'LPDCollectionViewKit/Classes/LPDCollectionViewModel+Private.h'

  # s.resource_bundles = {
  #   'LPDCollectionViewKit' => ['LPDCollectionViewKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ReactiveCocoa', '2.5'
end
