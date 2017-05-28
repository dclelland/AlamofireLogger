#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name                    = "AlamofireLogger"
  s.version                 = "0.2.0"
  s.summary                 = "Tiny Alamofire plugin that logs requests and responses."
  s.homepage                = "https://github.com/dclelland/AlamofireLogger"
  s.license                 = { :type => 'MIT' }
  s.author                  = { "Daniel Clelland" => "daniel.clelland@gmail.com" }
  s.source                  = { :git => "https://github.com/dclelland/AlamofireLogger.git", :tag => "0.2.0" }
  s.platform                = :ios, '8.0'
  s.ios.deployment_target   = '8.0'
  s.ios.source_files        = 'AlamofireLogger.swift'
  s.requires_arc            = true
  
  s.dependency 'Alamofire', '~> 4.0'
end
