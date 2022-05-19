Pod::Spec.new do |s|

s.name             = "SesuatuSDK"
s.version          = "0.1.1"
s.summary          = "a pure swift library compatible with obj-c and swift"
s.homepage         = "https://github.com/uziwuzzy/SesuatuSDK"
s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
s.author           = { "uziwuzzy" => "https://github.com/uziwuzzy/"}
s.source           = { :git => "https://github.com/uziwuzzy/SesuatuSDK.git", :tag => s.version}
s.platform     = :ios
s.ios.deployment_target  = "13.0"
s.swift_version = '5.1'
s.source_files = 'Sources/SesuatuSDK/**/*'
s.dependency "RxAlamofire"
s.dependency "NeedleFoundation"
s.dependency "SnapKit"
s.dependency "RxCocoa"

s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
##s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

##s.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
##s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end