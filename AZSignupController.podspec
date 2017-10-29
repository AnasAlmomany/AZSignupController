Pod::Spec.new do |s|
  s.name             = 'AZSignupController'
  s.version          = '0.1.0'
  s.summary          = 'Simple, but beautiful video-based Signup View Controller.'

  s.description      = <<-DESC
Simple, but beautiful video-based Signup View Controller by Azurcoding.
                       DESC

  s.homepage         = 'https://github.com/azurcoding/AZSignupController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Azurcoding'
  s.source           = { :git => 'https://github.com/azurcoding/AZSignupController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/azurcoding'

  s.ios.deployment_target = '10.0'

  s.source_files = 'AZSignupController/Classes/*'
  s.frameworks = 'UIKit', 'AVFoundation'
  s.dependency 'TinyConstraints'
end
