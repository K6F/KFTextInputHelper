#
# Be sure to run `pod lib lint KFTextInputHelper.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KFTextInputHelper"
  s.version          = "0.2.1"
  s.summary          = "A short description of KFTextInputHelper."
  s.description      = <<-DESC
                       An optional longer description of KFTextInputHelper

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/K6F/KFTextInputHelper"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "K6F" => "fan.kaiyuan@gmail.com" }
  s.source           = { :git => "https://github.com/K6F/KFTextInputHelper.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'KFTextInputHelper' => ['Pod/Assets/*.png']
  }
  # s.public_header_files = 'Pod/Classes/**/*.h'
end
